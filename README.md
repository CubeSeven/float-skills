# float-skills

Portable brochure-site rules for AI coding agents.

## Start a new brochure site

Paste this **one prompt** into your AI coding agent:

> Use `https://github.com/CubeSeven/float-skills` as the brochure-site rules library. **Start.**

The agent reads `BROCHURE-SITE-RULES.md`, then asks everything it needs: business details, reference links, pages, design direction, assets, languages, and whether to use optional stock photos. It proposes the structure before building.

> Your agent needs access to the URL (or clone the repository locally first). If it cannot read GitHub URLs, give it the local repository path instead.

No template pages are forced. The brief and answers decide the site.

## Current stack (verified 2026-09-03 — re-check with `npm view <pkg> version` before each project)

The rules file pins no versions on purpose; this table is a snapshot to sanity-check against, not a source of truth.

| Layer | Package | Verified latest |
|---|---|---|
| Framework | `astro` | 7.2.10 |
| CSS | `tailwindcss` + `@tailwindcss/vite` | 4.3.3 |
| Slider/carousel | `swiper` | 14.2.0 |
| Icons | `lucide-react` / `@lucide/astro` | 1.39.0 |
| Astro × React | `@astrojs/react` | 6.0.5 |
| Motion (React sites) | `framer-motion` | 13.2.0 |
| Sitemap | `@astrojs/sitemap` | latest |
| TypeScript | `typescript` | newest **6.x** (NOT 7.x — `@astrojs/check` compat) |
| Node (engines) | — | ≥ 22.12.0 |

Before scaffolding: `npm view <pkg> version` for each — use what npm reports today, never versions from an older project.

## Optional local setup

```bash
git clone https://github.com/CubeSeven/float-skills.git
```

Then use this prompt instead:

> Use the rules library at `/path/to/float-skills`. **Start.**

Use only one tool pointer if your agent requires it: `AGENTS.md`, `CLAUDE.md`, or `.cursorrules`. The master file remains `BROCHURE-SITE-RULES.md`.
