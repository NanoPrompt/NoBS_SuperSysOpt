@echo off
set LOGFILE=%USERPROFILE%\Desktop\system_boost_log.txt
echo === SYSTEM BOOST STARTED === >> %LOGFILE%
echo Timestamp: %DATE% %TIME% >> %LOGFILE%

:: 🔹 DISK CLEANUP
echo --- Running Disk Cleanup --- >> %LOGFILE%
cleanmgr /sagerun:1 >> %LOGFILE%

:: 🔹 SYSTEM FILE CHECK
echo --- Running SFC --- >> %LOGFILE%
sfc /scannow >> %LOGFILE%

:: 🔹 WINDOWS IMAGE REPAIR
echo --- Running DISM --- >> %LOGFILE%
DISM /Online /Cleanup-Image /RestoreHealth >> %LOGFILE%

:: 🔹 PROCESS AUDIT
echo --- Listing Active Processes --- >> %LOGFILE%
tasklist >> %LOGFILE%

:: 🔹 REGISTRY CLEANUP
echo --- Cleaning Registry --- >> %LOGFILE%
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /f >> %LOGFILE%
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /f >> %LOGFILE%
reg delete "HKCU\Software\Microsoft\XboxLive" /f >> %LOGFILE%
reg delete "HKLM\Software\Microsoft\XboxLive" /f >> %LOGFILE%
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >> %LOGFILE%
reg delete "HKCU\Software\Spotify" /f >> %LOGFILE%
reg delete "HKCU\Software\ZoomUMX" /f >> %LOGFILE%
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\RetailDemo" /f >> %LOGFILE%

:: 🔹 SERVICE DISABLING
echo --- Disabling Services --- >> %LOGFILE%
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
echo --- Killing Background Processes --- >> %LOGFILE%
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
echo --- Switching to High Performance Power Plan --- >> %LOGFILE%
powercfg /setactive SCHEME_MIN >> %LOGFILE%

echo === SYSTEM BOOST COMPLETE === >> %LOGFILE%
echo Log saved to %LOGFILE%
pause
