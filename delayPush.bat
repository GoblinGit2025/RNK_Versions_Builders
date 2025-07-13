@echo off

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion 

echo %~1

pause
