#!/usr/bin/env bash
set -euo pipefail

# UI/UX Pro Max Skill Installer
#
# [REPHLEX] Rephlex Digital fork. Changes from upstream:
#   - Installs from local repo checkout (no npm/git clone)
#   - Uses symlinks instead of copies
#   - Main 'ui-ux-pro-max' skill uses real dir with absolute symlinks
#     (upstream relative symlinks break when resolved from ~/.claude/skills/)
#   - All fork changes marked with [REPHLEX]

main() {
    SKILLS_DIR="${HOME}/.claude/skills"
    REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
    SKILL_SOURCE="${REPO_DIR}/.claude/skills"
    SRC_DIR="${REPO_DIR}/src/ui-ux-pro-max"

    echo "════════════════════════════════════════"
    echo "║   UI/UX Pro Max - Installer          ║"
    echo "║   Design Intelligence Skill          ║"
    echo "║   [Rephlex fork — symlink mode]      ║"
    echo "════════════════════════════════════════"
    echo ""
    echo "Repo: ${REPO_DIR}"
    echo ""

    # Check prerequisites
    command -v python3 >/dev/null 2>&1 || { echo "✗ Python 3 is required but not installed."; exit 1; }
    echo "✓ Python 3 detected"

    # Create skills directory
    mkdir -p "${SKILLS_DIR}"

    # Helper: create symlink, back up existing non-symlink targets
    symlink_item() {
        local source="$1"
        local target="$2"
        local name="$3"
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            mv "$target" "${target}.bak"
            echo "  ~ backed up existing ${name}"
        fi
        ln -sfn "$source" "$target"
        echo "  + ${name}"
    }

    # [REPHLEX] ── BEGIN FORK CHANGES ──────────────────────────────────

    # Sub-skills: direct symlinks (no internal relative symlinks to worry about)
    echo "→ Installing sub-skills (symlinks)..."
    for skill_dir in "${SKILL_SOURCE}"/*/; do
        [ -d "${skill_dir}" ] || continue
        skill_name=$(basename "${skill_dir}")
        # Main skill handled separately below
        [ "${skill_name}" = "ui-ux-pro-max" ] && continue
        symlink_item "${skill_dir}" "${SKILLS_DIR}/${skill_name}" "${skill_name}"
    done

    # Main 'ui-ux-pro-max' skill: real directory with absolute symlinks
    # (upstream uses relative symlinks to ../../../src/ which break from ~/.claude/skills/)
    echo "→ Installing main ui-ux-pro-max skill..."
    MAIN_SKILL="${SKILLS_DIR}/ui-ux-pro-max"
    mkdir -p "${MAIN_SKILL}"

    # Symlink SKILL.md
    symlink_item "${SKILL_SOURCE}/ui-ux-pro-max/SKILL.md" "${MAIN_SKILL}/SKILL.md" "ui-ux-pro-max/SKILL.md"

    # Absolute symlinks to src/ (fixes the relative symlink issue)
    symlink_item "${SRC_DIR}/data" "${MAIN_SKILL}/data" "ui-ux-pro-max/data"
    symlink_item "${SRC_DIR}/scripts" "${MAIN_SKILL}/scripts" "ui-ux-pro-max/scripts"

    # [REPHLEX] ── END FORK CHANGES ────────────────────────────────────

    # Count installed skills
    installed=0
    for skill_name in banner-design brand design design-system slides ui-styling ui-ux-pro-max; do
        if [ -e "${SKILLS_DIR}/${skill_name}" ]; then
            installed=$((installed + 1))
        fi
    done

    echo ""
    echo "✓ UI/UX Pro Max installed successfully! (symlink mode)"
    echo "  Skills: ${installed}/7"
    echo ""
    echo "Skills installed:"
    echo "  /banner-design  — Banner and ad creative design"
    echo "  /brand          — Brand identity and guidelines"
    echo "  /design         — General design (logos, icons, CIP, slides, social)"
    echo "  /design-system  — Design tokens and component systems"
    echo "  /slides         — Presentation slide design"
    echo "  /ui-styling     — UI styling patterns and CSS"
    echo "  /ui-ux-pro-max  — Main orchestrator (67 styles, 161 palettes, 57 fonts)"
    echo ""
    echo "Repo: ${REPO_DIR}"
    echo "INSTALLED:${installed} SKIPPED:0"
}

main "$@"
