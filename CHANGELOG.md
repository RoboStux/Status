# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.5] - 2026-09-16

### Added
- `.upptimerc.yml` now also monitors the CDN (`https://global.media.robo.st/logo.png`).

### Changed
- Cleared all existing history/api/graphs monitoring data for a clean start — regenerates automatically on the next Uptime CI run.

## [1.0.4] - 2026-09-16

### Changed
- `README.md`'s logo URL migrated from `media.robo.st/global/logo.png` to `global.media.robo.st/logo.png`, matching the CDN subdomain convention used elsewhere in the Stux.Group family.

## [1.0.3] - 2026-09-16

### Fixed
- Cleared the `website` history/api/graphs data, which was still recording the transient outage from earlier — regenerates fresh on the next Uptime CI run now that `robo.st` is reachable again.

## [1.0.2] - 2026-09-16

### Changed
- Renamed the "Server (tiny1)" monitored site to "Node 1", and cleared the now-orphaned `server-tiny1` history/api/graphs data (regenerates under the new `node-1` slug on the next run).

## [1.0.1] - 2026-09-16

### Added
- `.upptimerc.yml` now also monitors the server hosting RoboStux's services (`tiny1.servers.uk.stux.cloud`) — as both "Server (tiny1)" and "Bot", since the Bot and the underlying server share the same host and instance page — alongside the main website.

## [1.0.0] - 2026-09-16

### Changed
- Rebuilt as a fresh history with no prior commit log, now living under the `RoboStux` GitHub org.
- `.upptimerc.yml` reconfigured to monitor RoboStux's own services (starting with `https://robo.st`), with `status-website.cname` pointed at `status.robo.st`.
- `README.md` and `LICENSE` reworked for RoboStux, and `README.md` restyled to match the header/Author/License layout used across StuxieDev's other projects.
- Cleared the `history/`, `api/`, and `graphs/` monitoring data carried over from before the rebuild — all regenerate automatically once the Uptime CI workflow runs.

### Fixed
- `commit.sh`'s executable bit and `VERSION.md`'s missing trailing newline.
- CI was failing on every push with a 403 pushing back to the repo — the `RoboStux` org's default Actions workflow permissions were read-only; switched to read/write.
