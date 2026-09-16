# Contributing to RoboStux-Status

This is the uptime monitor and status page for RoboStux's services, powered by
[Upptime](https://github.com/upptime/upptime).

## Adding a monitored site

Add it under `sites` in [`.upptimerc.yml`](.upptimerc.yml) and open a pull request. See the
[Upptime configuration docs](https://upptime.js.org/docs/configuration) for the full options.

## Reporting an incident

Open an issue on this repository's issue tracker — Upptime uses Issues as incident reports.

## Release process

See `commit.sh`/`commit.bat` for how releases are tagged. Update `CHANGELOG.md` and bump `VERSION.md`
before running the commit script.
