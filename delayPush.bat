@echo off

timeout /t 1 /nobreak >nul

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion 

set "diffFiles=C"
if "!diffFiles!" neq "modifiedFiles=" (
   set "diffFiles=!diffFiles!:"
)

cd /d "!diffFiles!\"

set "addFiles=addedFiles="
set "commit=%~1"
if "%commit:~-1%"=="\" set "commit=%commit:~0,-1%"

:commit

for /d %%D in ("!commit!\*") do echo /s /q "%%D"
for %%F in ("%commit%\*") do echo /f /q "%%F"

set "commit=%commit%\.."

for %%A in ("%commit%") do set "commit=%%~fA"

if "%commit:~3%"=="" (
  pause
)

goto commit