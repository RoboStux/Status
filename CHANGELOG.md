# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-09-16

### Changed
- Rebuilt as a fresh history with no prior commit log, now living under the `RoboStux` GitHub org.
- `.upptimerc.yml` reconfigured to monitor RoboStux's own services (starting with `https://robo.st`), with `status-website.cname` pointed at `status.robo.st`.
- `README.md` and `LICENSE` reworked for RoboStux, and `README.md` restyled to match the header/Author/License layout used across StuxieDev's other projects.
- Cleared the `history/`, `api/`, and `graphs/` monitoring data carried over from before the rebuild — all regenerate automatically once the Uptime CI workflow runs.

### Fixed
- `commit.sh`'s executable bit and `VERSION.md`'s missing trailing newline.
- CI was failing on every push with a 403 pushing back to the repo — the `RoboStux` org's default Actions workflow permissions were read-only; switched to read/write.
