# float-skills

Portable rules for building **brochure websites** the Float Creatives way.

This repository is intentionally **just Markdown**. No code, no build step.
Drop these files into (or alongside) any new client website and your AI coding
tool will follow the same conventions automatically.

## What's inside

| File | Why it exists |
|---|---|
| `BROCHURE-SITE-RULES.md` | The master rulebook: stack, must-work interactive behavior, content model, SEO, accessibility, build gate. **Read this first.** |
| `AGENTS.md` | Pointer to the rules for GitHub Copilot / generic agents |
| `CLAUDE.md` | Pointer to the rules for Claude Code |
| `.cursorrules` | Pointer to the rules for Cursor |
| `CLIENT-BRIEF.md` | A fill-once form; hand it to the AI with the rules |
| `README.md` | This file |

## How to use it

1. **Start a new client site** in your normal way (Astro, plain HTML, whatever
   the brief calls for).
2. **Copy these files** into that project:
   - `BROCHURE-SITE-RULES.md` (required)
   - the matching pointer for your tool (`AGENTS.md`, `CLAUDE.md`, or
     `.cursorrules`)
   - `CLIENT-BRIEF.md`
3. **Fill in `CLIENT-BRIEF.md`** with the business facts.
4. **Tell the AI**: "Build this brochure site from `CLIENT-BRIEF.md` and
   `BROCHURE-SITE-RULES.md`. Propose the page structure before coding."
5. The AI follows the rules and builds **only the pages the brief needs** —
   no forced services/gallery/contact template.

## Why the rules file is the whole point

Different AI tools look for different filenames (`AGENTS.md`, `CLAUDE.md`,
`.cursorrules`). They all just point back to `BROCHURE-SITE-RULES.md`, so you
keep **one source of truth** and every tool behaves the same.

## Notes

- The rules assume Astro + Tailwind v4 by default but are written so the agent
  can adapt to another stack if the brief requires it.
- Keep business facts in a single data file; never hardcode phone/email/address
  in components.
- No fake reviews, no invented bookings, no analytics/pixels unless the client
  explicitly asks.
