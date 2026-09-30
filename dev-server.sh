#!/bin/bash
# RoboStux Status - Local dev server
# Usage: ./dev-server.sh [--no-dev-mode] [--demo] [port]
#   port            default: 8000
#   --no-dev-mode   render the page exactly as production would (no DEV MODE banner)
#   --demo          build from generated example data instead of data/
#
# Builds the status page with GitHup from this repo's .githup.yml and data/
# into .dev/site, adds site/ (/changelogs), CHANGELOG.md and VERSION.md, then
# serves it with python -m http.server. DEV_MODE is on by default so the page
# shows the dev-only banner.
#
# Needs a GitHup checkout: set GITHUP_DIR to one, or this clones
# https://github.com/StuxGroup/GitHup (tag v1) into .githup-cache/.
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=8000
DEMO=0
export DEV_MODE=1

for arg in "$@"; do
    case "$arg" in
        --no-dev-mode) export DEV_MODE=0 ;;
        --demo) DEMO=1 ;;
        ''|*[!0-9]*) echo "Usage: $0 [--no-dev-mode] [--demo] [port]" >&2; exit 1 ;;
        *) PORT="$arg" ;;
    esac
done

GITHUP_DIR="${GITHUP_DIR:-$DIR/.githup-cache}"
if [ ! -d "$GITHUP_DIR/githup" ]; then
    echo "Fetching GitHup into $GITHUP_DIR"
    git clone --quiet --depth 1 --branch v1 https://github.com/StuxGroup/GitHup.git "$GITHUP_DIR"
fi
export PYTHONPATH="$GITHUP_DIR"

PY="$(command -v python3 || command -v python)"
cd "$DIR"
DATA=data
if [ "$DEMO" = 1 ]; then
    DATA=.dev/data
    "$PY" -m githup demo --config .githup.yml --data-dir "$DATA"
    "$PY" -m githup site --config .githup.yml --data-dir "$DATA" --out .dev/site --no-deploy \
        --incidents-file "$DATA/incidents.json"
else
    "$PY" -m githup site --config .githup.yml --data-dir "$DATA" --out .dev/site --no-deploy --no-issues
fi
# GitHup empties its output folder, so site/ (/changelogs) and the changelog files go on top after.
cp -r site/. CHANGELOG.md VERSION.md .dev/site/

echo "RoboStux Status (DEV_MODE=$DEV_MODE) at http://127.0.0.1:$PORT"
"$PY" -m http.server "$PORT" --bind 127.0.0.1 --directory .dev/site
