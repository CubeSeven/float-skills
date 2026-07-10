#!/usr/bin/env bash
# ============================================================
# setup.sh  —  One-command brochure‑site scaffolding.
#
# Usage:  bash scripts/setup.sh
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/template-project"

echo "━━━  Float Creatives — Brochure Site Generator  ━━━"

# ── 1. Project name ────────────────────────────────────────
read -rp "Project name (e.g. theo-yoga): " PROJECT_NAME
PROJECT_NAME="${PROJECT_NAME// /-}"
PROJECT_DIR="$(pwd)/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
  echo "⚠️  Directory '$PROJECT_DIR' already exists. Remove it first or pick another name."
  exit 1
fi

# ── 2. Quick brief ─────────────────────────────────────────
echo ""
echo "A few quick questions to pre-fill the site config."
read -rp "Business name: " BUSINESS_NAME
BUSINESS_NAME="${BUSINESS_NAME:-$PROJECT_NAME}"
read -rp "Tagline (one-liner): " TAGLINE
read -rp "Has Unsplash API key? (y/N) " HAS_KEY
HAS_KEY="${HAS_KEY:-n}"

# ── 3. Copy template ───────────────────────────────────────
echo ""
echo "Creating project at  $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cp -r "$TEMPLATE_DIR/"* "$PROJECT_DIR/" 2>/dev/null || true
cp -r "$TEMPLATE_DIR/." "$PROJECT_DIR/" 2>/dev/null || true
cp "$REPO_ROOT/BROCHURE-SITE-RULES.md" "$PROJECT_DIR/BROCHURE-SITE-RULES.md"
cp -r "$REPO_ROOT/scripts" "$PROJECT_DIR/scripts"
chmod -R u+w "$PROJECT_DIR"
chmod +x "$PROJECT_DIR/scripts"/*.sh

# ── 4. Sync rules files ────────────────────────────────────
cd "$PROJECT_DIR"
bash scripts/sync-rules.sh

# ── 5. Write .env ──────────────────────────────────────────
if [ "$HAS_KEY" = "y" ] || [ "$HAS_KEY" = "Y" ]; then
  read -rsp "  Paste your Unsplash ACCESS KEY (hidden): " UNS_KEY
  echo
  echo "UNSPLASH_ACCESS_KEY=${UNS_KEY}" > .env
  echo "✓  .env written"
else
  cp "$REPO_ROOT/.env.example" .env
  echo "✓  .env (placeholder) written"
fi

# ── 6. Install deps ────────────────────────────────────────
echo ""
echo "Installing dependencies…"
npm install --silent 2>/dev/null || npm install

# ── 7. Pre-fill site.config.ts ─────────────────────────────
SITE_CONFIG="src/data/site.config.ts"
if [ -f "$SITE_CONFIG" ]; then
  sed -i "s/name: 'Business Name'/name: '${BUSINESS_NAME}'/g" "$SITE_CONFIG"
  sed -i "s/tagline: '.*'/tagline: '${TAGLINE}'/g" "$SITE_CONFIG"
  echo "✓  site.config.ts pre-filled"
fi

# ── 8. Initial build check ─────────────────────────────────
echo ""
echo "Running initial build check…"
if npx astro build 2>/dev/null; then
  echo "✓  Build passed"
else
  echo "⚠️  Build had warnings — this is normal for a fresh scaffold."
  echo "   Fix content in src/data/ and pages/ then run 'npm run build'."
fi

# ── 9. Summary ─────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅  $PROJECT_NAME  created!"
echo ""
echo "Next steps (do these in order):"
echo "  1  cd $PROJECT_DIR"
echo "  2  npm run dev          — start dev server"
echo "  3  bash scripts/sync-rules.sh  — after modifying BROCHURE-SITE-RULES.md"
echo "  4  npm run fetch-images — fetch stock photos (if Unsplash key set)"
echo "  5  npm run optimize-images dir <folder>  — optimise local images"
echo "  6  npm run validate     — pre-launch audit"
echo ""
echo "Hand-off doc:  $PROJECT_DIR/POST-SETUP.md"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
