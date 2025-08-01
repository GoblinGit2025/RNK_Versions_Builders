@echo off

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

set "WORKER_NAME=delayPush.bat"

copy "%SCRIPT_DIR%\RNK_Versions_Builders\%WORKER_NAME%" "%Temp%\%WORKER_NAME%" >nul

powershell -NoProfile -Command ^
  "Start-Process -FilePath '%Temp%/%WORKER_NAME%' -ArgumentList @('%SCRIPT_DIR%') -Verb RunAs"

endlocal