<#
.Synopsis
   This cmdlet creates a custom list in a SharePoint site.
   It can be used to simulate large customer environments.
.DESCRIPTION
   When testing scripts or customisations; it is useful to be able
   to test on a representative environment.
   This Cmdlet creates a list with a configurable number of list items.
.EXAMPLE
   To create a list with 50,000 list items; you would use the following:

   New-TestSPLargeList -Url "http://collaboration/sites/test-site" -NumberOfItems 50000 -ListTitle "Test list"

   Have fun! @moss_sjeffery
#>

function New-TestSPLargeList
{
	Param 
	(
		[string]$Url,
                [string]$ListTitle,
		[int]$NumberOfItems
	)
	
	asnp *sharepoint* -ErrorAction SilentlyContinue
	
	$targetWeb = Get-SPWeb $Url
	Write-Debug "Begin: add a new list"
	$targetWeb.Lists.Add("$ListTitle", "$ListTitle", $targetWeb.ListTemplates["Custom List"])
	Write-Debug "End: add a new list"
	Write-Debug "Begin: add custom fields"
	$list = $targetWeb.Lists["$ListTitle"]
	$list.Fields.Add("EmployeeCount","Number",0)
	$list.Fields.Add("Region", "Text", 0)
	$list.Fields.Add("Revenue", "Number", 0)
	$list = $targetWeb.Lists["ContosoCustomers"]
	Write-Debug "End: add custom fields"
	Write-Debug "Begin: add content"
	$titleArr = "Contoso", "ACME", "Northwind", "Tailspin", "TailGate", "AdventureWorks"
	$regionArr = "USA", "UK", "Germany", "France", "Spain", "Italy", "Norway", "Sweden", "Denmark"
	
	for ($i = 0; $i -le $NumberOfItems; $i++)
	{
		$title = Get-Random $titleArr
		$empCount = Get-Random -Minimum 1001 -Maximum 500000
		$region = Get-Random $regionArr
		$revenue = Get-Random -Minimum 3001 -Maximum 1200000
		$item = $list.Items.Add()
		$item["Title"] = $title
		$item["EmployeeCount"] = $empCount
		$item["Region"] = $region
		$item["Revenue"] = $revenue
		$item.Update()
		Write-Progress -Activity "Creating list items" -Status "Created: $i of $NumberOfItems" -PercentComplete (($i / $NumberOfItems) * 100)
	}
}


