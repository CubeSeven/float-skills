# Architecture

## The simple model

```text
Brief + reference links
        ↓
BROCHURE-SITE-RULES.md  (AI behaviour contract)
        ↓
src/data/              (all business facts/content)
        ↓
src/components/        (reusable visual blocks)
        ↓
src/pages/             (routes)
        ↓
Astro static build → dist/
```

## Rules

- `src/data/` is the only place business facts live.
- Components never hardcode telephone, email, address, or service copy.
- `SITE` in `src/data/site.config.ts` drives SEO, canonical links, schema, navigation, and contact links.
- `scripts/` automate repetitive work: images, validation, rules sync, and hand-off documentation.

## Project lifecycle

1. `npm run setup` creates the project and installs dependencies.
2. Give an AI agent the brief / reference links. It reads `AGENTS.md` or `CLAUDE.md`.
3. Replace data and images; the layout updates automatically.
4. `npm run validate && npm run build` before deployment.

## Why the template intentionally stays small

It contains working patterns—not 30 unnecessary components. Each client gets its own visual direction from the brief while retaining the proven interactive and SEO foundations.
