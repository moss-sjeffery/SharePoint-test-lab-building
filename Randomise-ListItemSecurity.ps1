<#
	Randomise security 
	These two Cmdlets can be used to randomise list item security.
	To use Randomise-ListItemSecurity, you need to pass in three parameters:

	1. Site url
	2. List title
	3. % of total list items that you want to break security inheritance on.

	Example:
	
	Randomise-ListItemSecurity -SiteUrl "http://content.contoso.com" -ListTitle "Customer list" -RandomisePercentage 50

	The second Cmdlet will return/ confirm any list items that have unique permissions. 
#>
asnp *sharepoint* -ErrorAction SilentlyContinue

function Randomise-ListItemSecurity
{
	Param
	(
		[string]$SiteUrl,
		[string]$ListTitle,
		[int]$RandomisePercentage
	)

	$site = Get-SPWeb $SiteUrl
	$targetList = $site.Lists | where {$_.Title -eq $ListTitle}
	
	Write-Host $site.Title
	Write-Host $targetList.Title
	
	$t = $targetList.ItemCount
	$i = $RandomisePercentage * $t / 100
	$items = [Math]::Round($i, 0)
		
	$itemArrary = $targetList.get_Items() | Get-Random -Count $items
	foreach ($item in $itemArrary)
	{
		$item.BreakRoleInheritance($true)
		$item.Update()
	}
}

function Check-ListItemSecurity
{
	Param
	(
		[string]$SiteUrl,
		[string]$ListTitle
	)
	
	$site = Get-SPWeb $SiteUrl
	$list = $site.Lists | Where {$_.Title -eq $listTitle}
	$items = $list.Get_Items()
	foreach ($item in $items)
	{
		if ($item.HasUniqueRoleAssignments)
		{
			Write-Host $item.HasUniqueRoleAssignments $item.Id $item.Title
		}
	}
}


