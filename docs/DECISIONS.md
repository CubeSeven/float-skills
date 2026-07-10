# Technical decisions

| Choice | Why |
|---|---|
| Astro static output | Fast, cheap hosting, minimal JavaScript by default—ideal for 3–15 page brochure sites. |
| Tailwind CSS v4 | Tokens live in one theme file; efficient styling without a component-library lock-in. |
| TypeScript data files | One editable source for business facts; no duplicate NAP strings. |
| Vanilla interactivity | Mobile menus, FAQ, reveal animations and small lightboxes do not need React. |
| Sharp | Reliable local image conversion to WebP; reduces client image weight. |
| Unsplash manifest/cache | Prevents repeated API requests and preserves attribution. |
| `AGENTS.md` + `CLAUDE.md` + `.cursorrules` | One source rule file works across AI coding tools. |

## Explicit non-defaults

- No React/Vue unless a project genuinely needs a hydrated interactive island.
- No Google Font CDN; self-host fonts for privacy/performance.
- No analytics, chat widgets, pixels, user accounts, or fake booking system without explicit approval.
