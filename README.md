# float-skills

Portable brochure-site rules for AI coding agents.

## Start a new brochure site

Paste this **one prompt** into your AI coding agent:

> Use `https://github.com/CubeSeven/float-skills` as the brochure-site rules library. **Start.**

The agent reads `BROCHURE-SITE-RULES.md`, then asks everything it needs: business details, reference links, pages, design direction, assets, languages, and whether to use optional stock photos. It proposes the structure before building.

> Your agent needs access to the URL (or clone the repository locally first). If it cannot read GitHub URLs, give it the local repository path instead.

No template pages are forced. The brief and answers decide the site.

## Optional local setup

```bash
git clone https://github.com/CubeSeven/float-skills.git
```

Then use this prompt instead:

> Use the rules library at `/path/to/float-skills`. **Start.**

Use only one tool pointer if your agent requires it: `AGENTS.md`, `CLAUDE.md`, or `.cursorrules`. The master file remains `BROCHURE-SITE-RULES.md`.
