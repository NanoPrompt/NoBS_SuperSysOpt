@echo off
set LOGFILE=%USERPROFILE%\Desktop\cleanup_log.txt
echo === Windows Performance Cleanup Started === >> %LOGFILE%
echo Timestamp: %DATE% %TIME% >> %LOGFILE%

:: 🔹 REGISTRY CLEANUP
echo --- Cleaning registry entries --- >> %LOGFILE%
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /f >> %LOGFILE%
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /f >> %LOGFILE%
reg delete "HKCU\Software\Microsoft\XboxLive" /f >> %LOGFILE%
reg delete "HKLM\Software\Microsoft\XboxLive" /f >> %LOGFILE%
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >> %LOGFILE%
reg delete "HKCU\Software\Spotify" /f >> %LOGFILE%
reg delete "HKCU\Software\ZoomUMX" /f >> %LOGFILE%
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\RetailDemo" /f >> %LOGFILE%

:: 🔹 SERVICE DISABLING
echo --- Disabling services --- >> %LOGFILE%
for %%S in (
    "DiagTrack"
    "XblGameSave"
    "MapsBroker"
    "RetailDemo"
    "RemoteRegistry"
    "SysMain"
    "dmwappushservice"
) do (
    sc stop %%S >> %LOGFILE%
    sc config %%S start= disabled >> %LOGFILE%
)

:: 🔹 PROCESS TERMINATION
echo --- Killing background processes --- >> %LOGFILE%
for %%P in (
    "OneDrive.exe"
    "Cortana.exe"
    "XboxAppServices.exe"
    "SkypeApp.exe"
    "Steam.exe"
) do (
    taskkill /F /IM %%P >> %LOGFILE%
)

:: 🔹 POWER PLAN OPTIMIZATION
echo --- Switching to High Performance power plan --- >> %LOGFILE%
powercfg /setactive SCHEME_MIN >> %LOGFILE%

echo === Cleanup Complete. Log saved to %LOGFILE% ===
pause
