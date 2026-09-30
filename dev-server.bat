@echo off
setlocal
REM RoboStux Status - Local dev server (Windows)
REM Usage: dev-server.bat [--no-dev-mode] [--demo] [port]
REM   port            default: 8000
REM   --no-dev-mode   render the page exactly as production would (no DEV MODE banner)
REM   --demo          build from generated example data instead of data\
REM
REM Builds the status page with GitHup from this repo's .githup.yml and data\
REM into .dev\site, adds site\ (/changelogs), CHANGELOG.md and VERSION.md, then
REM serves it with python -m http.server. DEV_MODE is on by default so the page
REM shows the dev-only banner.
REM
REM Needs a GitHup checkout: set GITHUP_DIR to one, or this clones
REM https://github.com/StuxGroup/GitHup (tag v1) into .githup-cache\.

set "DIR=%~dp0"
set "PORT=8000"
set "DEMO=0"
set "DEV_MODE=1"

:args
if "%~1"=="" goto run
if /i "%~1"=="--no-dev-mode" (
    set "DEV_MODE=0"
) else if /i "%~1"=="--demo" (
    set "DEMO=1"
) else (
    set "PORT=%~1"
)
shift
goto args

:run
cd /d "%DIR%"
REM The local GitHup checkout, if there is one, else a v1 clone.
if "%GITHUP_DIR%"=="" if exist "%DIR%..\..\Stux.Group\GitHup\githup\__init__.py" set "GITHUP_DIR=%DIR%..\..\Stux.Group\GitHup"
if "%GITHUP_DIR%"=="" set "GITHUP_DIR=%DIR%.githup-cache"
if not exist "%GITHUP_DIR%\githup" (
    echo Fetching GitHup into %GITHUP_DIR%
    git clone --quiet --depth 1 --branch v1 https://github.com/StuxGroup/GitHup.git "%GITHUP_DIR%" || exit /b 1
)
set "PYTHONPATH=%GITHUP_DIR%"

if "%DEMO%"=="1" (
    python -m githup demo --config .githup.yml --data-dir .dev/data || exit /b 1
    python -m githup site --config .githup.yml --data-dir .dev/data --out .dev/site --no-deploy --incidents-file .dev/data/incidents.json || exit /b 1
) else (
    python -m githup site --config .githup.yml --data-dir data --out .dev/site --no-deploy --no-issues || exit /b 1
)
REM GitHup empties its output folder, so site\ (/changelogs) and the changelog files go on top after.
xcopy site .dev\site\ /e /i /q /y >nul || exit /b 1
copy /y CHANGELOG.md .dev\site\ >nul || exit /b 1
copy /y VERSION.md .dev\site\ >nul || exit /b 1
REM The hand-made pages (site\) show the shared dev banner when assets\dev-mode.js says so; the
REM committed copy says false, so only this local build gets true.
if "%DEV_MODE%"=="1" (echo window.DEV_MODE = true;) > ".dev\site\assets\dev-mode.js"

echo RoboStux Status (DEV_MODE=%DEV_MODE%) at http://127.0.0.1:%PORT%
python -m http.server %PORT% --bind 127.0.0.1 --directory .dev/site
