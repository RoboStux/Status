# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-09-29

The first release of RoboStux's status page under a fresh version history. Earlier versions and their tags have been retired.

### Added
- A GitHup status page at `status.robo.st` monitoring the website (`robo.st`), Node 1 (`node1.robo.st`), the bot's health endpoint (`node1.robo.st/health`, where only a 200 counts as up) and the CDN (`global.media.robo.st`), checked every 5 minutes by `.github/workflows/githup.yml` using `StuxGroup/GitHup@v1`
- `.githup.yml` with the monitors, the RoboStux logo, icon and accent colour, and a "Boring Legal Stuff" link to `robo.st/legal`
- Incident issues opened automatically when a monitor goes down and closed when it recovers
- Monitoring data in `data/` (seeded empty) and a live status table in `README.md`
- A "Monitors" section in `README.md` listing what each monitor checks
- `dev-server.sh`/`dev-server.bat` to preview the status page locally with a DEV MODE banner
- `commit.sh`/`commit.bat` release scripts that read `VERSION.md` and tag `vX.Y.Z`

### Changed
- Replaced the previous status monitor with GitHup; the status page is now MIT-licensed under StuxieDev
