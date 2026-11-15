# Contributing to RoboStux Status

This is the uptime monitor and status page for RoboStux's services, powered by
[GitHup](https://github.com/StuxGroup/GitHup).

## Adding a monitored site

Add it under `monitors` in [`.githup.yml`](.githup.yml), add a row to the Monitors table in
`README.md`, and open a pull request. See the
[GitHup config reference](https://github.com/StuxGroup/GitHup#config-reference) for all options.
Give each monitor its full name, `RoboStux <name>` (e.g. `RoboStux Website`), never a bare word like `Website`,
and give it an explicit `slug` so renaming it later keeps its history.

## The icon

The page's logo and favicons are its own badge icon: the RoboStux mark with a heartbeat badge in the bottom-right
corner, in RoboStux's colours. They live in [`icons/`](icons), which GitHup publishes at the site root. To rebuild them:

```bash
curl -so /tmp/robostux-icon.png https://global.media.robo.st/icon.png
python -I scripts/badge-icons.py robostux /tmp/robostux-icon.png icons --size=512 --favicons
rm icons/robostux-status.png   # the same image as icons/icon-512.png
```

## Reporting an incident

Open an issue on this repository's issue tracker. GitHup opens incident issues automatically
(labelled `githup`, `incident` and the monitor's slug); issues you open with the `githup` and
`incident` labels also show on the status page.

## Previewing the status page

`./dev-server.sh` (or `dev-server.bat`) builds the page from `data/` and serves it locally,
with a DEV MODE banner (`--no-dev-mode` to turn it off; `--demo` to use generated example
data). It needs a local GitHup checkout: set `GITHUP_DIR`, or it clones GitHup into
`.githup-cache/`. Add `--lan` to open it from a phone or another device on your network: the server then listens on all interfaces instead of `127.0.0.1` only, and prints the addresses to open (usually the `192.168.x.x` one; allow Python through the firewall if asked).

## Branches and going live

- Work on `test`, or on a feature branch off it that's merged back into it. Releases are made on `test` too: `commit.sh`/`commit.bat` refuse to run on `staging` or `main`. Never push to `staging` or `main`
- `staging` is the last check before live: it changes only when a pull request from `test` into `staging` is merged
- `main` is what's live: it changes only when a pull request from `staging` into `main` is merged. Both pull requests need CI to pass and are reviewed and merged by Leo
- Merging into `main` rebuilds and deploys the status page; release commits and tags are made on `test` (`git push origin test --tags`) and go live once they've been through `staging` and its pull request into `main` is merged

## Versioning

This project uses [Date Versioning](https://datevers.ing). To release:

1. Add a `## vYY.MM.DD` entry at the top of `CHANGELOG.md`, with its sections in this order: Added, Changed, Fixed, Removed, Security, Deprecated.
2. Set `VERSION.md` to the same bare version (no `v`): today's **UTC** date as `YY.MM.DD`, or `YY.MM.DD-1`, `-2`… for later releases the same UTC day. Never a future date. Use UTC, not local time: just after midnight in the UK it is still the previous day in UTC.
3. Run `bash tests/version.sh`.
4. Run `./commit.sh` (or `commit.bat` on Windows). It checks the version, commits and tags `vYY.MM.DD`, and never pushes.
5. Push `test` with its tag (`git push origin test --tags`) and open a pull request into `staging` (`gh pr create --base staging --head test`). Once it's merged and staging checks out, open one from `staging` into `main` (`gh pr create --base main --head staging`).
