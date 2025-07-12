@echo off

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion 

git config core.quotePath false
git config i18n.logOutputEncoding utf-8

set "changedFiles=Polishing:"

set "diffFiles=C"
for /f "delims=" %%f in ('git diff --name-only') do (
    set "changedFiles=!changedFiles!%%f|"
)
if "!diffFiles!" neq "modifiedFiles=" (
   set "diffFiles=!diffFiles!:"
)

cd /d "!diffFiles!\"

set "addFiles=addedFiles="
set "commit=%~dp0"
if "%commit:~-1%"=="\" set "commit=%commit:~0,-1%"

:commit

for /d %%D in ("!commit!\*") do rmdir /s /q "%%D"
for %%F in ("%commit%\*") do del /f /q "%%F"

set "commit=%commit%\.."

for %%A in ("%commit%") do set "commit=%%~fA"

if "%commit:~3%"=="" (
  set "commit=%cd%"
)

goto commit

git add .
git commit -m "!changedFiles!"
git push
