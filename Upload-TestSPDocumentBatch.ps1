<#
.Synopsis
  
   Need to upload a stack of documents?
   This Cmdlet allows you to do just that :)
   
.DESCRIPTION
	
	
	This Cmdlet allows you to upload a tonne of documents to a document library;
	it's very cool.
	
	Enjoy :)
.EXAMPLE
   In the example below; we upload all documents in a document library to a SharePoint site:
   
   		Upload-TestSPDocumentBatch -LocalPath C:\SteveTemp -SharePointSiteUrl http://intranet -DocumentLibrary "Shared Documents"
#>
function Upload-TestSPDocumentBatch
{
    Param
    (
        # Enter local path - e.g. c:\Temp
        [Parameter(Mandatory=$true)]
        [string]$LocalPath,

        # Enter remote SharePoint site URL
        [Parameter(Mandatory=$true)]
		[string]$SharePointSiteUrl,
		
		# Enter remote Document libary name
		[Parameter(Mandatory=$true)]
		[string]$DocumentLibrary
    )

    Begin
    {
		Write-Debug "Begin: Get destination web object"
		$fileDestination = Get-SPWeb -Identity $SharePointSiteUrl
		Write-Debug "End: Get destination web object // found $reportDestination"
    }
    Process
    {
		Write-Debug "Begin: Attempting to upload report to document library"	
		$localFolder = Get-ChildItem -Path $LocalPath
		$totalFiles = $localFolder.count
		Write-Debug "Begin: Checking if local report can be found // found $localReport"
		Write-Debug "Begin: Get target document library"
		$fileTarget = $fileDestination.Lists.TryGetList($DocumentLibrary)
		$i = 0
		foreach($file in $localFolder)
		{
			Write-Debug "Begin: Uploading file now!"
			$fileStream = $file.OpenRead()
			$fileAdd = $fileTarget.RootFolder.Files.Add($file.Name, [System.IO.FileStream]$fileStream, $true)
			$fileStream.Close()
			$fileTarget.Update()
			Write-Debug "End: Attempting to upload report to document library"
			Write-Host "Uploaded $file" -ForegroundColor DarkGreen
			$i++
			Write-Progress -Activity "Uploading documents" -Status "Uploaded: $i of $totalFiles" -PercentComplete (($i / $totalFiles) * 100)
		}
    }
}
