# float-skills

> **Float Creatives** — Brochure website toolkit
>
> Portable AI agent rules, image pipeline scripts, and a self-contained **Astro + Tailwind CSS v4** starter template. Build production-ready brochure sites for local businesses, villas, restaurants, studios, and service companies with minimal manual work.

---

## 🚀 Quick start (zero config)

```bash
# 1. Clone this repo
git clone git@github.com:CubeSeven/float-skills.git
cd float-skills

# 2. Install deps
npm install

# 3. Run the generator (answers 3 questions, scaffolds a ready project)
npm run setup
```

**That's it.** You now have a working Astro + Tailwind v4 project with:
- Data-driven content (`src/data/`)
- Must-work interactive features (lightbox, mobile menu, accordion, scroll-reveal)
- Image pipeline scripts (Unsplash stock + local optimization)
- SEO/Schema/Accessibility baked in

---

## 📦 What you get

| Folder / File | Purpose |
|---|---|
| `BROCHURE-SITE-RULES.md` | The single source of truth — portable rules file for any AI agent (Cursor, Claude, Copilot, opencode, etc.) |
| `scripts/setup.sh` | One-command new-project scaffolder |
| `scripts/sync-rules.sh` | Mirrors rules file to `AGENTS.md`, `CLAUDE.md`, `.cursorrules` |
| `scripts/fetch-unsplash.mjs` | Fetches contextual stock photos (hotlinked per Unsplash ToS) |
| `scripts/optimize-images.mjs` | Sharp-based WebP/AVIF conversion for local photos |
| `scripts/process-images.mjs` | Generates responsive variants + updates `gallery.ts` |
| `scripts/validate-project.sh` | Pre-launch audit (build, placeholders, assets, data files) |
| `scripts/generate-post-setup.sh` | Auto-generates `POST-SETUP.md` hand-off checklist |
| `template-project/` | Complete Astro + Tailwind v4 starter (copy this to start) |

---

## 🛠️ Typical workflow

```bash
# In a fresh terminal
cd float-skills
npm run setup                    # → creates ./my-villa-project/

cd my-villa-project
npm run dev                      # → preview at localhost:4321

# When you have client photos
npm run optimize-images dir Images/

# When you need stock photos (if UNSPLASH_ACCESS_KEY set)
npm run fetch-images "greek island villa terrace" 6

# Before deploying
npm run validate                 # → shows any remaining TODOs
npm run build                    # → production build in dist/
```

---

## 📚 Documentation

| File | Description |
|---|---|
| `BROCHURE-SITE-RULES.md` | Full protocol: kickoff interview, hard-locked stack, interactive contract, reference patterns, SEO, accessibility, build gate |
| `docs/ARCHITECTURE.md` | How the pieces fit together (data → components → pages → scripts) |
| `docs/DECISIONS.md` | Why each library was chosen (Astro, Tailwind v4, Swiper, Sharp, etc.) |
| `docs/TROUBLESHOOTING.md` | Common issues + fixes (blank lightbox, mobile menu clipping, icon sets, etc.) |

---

## 🤖 Using with AI agents

This repo **entire point of `BROCHURE-SITE-RULES.md` is that any AI coding agent can read it and **behave correctly** without you explaining anything.

| Tool | What to do |
|---|---|
| **Cursor** | Run `scripts/sync-rules.sh` → creates `.cursorrules` |
| **Claude Code** | Creates `CLAUDE.md` automatically |
| **GitHub Copilot** | Creates `AGENTS.md` automatically |
| **opencode** | Uses `AGENTS.md` |
| **Windsurf** | Uses `.windsurfrules` |

**Just run `scripts/sync-rules.sh` once per project** — it symlinks the rules file to whatever filename your tool expects.

---

## 📄 License

MIT — free to use, modify, and distribute.

---

**Float Creatives** — Panos · Henna · Skiathos tourism clients