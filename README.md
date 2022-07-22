 # ![Image of FirstScreen](/images/LogCatcher-img-48.png)   __LogCatcher__ ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/crnegule/logcatcher?style=plastic) ![GitHub release (latest by date)](https://img.shields.io/github/downloads/crnegule/logcatcher/latest/total)

 ![GitHub all releases](https://img.shields.io/github/downloads/crnegule/logcatcher/total?style=plastic)
 ![GitHub issues](https://img.shields.io/github/issues-raw/crnegule/logcatcher?style=plastic)
 [Download LatestZIP](https://github.com/crnegule/LogCatcher/releases/latest)|[How To Run First Time](https://github.com/crnegule/LogCatcher/blob/master/Docs/RunFirstTime.md) |[Tool Description](https://github.com/crnegule/LogCatcher/blob/master/Docs/ToolDescription.md)|[For 2008R2](https://github.com/crnegule/LogCatcher/blob/master/Docs/2008R2.md)
 -------------| -------------| -------------| -------------




#### The __LogCatcher__ Tool is designed to assist in troubleshooting various __IIS__ issues like the following:
 
>* SSL and SSL Server certificates issues
>* Runtime errors and exceptions, including HTTP 400 and 50x errors
>* 	Handler mappings
>* 	HTTP Redirection
>* 	Errors in the IIS management console
>* 	IIS Extensions, Tools, and Add-Ons issues
>* 	FTP service issues
>* 	Server farm configuration issues
 
 #

The tool collects logs that Microsoft Support Engineers use in order to diagnose __IIS__ issues. 




This tool is developed by  [__IIS Support Engineers__](https://github.com/crnegule/LogCatcher/blob/master/README.md#authors) so it is ready to collect logs for issues we regularly encounter.

We would send this tool to you, generally as part of a support case, and gather data to help you diagnose your issue.  

You can also download the tool on your own from our GitHub page if you want to try to diagnose the issue by yourself.

Our main focus is around reducing troubleshooting time and improving response times for our customers. 


#

__LogCatcher doesn't automatically upload the files to the Microsoft servers because we didn't want anyone to think that this tool collects data without your knowledge and approval. You can take a look at the zip archive generated by the tool and see exactly what data is collected and then choose to upload it to Microsoft for analysis.__
  
  We recommend you to inspect the zip before sharing it with anyone.

  The structure of the ZIP should be similar to the following diagram: 

```bash
LOGcatcher<Date of collection>.zip
    ├─── FolderContents.txt
    ├─── LogsInfo.CSV
    ├─── ToolLog.log
    │
    ├─── General
    │       ├── CertUtil
    │       │     └── *CertStoreName*.txt
    │       │
    │       ├── HttpErr
    │       │     └── httperr*.config
    │       │
    │       ├── IISConfig
    │       │     ├── administration.config
    │       │     ├── applicationHost.config
    │       │     └── redirection.config
    │       │
    │       ├── NETFramework
    │       │     ├── assembly\*\*.config
    │       │     ├── Framework\*\*.config
    │       │     └── Framework64\*\*.config
    │       │
    │       ├── NETSH-HTTP
    │       │     ├── cachestate.txt
    │       │     ├── iplisten.txt
    │       │     ├── servicestate.txt
    │       │     ├── sslcert.txt
    │       │     ├── timeout.txt
    │       │     └── urlacl.txt
    │       │
    │       ├── Application.evtx
    │       ├── Cap2.evtx
    │       ├── Security.evtx
    │       ├── Setup.evtx
    │       ├── SitesOverview.csv
    │       ├── SrvInfo.txt
    │       ├── System.evtx
    │       └── ToolLog.log
    │
    └─── Sites
            ├── bin
            │    └── *.config
	    │
            ├── FrebLogs
            │    ├── u_ex*.log
            │    └── freb.xsl
            │
            ├── IISLogs
            │    └── u_ex*.log
            ├── web.config
	    │
            └── *.config


```

 #


## Authors

* <a class="github-button" href="https://github.com/cristian-clamsen" data-icon="octicon-cloud-download" aria-label="Download ntkme/github-buttons on GitHub">Cristian Negulescu</a> 
* <a class="github-button" href="https://github.com/rogheorg" data-icon="octicon-cloud-download" aria-label="Download ntkme/github-buttons on GitHub">Roxana Gheorghe</a> 
* * <a class="github-button" href="https://github.com/nt-7" data-icon="octicon-cloud-download" aria-label="Download ntkme/github-buttons on GitHub">Naito Oshima</a> 
### Please create a PR for any question or feature requests/changes .	


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
