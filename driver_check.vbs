Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_PnPSignedDriver")
For Each objItem in colItems
    WScript.Echo "Device: " & objItem.DeviceName & " | Status: " & objItem.DriverVersion
Next
