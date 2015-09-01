<#
.Synopsis
      
   Site collections... Where are they when you need them?
   Use this Cmdlet to create a TONNE! of site collections.
   
.DESCRIPTION
   This cmdlet allows you to create a bunch of site collections.
   
.EXAMPLE
   Example of how to use this cmdlet:
   
   New-TestSPSiteCollection -UrlPrefix "http://intranet/sites" -OwnerAlias "Contoso\Administrator" -SiteCollectionTemplate "STS#0" -Language 1033 -SiteCollectionCount 250
	
   This will create 250 team site site collections with the EN-GB language.
   
   The naming convention for site collections is a random number, so the end results would be:
   
   http://intranet/sites/1234
   http://intranet/sites/2345
   etc...

.EXAMPLE
   Another example of how to use this cmdlet
#>
function New-TestSPSiteCollection
{
    Param
    (
        # For example: http://intranet/sites
        [Parameter(Mandatory=$true)]
        [string]$UrlPrefix,
		
		# Provide the owner alias; e.g. CONTOSO\Administrator
		[Parameter(Mandatory=$true)]
		[string]$OwnerAlias,
		
		# Provide the template Id; e.g. STS#0
		[Parameter(Mandatory=$true)]
		[string]$SiteCollectionTemplate,
		
		# Provide the language; e.g. 1033
		[Parameter(Mandatory=$true)]
		[int]$Language,
		
		# Provide the total number of site collections required
		[Parameter(Mandatory=$true)]
		[int]$SiteCollectionCount
    )

    Process
    {
		for ($i = 0; $i -lt $SiteCollectionCount; $i++)
		{ 
			$scName = Get-Random -Minimum 1001 -Maximum 999999
			New-SPSite $UrlPrefix/$scName -Language $Language -OwnerAlias $OwnerAlias -Template $SiteCollectionTemplate 
			Write-Progress -Activity "Creating site collections" -Status "Created: $i of $SiteCollectionCount" -PercentComplete (($i / $SiteCollectionCount) * 100)
		}
    }   
}
