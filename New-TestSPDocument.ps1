<#
.Synopsis  
   Creates a bunch of dummy documents
.DESCRIPTION
   The Good Lab Guide 2015

   This good lab guide Cmdlet creates a number of randomly named documents for your lab.
.EXAMPLE
   Create a LOT of documents :)
   
   For example, you could create a bunch of files (50 actually) that are 10Mb in size by using:
   
   New-GLGSPDocument -LocalPath c:\test-docs\ -DocumentCount 50 -DocumentSizeMb 10

   Have fun & watch your disk space! :)
   @moss_sjeffery
#>
function New-TestSPDocument
{
    Param
    (
        # Enter the local path where you want the dummy documents created
        [Parameter(mandatory=$true)]
		[string]$LocalPath,
		# Provide the number of documents that you want created
        [Parameter(mandatory=$true)]
		[int]$DocumentCount,
		# Provide the size of documents required (in Mb)
		[Parameter(mandatory=$true)]
		[int]$DocumentSizeMb
    )

    Begin
    {
		$docNameP1 = "Contoso", "AdventureWorks", "Tailspin", "Northwind", "Acme", "ContosoLabs", "TailspinLabs", "NorthwindLabs", "AcmeLabs"
		$docNameP2 = "Report", "Proposal", "Figures", "Design", "Agenda", "Minutes", "Plan", "Menu", "Architecture", "Invoice", "Roadmap", "Strategy", "Event", "Environment" 
		$docNameP3 = ".docx", ".xlsx", ".pptx"
		
		if (!(Test-Path $LocalPath))
		{
			New-Item -ItemType Directory -Path $LocalPath	
		}
    }
    Process
    {
		Set-Location $LocalPath
		for ($i = 0; $i -lt $DocumentCount; $i++)
		{ 
		    $a = Get-Random $docNameP1
			$b = Get-Random $docNameP2
			$c = Get-Random $docNameP3
			$e = $a + "-" + $b + $c
			$f = $DocumentSizeMb * 1000000
			$go = fsutil file createnew $e $f
			Write-Progress -Activity "Creating documents" -Status "Created: $i of $DocumentCount" -PercentComplete (($i / $DocumentCount) * 100)
		}
    }
}
