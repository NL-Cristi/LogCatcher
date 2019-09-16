# LogCatcher
The tool we want to develop will be very simple and easy to use so that anyone can use it on their own, at their convenience and even before having to openea support case.

The tool will have a short splash screen to explain what it does. The following screen will show the customer exactly what files are collected from his system and will have a button to start the collection. A progress bar will let the customer know when the collection is done.

The tool will generate a zip file that contains the log files. The customer can then send the logs to us.

To start, we want the tool to collect the necessary logs for IIS troubleshooting since we are supporting IIS as our main technology. However, we recognize that there are many other technologies that run on top of IIS such as Exchange, SCCM, etc and we would like to extend the tool functionality in the future so that the log collection scenario can be customized for other teams. 

We wanted to make this tool available onGitHub, so that customers can use the tool without needing CSS
