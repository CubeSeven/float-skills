#!/usr/bin/env bash
# ============================================================
# sync-rules.sh — Mirror BROCHURE-SITE-RULES.md to whatever
# filename each AI tool expects. Run from repo root.
#
# Usage:  bash scripts/sync-rules.sh
# ============================================================
set -euo pipefail

cd "$(dirname "$0")/.."

RULE_FILE="BROCHURE-SITE-RULES.md"
if [ ! -f "$RULE_FILE" ]; then
  echo "❌  $RULE_FILE not found in $(pwd)"
  echo "    Run this script from the repo root."
  exit 1
fi

# ── target → symlink-or-copy ───────────────────────────────
link_or_copy() {
  local target="$1"
  if [ -f "$target" ] || [ -L "$target" ]; then
    rm -f "$target"
  fi
  ln -s "$RULE_FILE" "$target" 2>/dev/null && return 0
  cp "$RULE_FILE" "$target"
}

echo "━━━  Syncing $RULE_FILE  ━━━"
link_or_copy "AGENTS.md"                   && echo "  ✓  AGENTS.md           (opencode, Copilot)"
link_or_copy "CLAUDE.md"                   && echo "  ✓  CLAUDE.md           (Claude Code)"
link_or_copy ".cursorrules"                && echo "  ✓  .cursorrules        (Cursor)"
[ -d .cursor ] && link_or_copy ".cursor/rules/brochure-site.mdc" && echo "  ✓  .cursor/rules/…mdc  (Cursor fancier)"
echo "━━━  Done  ━━━"
