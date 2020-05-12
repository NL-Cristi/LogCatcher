 # __LogCatcher__
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
 
  ## The tool __ONLY__ is only for centralizing all logs in one place in a __ZIP__.
  
  We recomend you to inspect the zip before shareing it with anyone.

  The structure of the ZIP should be simillar to the following diagram: 

```bash
├───General
│       ├── HttpErr
│       │     ├── httperr*.config
│       ├── IISConfig
│       │     ├── administration.config
│       │     ├── applicationHost.config
│       │     └── redirection.config
│       ├── NETFramework
│       │     ├── assembly\*\*.config
│       │     ├── Framework\*\*.config
│       │     └── Framework64\*\*.config
│       ├── Application.evtx
│       ├── LOGS.CSV
│       ├── OsInfo.txt
│       ├── Security.evtx
│       ├── Setup.evtx
│       ├── SiteOverview.csv
│       ├── System.evtx
│       └── ToolLog.log
│
└─── Sites
      ├── bin
      │    └── *.config
      ├── FrebLogs
      │    ├── u_ex*.log
      │    └── freb.xsl
      ├── IISLogs
      │    └── u_ex*.log
      ├── web.config
      └── *.config
```

 #
The tool will help you gather the right data at the right time.  
The tool collects logs that Microsoft Support Engineers use in order to diagnose __IIS__ issues. 


This tool is developed by <a class="github-button" href="https://github.com/crnegule/LogCatcher/blob/master/README.md#authorsGitHub">__members of the IIS Support Team__</a>  so it is ready to collect logs for issues we regularly encounter.

We would send this tool to you, generally as part of a support case, and gather data to help you diagnose your issue.  

You can also download the tool on your own from our GitHub page if you want to try to diagnose the issue by yourself.

Our main focus is around reducing troubleshooting time and improving response times for our customers. 


#

## Authors

* <a class="github-button" href="https://github.com/crnegule" data-icon="octicon-cloud-download" aria-label="Download ntkme/github-buttons on GitHub">Cristian Negulescu</a> 
* <a class="github-button" href="https://github.com/rogheorg" data-icon="octicon-cloud-download" aria-label="Download ntkme/github-buttons on GitHub">Roxana Gheorghe</a> 
### Please create a PR for any question or feature requests/changes .	


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
