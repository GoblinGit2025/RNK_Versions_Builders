@echo off

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "TARGET_DIR=C:\tmp"

if not exist "%TARGET_DIR%\" (
  set "TARGET_DIR=C:\temp"
)

set "WORKER_NAME=delayPush.bat"

copy "%SCRIPT_DIR%\RNK_Versions_Builders\%WORKER_NAME%" "%TARGET_DIR%\%WORKER_NAME%" >nul

powershell -NoProfile -Command ^
  "Start-Process -FilePath '%TARGET_DIR%/%WORKER_NAME%' -ArgumentList @('%SCRIPT_DIR%') -Verb RunAs"

endlocal