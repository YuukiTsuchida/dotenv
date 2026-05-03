@echo off

set CONFIG_DIR="%USERPROFILE%\.config"

rem Set environment variables
reg query "HKCU\Environment" /v HOME >nul 2>&1
IF ERRORLEVEL 1 (
    echo Setting environment variable HOME
    setx HOME "%USERPROFILE%"
)

reg query "HKCU\Environment" /v XDG_CONFIG_HOME >nul 2>&1
IF ERRORLEVEL 1 (
    echo Setting environment variable XDG_CONFIG_HOME
    setx XDG_CONFIG_HOME %CONFIG_DIR%
)

rem Create symbolic links
IF NOT EXIST "%CONFIG_DIR%" (
    echo Creating directory %CONFIG_DIR%
    mkdir "%CONFIG_DIR%"
)

IF NOT EXIST "%CONFIG_DIR%\wezterm" (
    echo Creating symbolic link for wezterm configuration
    mklink /D "%CONFIG_DIR%\wezterm" "%~dp0\wezterm"
)


pause
