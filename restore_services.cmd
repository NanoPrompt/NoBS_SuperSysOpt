@echo off
echo === Restoring Services ===
for %%S in (
    "DiagTrack"
    "XblGameSave"
    "MapsBroker"
    "RetailDemo"
    "RemoteRegistry"
    "SysMain"
    "dmwappushservice"
) do (
    sc config %%S start= demand
    sc start %%S
)
echo === Services Restored ===
pause
