try {
	Set-ExecutionPolicy Unrestricted -Scope CurrentUser
	$CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
	if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
	{
		$StartTime = Get-Date
	}
	else
	{
		Write-Output "Running PowerShell Elevated."
		$ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
		$ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
		$ElevatedProcess.Verb = "runas"
		[System.Diagnostics.Process]::Start($ElevatedProcess)
		Exit
	}
 	
	$directory = $PSScriptRoot # Get the directory of the script file
	Write-Output "Script is running in $directory . MAKE SURE THIS IS THE CORRECT FOLDER AND THERE'S ABSOLUTELY NOTHING INSIDE IT EXCEPT THE DRIVER YOU WANT TO INSTALL. THIS OPERATION CANNOT BE REVERSED."
 	Read-Host -Prompt "Press Enter to start the script"
	$infiles = Get-ChildItem -Path $directory -Filter *.inf -Recurse -File
	foreach ($infile in $infiles) {
		Write-Output "Attempting to install $infile . Pass 1..."
		pnputil.exe /i /a $infile.FullName
	}
	foreach ($infile in $infiles) {
		Write-Output "Attempting to install $infile . Pass 2..."
		pnputil.exe /i /a $infile.FullName
	}
	foreach ($infile in $infiles) {
		Write-Output "Attempting to install $infile . Pass 3..."
		pnputil.exe /i /a $infile.FullName
	}
	
	$EndTime = Get-Date
	$TotalTime = $EndTime - $StartTime
	Write-Output "All tasks completed! The script wasted $($TotalTime.ToString()) of your life. Feel free to close this window, or wait 12 hours to automatically close it."
}
catch {
	Write-Host $_.Exception.Message
}
timeout /t 43210 /nobreak
