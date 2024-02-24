@echo off

if "%1"=="debug" (
    hemtt.exe build -vvv
) ELSE (
    hemtt.exe build
)
if "%1"=="release" (
    hemtt.exe release
)
