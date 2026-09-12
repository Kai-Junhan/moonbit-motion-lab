@echo off
setlocal
chcp 65001 > nul
cd /d "%~dp0"

echo Running MoonBit verification...
moon fmt --check
if errorlevel 1 exit /b 1
moon check
if errorlevel 1 exit /b 1
moon test
if errorlevel 1 exit /b 1
moon build
if errorlevel 1 exit /b 1
moon run ./examples/basic
if errorlevel 1 exit /b 1

echo Verification passed for MoonBit Motion Lab.
endlocal
