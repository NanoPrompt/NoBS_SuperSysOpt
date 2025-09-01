@echo off
echo === Startup Audit === > logs/startup_audit.txt
echo --- Startup Programs --- >> logs/startup_audit.txt
wmic startup get caption,command >> logs/startup_audit.txt
echo --- Services --- >> logs/startup_audit.txt
sc query type= service state= all >> logs/startup_audit.txt
pause
