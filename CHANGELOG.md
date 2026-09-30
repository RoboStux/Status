# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2026-09-30

### Added

- A **Created with** line in the footer of the hand-made `/changelogs/` page: a heart, code brackets and a coffee mug, by StuxieDev

### Changed

- The dev-mode banner on the hand-made pages is the shared Stux site banner: a muted strip in the page's colours with a label chip and a faint icon pattern, replacing the yellow hazard stripes. It stays at the top and pushes the page down by its exact height, so it never covers anything, including on phones. In dev mode, `?banner=soon,maintenance,site` previews the other banner styles
- The dev banner is switched on by `dev-server.sh`/`.bat` (they write `assets/dev-mode.js` into the local build) instead of by looking at the hostname, so `--no-dev-mode` now hides it everywhere; the old `?nodev=1` is gone
- The footer's **Powered by GitHup** and service links are muted until hovered or focused, and footer logos are 28px and fade in without the hover glitch (the same filter functions in every state)
- `dev-server.sh`/`.bat` use a local GitHup checkout (`../GitHup` or `../../Stux.Group/GitHup`) when there is one, so local previews show the newest GitHup
- Needs GitHup v1.5.0 for the status page's own new banner and muted footer (it's picked up through `StuxGroup/GitHup@v1`)

## [1.1.0] - 2026-09-30

### Added
- A **Changelogs** page at `status.robo.st/changelogs/` with two tabs: this status page's own changelog (with its version) and GitHup's (read live from its `v1` release), with each release's sections sorted into a fixed order and coloured type badges; `/changelogs/#githup` opens the GitHup tab, and `/changelog/` redirects to `/changelogs/`, keeping the `#tab`
- `site/`, holding the changelogs page and its styles, published with the status page along with `CHANGELOG.md` and `VERSION.md`

### Changed
- Monitors are grouped on the status page and in the README table, using GitHup v1.4.0's `groups`: **Web** (Website, CDN) and **Bot** (Node 1, Bot); slugs are unchanged, so every monitor keeps its history
- The status page footer's first link is now this page's version (`v1.1.0`), linking to `/changelogs/` (GitHup v1.4.0's `site.changelog`), and the footer shows the GitHup version that built the page
- The page is now deployed with `actions/deploy-pages` (GitHup builds it into `_site` with `deploy: "false"`, then `site/` and the changelog files are copied on top) instead of GitHup pushing a `gh-pages` branch, so the repository's Pages source must be **GitHub Actions**; pushes that change `site/`, `CHANGELOG.md` or `VERSION.md` rebuild the page
- The workflow uses `actions/checkout@v7`
- `dev-server.sh`/`dev-server.bat` copy `site/`, `CHANGELOG.md` and `VERSION.md` onto the built page, like the workflow

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
