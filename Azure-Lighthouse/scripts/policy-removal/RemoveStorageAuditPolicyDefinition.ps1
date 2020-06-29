# Using Resource Graph to detect storage accounts not being secured by https
Write-Host 'Importing required modules' -ForegroundColor Green
Install-Module -Name Az.ResourceGraph

# [ Update the Tenant ID as appropriate ]
$MspTenant = "<ENTER YOUR TENANTID>"

# [ Get Managed Subscriptions ]
$subs = Get-AzSubscription

$ManagedSubscriptions = Search-AzGraph -Query "ResourceContainers | where type == 'microsoft.resources/subscriptions' | where tenantId != '$($mspTenant)' | project name, subscriptionId, tenantId" -subscription $subs.subscriptionId

# Deploying Azure Policy using ARM templates at scale across multiple customer scopes, to deny creation of storage accounts not using https

Write-Host "In total, there are $($ManagedSubscriptions.Count) delegated customer subscriptions to be managed" -ForegroundColor Green

foreach ($ManagedSub in $ManagedSubscriptions)
{
    Select-AzSubscription -subscriptionId $ManagedSub.subscriptionId

    Remove-AzDeployment -Name AzlRemoveDenyDefinition -AsJob

    $Assignment = Get-AzPolicyDefinition | where-object {$_.Name -like "audit-https-storage"}

    if ([string]::IsNullOrEmpty($Assignment))
    {
        Write-Host "No Policy Definition found" -ForegroundColor Green
    }
    else
    {
    Remove-AzPolicyDefinition -Name 'audit-https-storage' -SubscriptionId $ManagedSub.subscriptionId -Verbose

    Write-Host "Polcy Definition has been deleted" -ForegroundColor Green
    }
}