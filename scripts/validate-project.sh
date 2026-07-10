#!/usr/bin/env bash
# ============================================================
# validate-project.sh  —  Pre-launch audit for a brochure site.
#
# Run from the project root (not the repo root).
# Usage:  bash ../scripts/validate-project.sh
# ============================================================
set -euo pipefail

echo "━━━  Project Validation  ━━━"
ERRORS=0
WARN=0

# 1. Build passes
echo ""
echo "── Build ──"
if npm run build 2>&1 | tail -3; then
  echo "  ✓  Build passed"
else
  echo "  ❌  Build failed"
  ERRORS=$((ERRORS + 1))
fi

# 2. Placeholder audit
echo ""
echo "── Placeholders & stubs ──"
PH=$(rg -c 'placeholder:\s*true' src/data/ 2>/dev/null | awk -F: '{sum += $NF} END {print sum+0}')
echo "     placeholder: true  hits:  $PH"
if [ "$PH" -gt 0 ]; then
  echo "  ⚠️  $PH gallery slot(s) still placeholder — check POST-SETUP.md"
  WARN=$((WARN + 1))
fi

STUBS=$(rg -n 'YOUR_|@example\.com|Lorem|TODO|FIXME' src/ public/ 2>/dev/null || true)
if [ -n "$STUBS" ]; then
  echo "  ⚠️  Stub strings found:"
  echo "$STUBS" | head -20
  WARN=$((WARN + 1))
fi

# 3. Assets present
echo ""
echo "── Assets ──"
[ -f "public/favicon.svg" ]   && echo "  ✓  favicon"       || echo "  ⚠️  missing favicon.svg"
[ -f "public/logo.svg" ]      && echo "  ✓  logo"          || echo "  ⚠️  missing logo.svg"
[ -f "public/robots.txt" ]    && echo "  ✓  robots.txt"    || echo "  ⚠️  missing robots.txt"
[ -f "public/images/placeholder.svg" ] && echo "  ✓  placeholder.svg" \
                              || echo "  ⚠️  missing placeholder.svg"

# 4. Data files
echo ""
echo "── Data files ──"
for f in site.config.ts services.ts testimonials.ts faq.ts gallery.ts; do
  found=$(find src/data -name "$f" 2>/dev/null | head -1)
  [ -n "$found" ] && echo "  ✓  $f" || echo "  ⚠️  missing src/data/$f"
done

# 5. POST-SETUP.md
echo ""
echo "── Hand-off doc ──"
[ -f "POST-SETUP.md" ] && echo "  ✓  POST-SETUP.md present" \
                       || echo "  ⚠️  POST-SETUP.md missing"
[ -f "AGENTS.md" ] || [ -f "CLAUDE.md" ] || [ -f ".cursorrules" ] \
  && echo "  ✓  Agent rules file(s) present" \
  || echo "  ⚠️  No agent rules file found — run scripts/sync-rules.sh"

# 6. Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━"
if [ "$ERRORS" -gt 0 ]; then
  echo "❌  $ERRORS error(s) — fix before deploy"
fi
if [ "$WARN" -gt 0 ]; then
  echo "⚠️   $WARN warning(s) — review before deploy"
fi
if [ "$ERRORS" -eq 0 ] && [ "$WARN" -eq 0 ]; then
  echo "✅  All checks passed"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━"
exit "$ERRORS"
