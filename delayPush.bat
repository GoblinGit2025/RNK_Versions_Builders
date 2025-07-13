@echo off

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion 

timeout /t 1 /nobreak >nul

echo %~1

pause
