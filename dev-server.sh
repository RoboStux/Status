#!/bin/bash
# RoboStux Status - Local dev server
# Usage: ./dev-server.sh [--no-dev-mode] [--demo] [--lan] [port]
#   port            default: 8000
#   --no-dev-mode   render the page exactly as production would (no DEV MODE banner)
#   --demo          build from generated example data instead of data/
#   --lan           listen on all interfaces so phones/tablets on your network can
#                   connect (prints the addresses to open); default is 127.0.0.1 only
#
# Builds the status page with GitHup from this repo's .githup.yml and data/
# into .dev/site, then
# serves it with python -m http.server. DEV_MODE is on by default so the page
# shows the dev-only banner.
#
# Needs a GitHup checkout: set GITHUP_DIR to one, or this clones
# https://github.com/StuxGroup/GitHup (tag v1) into .githup-cache/.
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=8000
DEMO=0
HOST=127.0.0.1
export DEV_MODE=1

for arg in "$@"; do
    case "$arg" in
        --no-dev-mode) export DEV_MODE=0 ;;
        --demo) DEMO=1 ;;
        --lan) HOST=0.0.0.0 ;;
        ''|*[!0-9]*) echo "Usage: $0 [--no-dev-mode] [--demo] [--lan] [port]" >&2; exit 1 ;;
        *) PORT="$arg" ;;
    esac
done

if [ -z "${GITHUP_DIR:-}" ] && [ -f "$DIR/../../Stux.Group/GitHup/githup/__init__.py" ]; then
    GITHUP_DIR="$DIR/../../Stux.Group/GitHup"   # the local GitHup checkout, if there is one
fi
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

echo "RoboStux Status (DEV_MODE=$DEV_MODE) at http://127.0.0.1:$PORT"
if [ "$HOST" = "0.0.0.0" ]; then
    # This machine's IPv4 addresses (Windows, macOS or Linux), minus loopback
    case "$OSTYPE" in
        msys*|cygwin*|win32*) ADDRS="$(ipconfig | awk -F': *' '/IPv4/{print $2}' | tr -d '\r')" ;;
        darwin*) ADDRS="$(ifconfig | awk '/inet /{print $2}')" ;;
        *) ADDRS="$(hostname -I 2>/dev/null)" ;;
    esac
    echo "On your local network (--lan), open one of these on the other device:"
    for a in $ADDRS; do
        case "$a" in 127.*|'') ;; *) echo "    http://$a:$PORT/" ;; esac
    done
    echo "  (usually the 192.168.x.x one; allow Python through the firewall if asked)"
fi
"$PY" -m http.server "$PORT" --bind "$HOST" --directory .dev/site
