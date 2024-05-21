# Windows10DriverGatling

This is a Gatling Gun PS1 file that scans for all .inf files in the current folder **and** all subfolders, and forcibly installs all of them, **regardless of which version of Windows you are running.** This is very useful if the normal driver installer says that it's not "compatible" with your current version of Windows.

### There's usually a reason driver installers do this. You should only run this if you have absolutely no other choice and you cannot install the specific version of Windows that your driver requires. You run this script at your own risk.

1. Put your driver in its own folder. MAKE SURE THERE ARE NO OTHER DRIVERS OR SUBFOLDERS IN THE FOLDER WHERE YOU PUT YOUR DRIVER.
2. Select this code: `Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/MilesFarber/Windows10DriverGatling/trainer/Windows10DriverGatling.ps1'))`
3. Right click and run a new Administrator Powershell window ***in the same directory as your driver.***
