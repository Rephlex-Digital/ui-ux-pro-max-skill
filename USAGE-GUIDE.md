# UI/UX Pro Max Skill — Usage Guide for Rephlex Digital

## What This Skill Suite Does

UI/UX Pro Max is a design intelligence system. It doesn't generate final designs on its own — it provides structured design decisions (styles, colors, fonts, layout rules, UX guidelines) that inform and constrain your implementation work. Think of it as a design consultant that lives inside Claude Code.

The suite has **7 skills** organized in a hub-and-spoke pattern: one orchestrator (`ui-ux-pro-max`) and six specialist skills.

---

## Skill Map — When to Use What

| Skill | What It Does | When to Reach For It |
|-------|-------------|---------------------|
| `/ui-ux-pro-max` | Main orchestrator. Searches 161 product types, 67 UI styles, 161 color palettes, 57 font pairings, 99 UX guidelines, 25 chart types. Generates complete design systems. | Starting any new UI project. The first skill you run — everything else builds on its output. |
| `/design` | Unified router for all visual creation: logos, corporate identity (CIP), banners, social photos, icons, slides. Routes to sub-skill or built-in module. | When you need to create a visual asset. This is the dispatcher — it figures out which tool to use. |
| `/brand` | Brand voice, visual identity, messaging frameworks, asset management, consistency audits. | Setting up or auditing brand guidelines. Syncs brand → design tokens → CSS variables. |
| `/design-system` | Design token architecture (primitive → semantic → component), component specs, spacing/typography scales, Tailwind config. Also generates strategic HTML slides. | Building or formalizing a design system. The structural backbone — tokens, scales, variables. |
| `/ui-styling` | Implementation skill. shadcn/ui components + Tailwind CSS + canvas-based visual design. | Writing actual UI code. The hands-on builder that turns design decisions into components. |
| `/banner-design` | Multi-format banner creation: social covers, ad banners, website heroes, print. 22+ styles, platform-specific safe zones and dimensions. | Creating banner/cover/header graphics for social media, ads, or websites. |
| `/slides` | Strategic HTML presentations with Chart.js, layout patterns, and copywriting formulas. | Building pitch decks, client presentations, or data-driven slide decks. |

---

## The Typical Workflow

Most design work follows this sequence. You don't always need every step — match the depth to the task.

### 1. Generate a Design System (`/ui-ux-pro-max`)

Always start here for new projects or significant UI work. The `--design-system` flag runs a multi-domain search and returns a complete recommendation.

```
/ui-ux-pro-max
```

Then run the design system generator:

```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "ecommerce children toys playful" --design-system -p "Poppyseed Play"
```

**What you get back:**
- Recommended UI style (e.g., "Playful Minimalism")
- Color palette with hex codes
- Font pairing with Google Fonts import
- Layout pattern (hero structure, CTA strategy)
- Effects (shadows, radius, blur)
- Anti-patterns to avoid

**Persist it for multi-session work:**
```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "ecommerce children toys" --design-system --persist -p "Poppyseed Play"
```

This creates `design-system/MASTER.md` that other skills and future sessions can reference.

### 2. Deep-Dive Specific Domains (still `/ui-ux-pro-max`)

After the design system, drill into specific areas:

```bash
# Color options for a specific industry
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "children toys colorful" --domain color

# Font pairings
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "playful friendly rounded" --domain typography

# UX best practices
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "ecommerce cart checkout" --domain ux

# Chart recommendations for dashboards
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "sales analytics" --domain chart
```

### 3. Create Visual Assets (`/design`, `/banner-design`, `/slides`)

Now that you have design decisions, create assets:

```
/design logo         — Generate a logo with AI (55+ styles, Gemini)
/design cip          — Corporate identity: business cards, letterheads, etc.
/banner-design       — Social covers, ad banners, hero images
/slides create       — Pitch decks and presentations
```

### 4. Build the UI (`/ui-styling`, `/design-system`)

Turn design decisions into code:

```
/ui-styling          — Build components with shadcn/ui + Tailwind
/design-system       — Generate design tokens, CSS variables, Tailwind config
```

---

## Rephlex Digital Use Cases

### Client Website Redesign (Shopify/Web)

**Scenario:** Planning visual direction for a client's Shopify store.

1. `/ui-ux-pro-max` — Generate design system for their industry + brand personality
2. Search `--domain color` and `--domain typography` for options to present to client
3. `/brand` — Document the chosen brand guidelines
4. `/design-system` — Generate tokens that map to their Shopify theme variables

### Client Pitch Deck

**Scenario:** Building a proposal deck for a prospective client.

1. `/slides create` — Strategic HTML slides with Chart.js data viz
2. `/banner-design` — Create a hero/cover slide visual
3. Pair with `/pptx` skill if they need PowerPoint format

### Amazon Listing Visuals

**Scenario:** Planning A+ Content or Storefront design for Sertodo/client.

1. `/ui-ux-pro-max` — Search `--domain color "copper artisan handcrafted"` for palette guidance
2. `/banner-design` — Create lifestyle/brand story banner mockups
3. Reference the UX guidelines (especially accessibility and contrast rules) for Amazon's image requirements

### Dashboard / Internal Tool UI

**Scenario:** Building the ops dashboard, CRM, or any internal Rephlex tool.

1. `/ui-ux-pro-max` — `"saas dashboard admin dark mode"` with `--design-system`
2. `/design-system` — Generate the full token architecture
3. `/ui-styling` — Implement with shadcn/ui components
4. Search `--domain chart` for data visualization recommendations

### Social Media Creative

**Scenario:** Creating social posts, covers, or ad creative.

1. `/banner-design` — Supports Facebook, Twitter/X, LinkedIn, YouTube, Instagram, Pinterest, TikTok, Google Display
2. `/design` — Route to social photos module for platform-specific image generation
3. `/brand` — Pull brand context to ensure consistency

---

## Available Search Domains

These are the databases you can query through the `--domain` flag:

| Domain | Records | What You Get |
|--------|---------|-------------|
| `product` | 161 types | Industry-specific UI patterns and recommendations |
| `style` | 67 styles | Visual styles (glassmorphism, brutalism, minimalism, etc.) with CSS keywords and AI prompts |
| `color` | 161 palettes | Color schemes by industry/product type |
| `typography` | 57 pairings | Heading + body font combos with Google Fonts imports |
| `google-fonts` | Individual | Search specific Google Fonts by characteristics |
| `landing` | Patterns | Page structures, hero layouts, CTA strategies |
| `chart` | 25 types | Chart type recommendations by data type |
| `ux` | 99 guidelines | Best practices organized by priority (accessibility first) |
| `prompt` | Per-style | AI generation prompts and CSS keywords for each style |
| `react` | Tips | React/Next.js performance patterns |
| `web` | Guidelines | Platform-specific UI guidelines (iOS HIG, Material Design) |

---

## Available Tech Stacks

The `--stack` flag gives implementation-specific guidance:

`html-tailwind` (default), `react`, `nextjs`, `astro`, `vue`, `nuxtjs`, `nuxt-ui`, `svelte`, `swiftui`, `react-native`, `flutter`, `shadcn`, `jetpack-compose`

```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "navigation responsive" --stack react
```

---

## Key Things to Know

**The search engine uses BM25 ranking.** Multi-dimensional keywords get better results. Instead of "app", try "entertainment social vibrant content-dense".

**Design system generation is the core feature.** The `--design-system` flag does a parallel search across product, style, color, typography, and landing domains, then applies 161 reasoning rules to pick the best matches. Always start here.

**No external dependencies required.** The search scripts are pure Python 3 — no pip install needed.

**UX guidelines are priority-ordered.** When reviewing UI, work through the priorities: (1) Accessibility, (2) Touch/Interaction, (3) Performance, (4) Style, (5) Layout, (6) Typography/Color, (7) Animation, (8) Forms, (9) Navigation, (10) Charts.

**The `/design` skill is a router.** It doesn't do the work itself — it dispatches to the right sub-module (logo, CIP, banners, social photos, icons, slides). Use it when you're not sure which specific skill to call.

---

## Quick Command Reference

```bash
# Generate a complete design system
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "KEYWORDS" --design-system -p "Project"

# Persist for multi-session use
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "KEYWORDS" --design-system --persist -p "Project"

# Search a specific domain
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "KEYWORDS" --domain <domain>

# Get stack-specific guidance
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "KEYWORDS" --stack <stack>

# Output as markdown (default is ASCII box)
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "KEYWORDS" --design-system -f markdown
```

---

## Relationship to Existing Rephlex Skills

| Existing Skill | How UI/UX Pro Max Complements It |
|---------------|--------------------------------|
| `/brand-voice` | brand-voice defines tone; `/brand` here defines visual identity. Use both for full brand guidelines. |
| `/copywriting` | Copywriting writes the words; `/ui-styling` + `/design-system` style how those words appear. |
| `/pptx` | `/pptx` handles PowerPoint files; `/slides` creates HTML presentations with Chart.js and strategic layouts. |
| `/seo-image-gen` | seo-image-gen creates SEO assets (OG images, hero images); `/banner-design` creates marketing/social creative. |
| `/page-cro` | page-cro optimizes conversion; `/ui-ux-pro-max` UX guidelines ensure the page is usable first. |
