The LogCatcher Tool is designed to assist in troubleshooting various IIS issues like the following:
 
•	SSL and SSL Server certificates issues
•	Runtime errors and exceptions, including HTTP 400 and 50x errors
•	Handler mappings
•	HTTP Redirection
•	Errors in the IIS management console
•	IIS Extensions, Tools, and Add-Ons issues
•	FTP service issues
•	Server farm configuration issues
 
The tool will help you gather the right data at the right time.  The tool collects the set of logs that Microsoft Support Engineers need in order to diagnose the issues listed above. 
This tool is developed by members of the IIS Support Team within Microsoft so it is ready to diagnose the kinds of issues we see regularly. 
We will send this tool to you, generally as part of a support case, and gather data to help you diagnose your issue.  You can also download the tool on your own from our GitHub page if you want to try to diagnose the issue by yourself.
Our main focus is around reducing troubleshooting time and improving response times for our technical support customers. 
 
When you first launch the tool, you will see a screen with a brief description of how to use the tool and what each of the buttons does. At the bottom you can see a list of the sites that are hosted on the server, their corresponding application pools and the content location. 
If you want to filter-down the amount of data collected from your system, you can choose  for how many days to collect data, and for which sites to collect data by specifying the site ID. We wanted to add this feature so that we are completely transparent about  the amount of data collected from your system.
 ![Image of FirstScreen](/images/FirstScreen.jpg)
 
 
Once you are done with the filtering you can press the "GENERATE ZIP" button and begin the log collection.  The status bar will let you know once everything is collected and packaged up into a zip file and where you can find the zip file.
 
  ![Image of GeenGenerate](https://github.com/crnegule/LogCatcher/images/GreenGenerateZip.jpg)
 
File Explorer will open automatically the folder where the logs .zip file is saved.
The tool also has an About tab where you can find more details about how you can use the tool and which files are collected from your system.
 
  ![Image of AboutTab](https://github.com/crnegule/LogCatcher/images/ToolAbout.jpg)
 
If you need to collect logs from multiple servers and you don't want to click through each time or if you simply like doing everything from the command line you can also run the tool from the PowerShell command-line, without any UI. You can get more information about how to do this by be running the Get-Help command. Below I have added some examples of how to run the tool from the PowerShell CLI, and what parameters you can use, 
 
 
 
    -------------------------- EXAMPLE 1 --------------------------
 
    PS C:\>To start Tool with UI
 
    .\LogCatcher.ps1
 
 
 
 
    -------------------------- EXAMPLE 2 --------------------------
 
    PS C:\>To start Tool with CLI and custom ZIP location
 
    .\LogCatcher.ps1 -Quiet $true -ZipLocation "C:\Temp"
 
 
 
 
    -------------------------- EXAMPLE 3 --------------------------
 
    PS C:\>To change AGE of logs and Sites that are collected:
 
    .\LogCatcher.ps1 -Quiet $true -LogAge 45 -SiteIds "1,2,3,4"
 
 
 
 
    -------------------------- EXAMPLE 4 --------------------------
 
    PS C:\>Example showing all Param options:
 
    .\LogCatcher.ps1 -Quiet $true -LogAge 45 -SiteIds "1,2,3,4" -ZipLocation "C:\Temp"
 
 
To download, visit this location: https://github.com/crnegule/LogCatcher 
 
Please contact us at … @microsoft.com if you have any questions or feedback.
