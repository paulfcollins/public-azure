# Using Resource Graph to detect storage accounts not being secured by https
Write-Host 'Importing required modules' -ForegroundColor Green
Install-Module -Name Az.ResourceGraph

# [ Update the Tenant ID as appropriate ]
$MspTenant = "<ENTER YOUR TENANTID>"

# [ Get Managed Subscriptions ]
$subs = Get-AzSubscription

# $ManagedSubscriptions = 
Search-AzGraph -Query "ResourceContainers | where type == 'microsoft.resources/subscriptions' | where tenantId != '$($mspTenant)' | project name, subscriptionId, tenantId" -subscription $subs.subscriptionId

