# Contributing to RoboStux Status

This is the uptime monitor and status page for RoboStux's services, powered by
[GitHup](https://github.com/StuxGroup/GitHup).

## Adding a monitored site

Add it under `monitors` in [`.githup.yml`](.githup.yml), add a row to the Monitors table in
`README.md`, and open a pull request. See the
[GitHup config reference](https://github.com/StuxGroup/GitHup#config-reference) for all options.

## Reporting an incident

Open an issue on this repository's issue tracker. GitHup opens incident issues automatically
(labelled `githup`, `incident` and the monitor's slug); issues you open with the `githup` and
`incident` labels also show on the status page.

## Previewing the status page

`./dev-server.sh` (or `dev-server.bat`) builds the page from `data/` and serves it locally,
with a DEV MODE banner (`--no-dev-mode` to turn it off; `--demo` to use generated example
data). It needs a local GitHup checkout: set `GITHUP_DIR`, or it clones GitHup into
`.githup-cache/`.

## Release process

See `commit.sh`/`commit.bat` for how releases are tagged. Update `CHANGELOG.md` and bump `VERSION.md`
before running the commit script.
