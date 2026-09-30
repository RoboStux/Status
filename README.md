<p align="center">
  <img src="https://global.media.robo.st/logo.png" alt="RoboStux Status" width="300">
</p>

# RoboStux Status

> Uptime monitor and status page for RoboStux's services, powered by [GitHup](https://github.com/StuxGroup/GitHup).

[**Visit the status page →**](https://status.robo.st)

GitHub Actions checks every service every 5 minutes. Results are stored as JSON in
[`data/`](data), outages open an [Issue](https://github.com/RoboStux/Status/issues) that is
closed again on recovery, and the status page is published to GitHub Pages at
[status.robo.st](https://status.robo.st).

## Current status

<!-- githup:start -->
<!-- This table is written by GitHup (https://github.com/StuxGroup/GitHup); edits here are overwritten. -->

**All systems operational** · [Live status page](https://status.robo.st/)

| Monitor | Status | Uptime (24 h) | Uptime (7 d) | Uptime (30 d) | Response time (24 h) |
| ------- | ------ | ------------- | ------------ | ------------- | -------------------- |
| [Website](https://robo.st) | Up | 100.00% | 100.00% | 100.00% | 1231 ms |
| [Node 1](https://node1.robo.st/) | Up | 100.00% | 100.00% | 100.00% | 598 ms |
| [Bot](https://node1.robo.st/health) | Up | 100.00% | 100.00% | 100.00% | 598 ms |
| [CDN](https://global.media.robo.st/logo.png) | Up | 100.00% | 100.00% | 100.00% | 744 ms |
<!-- githup:end -->

## Monitors

| Monitor | URL                                     | Checks                                                                             |
| ------- | --------------------------------------- | ---------------------------------------------------------------------------------- |
| Website | `https://robo.st`                       | The public website                                                                 |
| Node 1  | `https://node1.robo.st/`                | The server RoboStux runs on (nginx answers 200 at `/`)                             |
| Bot     | `https://node1.robo.st/health`          | RoboStux's health endpoint: 200 when the bot is connected and ready, 503 otherwise |
| CDN     | `https://global.media.robo.st/logo.png` | The media CDN                                                                      |

Every monitor counts any 200-399 answer as up, except Bot, where only a 200 counts. Answers
slower than 3 seconds show as degraded. Monitors are configured in [`.githup.yml`](.githup.yml).

## Author

<img src="https://global.media.stuxie.dev/icon.png" height="14" alt="StuxieDev" valign="middle"> [StuxieDev](https://github.com/StuxieDev)

## License

(C) StuxieDev. Distributed under the MIT License, including the monitoring data in `data/`.
See the [`LICENSE`](LICENSE) file for more information.
