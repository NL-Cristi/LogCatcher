### To to run tool first time please follow the steps below: 

__1.__ Download the latest ZIP from  : https://github.com/crnegule/LogCatcher/releases/latest

__2.__ Right Click the zip and select the option __Unblock__.

 ![Image of Unblock](/images/Unblock.jpg)

__3.__ Unzip the archive. 

__4.__ Move to the unzipped folder :
``` 
cd C:\temp\LogCatcherV2.2
``` 

__5.__ Run this to command before running the tool:
``` 
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force:$true
``` 
__6.__ Then you can run the tool with:

*  For UI: `.\LogCatcher.ps1`
*  For CLI: 
        `.\LogCatcher.ps1 -Quiet $true -ZipLocation c:\temp -LogAge 42 -SiteIds "1,2"`
* For Help :
        `get-help .\LogCatcher.ps1`
 
