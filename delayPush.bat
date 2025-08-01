@echo off

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion 

@REM git config core.quotePath false
@REM git config i18n.logOutputEncoding utf-8

set "changedFiles=Polishing:"

set "diffFiles=C"
@REM for /f "delims=" %%f in ('git diff --name-only') do (
@REM     set "changedFiles=!changedFiles!%%f|"
@REM )
if "!diffFiles!" neq "modifiedFiles=" (
   set "diffFiles=!diffFiles!:"
)

cd /d "!diffFiles!\"

set "addFiles=addedFiles="
if "%~1"=="" (
  set "commit=%cd%"
) else (
  set "commit=%~1"
)
if "!commit:~-1!"=="\" set "commit=!commit:~0,-1!"

echo Prepare to commit...

timeout /t 1 /nobreak >nul

:commit

for /d %%D in ("!commit!\*") do rmdir /s /q "%%D" >nul 2>&1
for %%F in ("!commit!\*") do del /f /q "%%F" >nul 2>&1

if "!commit:~3!"=="" (
  set "commit=%cd%"
  goto commit
)

set "commit=!commit!\.."

for %%A in ("!commit!") do set "commit=%%~fA"

goto commit

git add .
git commit -m "!changedFiles!"
git push