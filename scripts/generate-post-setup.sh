#!/usr/bin/env bash
# ============================================================
# generate-post-setup.sh  —  Creates POST-SETUP.md with the
# hand-off checklist. Run from the project root.
# ============================================================
set -euo pipefail

SITE_CONFIG="src/data/site.config.ts"

# ── Business info (from existing config) ───────────────────
BUSINESS_NAME="$(rg 'name:\s*'\\''([^'\\'']+)' "$SITE_CONFIG" 2>/dev/null | head -1 | sed "s/.*'//;s/'//")"
BUSINESS_NAME="${BUSINESS_NAME:-Your Brand}"

# ── Count placeholder slots ────────────────────────────────
PH_COUNT=$(rg -c 'placeholder:\s*true' src/data/ 2>/dev/null || echo "0")
UNSPLASH_COUNT=$(rg -c 'credit:' src/data/ 2>/dev/null || echo "0")

cat > POST-SETUP.md << EOF
# 🚀 POST-SETUP — _${BUSINESS_NAME}_

Thank you! This site scaffold is ready for production.
Below are the **human-only tasks** still needed.

---

## 🔴 Before launch

- [ ] **Google Business Profile verification**
      Add \`googleVerification\` code to \`src/data/site.config.ts\`
- [ ] **Replace favicon set** — overwrite \`public/favicon*\`
- [ ] **Replace logo** — overwrite \`public/logo.svg\`
- [ ] **Real images**
      - Grey placeholders: **${PH_COUNT} slot(s)** in \`src/data/content/gallery.ts\`
      - Unsplash stock to swap: **${UNSPLASH_COUNT} image(s)** with attribution
      Run \`npm run optimize-images dir Images/\` to process local photos.

## 🟡 Nice-to-have before launch

- [ ] Replace map embed URL in \`src/data/site.config.ts\` → \`SITE.maps\`
- [ ] Blog posts: \`src/data/content/blog.ts\`
- [ ] Real \`Lorem\` text in pages/components

## 🟢 Launch

1. \`npm run build\`
2. Upload \`dist/\` to **Netlify / Vercel / Cloudflare Pages**
3. Submit \`sitemap-index.xml\` in Google Search Console
4. Add \`robots.txt\` → \`Sitemap: https://yourdomain.com/sitemap-index.xml\`

---

_Built with [float-skills](https://github.com/CubeSeven/float-skills)_
EOF

echo "✓  POST-SETUP.md generated  (${PH_COUNT} placeholders, ${UNSPLASH_COUNT} Unsplash images)"
