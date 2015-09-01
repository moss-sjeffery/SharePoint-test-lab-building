<#
.Synopsis
   Use this cmdlet to create a number of content databases.
.DESCRIPTION
   This Cmdlet will create a number of content databases for your lab environment.
.EXAMPLE
   New-TestSPContentDatabase -DatabaseName "WSS_Content_Intranet" -DatabaseServer "CONTOSOSQL" -DatabaseCount 10 -WebApplicationUrl "http://intranet"
   
   This will create 10 Content Databases. Each content database will have a number appended to the database name; e.g:
   
   WSS_Content_Intranet_GLG1
   WSS_Content_Intranet_GLG2
   WSS_Content_Intranet_GLG3
   
   etc...
   
   Have fun! @moss_sjeffery
#>
function New-TestSPContentDatabase
{
    Param
    (
        # Enter the Content Database Name
        [Parameter(Mandatory=$true)]
        [string]$DatabaseName,
		# Enter the SQL Server name
		[Parameter(Mandatory=$true)]
		[string]$DatabaseServer,
		# Enter the number of databases you want to create
		[Parameter(Mandatory=$true)]
		[int]$DatabaseCount,
		# Enter the web application name
		[Parameter(Mandatory=$true)]
		$WebApplicationUrl
    )

    Process
    {
		for ($i = 0; $i -lt $DatabaseCount; $i++)
		{ 
			$appendTitle = '_GLG'
			$appendNumber = $i
			$appendValue = $appendTitle + $appendNumber
			$actualDBName = $DatabaseName + $appendValue
			New-SPContentDatabase -Name $actualDBName -DatabaseServer $DatabaseServer -WebApplication $WebApplicationUrl
			Write-Host "Created content database: $actualDBName" -ForegroundColor DarkGreen
			Write-Progress -Activity "Creating content databases" -Status "Created: $i of $DatabaseCount" -PercentComplete (($i / $DatabaseCount) * 100)
		}
    }
}