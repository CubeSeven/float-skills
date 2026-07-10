# Troubleshooting

## `npm run build` fails because an icon is missing

Install the selected Iconify set:

```bash
npm install @iconify-json/lucide
```

## Lightbox markup exists but is invisible

The overlay CSS must be in `src/styles/global.css`, not in a scoped component `<style>` block. This is already fixed in the template.

## Mobile menu is clipped to the header

Keep `#mobile-menu` a sibling of `<header>`, not inside it. A transformed/backdrop-filtered header creates a clipping stacking context.

## Client images are huge or slow

```bash
npm run optimize-images dir Images/
```

Then choose the generated WebP files from `Images/optimized/` for your gallery data.

## Unsplash request says key missing

Copy `.env.example` to `.env` and set `UNSPLASH_ACCESS_KEY`. Do not commit `.env`.

## AI tool ignores the rules

From the project root run:

```bash
bash scripts/sync-rules.sh
```

Then restart the AI tool/session so it re-reads `AGENTS.md`, `CLAUDE.md`, or `.cursorrules`.

## Build passes but placeholder content remains

That is allowed during a client-preview stage. Run `npm run post-setup` to refresh the checklist, then inspect `POST-SETUP.md` before launch.
