#!/usr/bin/env bash
# watch-muse.sh — print Muse's replies as they land on the bus.
set -euo pipefail
REPO="andromikha2-hash/muse-inbox"
LAST=""
while true; do
  SHA="$(curl -fsSL --max-time 10 \
    "https://github.com/${REPO}/commits/main.atom" \
    | grep -o 'Grit::Commit/[0-9a-f]\{40\}' | head -n 1 | cut -d/ -f2 || true)"
  if [[ -n "$SHA" && "$SHA" != "$LAST" ]]; then
    LAST="$SHA"
    FILES="$(curl -fsSL --max-time 10 \
      "https://api.github.com/repos/${REPO}/commits/${SHA}" \
      | grep -o '"filename": *"outbox/[^"]*"' | cut -d'"' -f4 || true)"
    for f in $FILES; do
      echo "=== Muse replied: $f (commit $SHA) ==="
      curl -fsSL --max-time 10 \
        "https://raw.githubusercontent.com/${REPO}/${SHA}/${f}"
      echo
    done
  fi
  sleep 5
done
