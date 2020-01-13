Function PopulateForm {
    Add-Type -AssemblyName PresentationFramework 
    [xml]$form = Get-Content -Path $FormLocation
    
    $NodeReader = (New-Object System.Xml.XmlNodeReader $Form)
    $XamlReader = [Windows.Markup.XamlReader]::Load( $NodeReader ) 
        
    $filteredstart = $XamlReader.FindName("createFilteredZIP")
    $days = $XamlReader.FindName("FilteredDays")
    $filteredSiteID = $XamlReader.FindName("FilteredSiteID")
    $sitesDataGrid = $XamlReader.FindName("sitesDataGrid")
    $barCatchStatus = $XamlReader.FindName("StatusBar")
    $update = $XamlReader.FindName("ProgressBarText")

    $days.text = $DefaultMaxDays
    $filteredSiteID.text = $DefaultFilteredSitesIDs
    $arrproc = New-Object System.Collections.ArrayList
    $CurrentSites = GetSiteStatus 
    $arrproc.addrange(@($CurrentSites))
    $sitesDataGrid.ItemsSource = @($arrproc)
    
    $filteredstart.add_click( {
            $barCatchStatus.value = "0"
            $MaxDays = $days.text
            $stringFilteredSitesIDs = $filteredSiteID.text
            $FilteredSitesIDs = $stringFilteredSitesIDs.split(",", [System.StringSplitOptions]::RemoveEmptyEntries)
            CatchFilteredIISzip 
            $barCatchStatus.value = "100"
            $update.text = "Zip generated at:  $FilteredZipFile"
            
            Invoke-Item $scriptPath
        })
             
    $XamlReader.ShowDialog() 
}