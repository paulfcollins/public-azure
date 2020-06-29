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

    Remove-AzDeployment -Name AzlRemoveDenyAssignment -AsJob

    $Assignment = Get-AzPolicyAssignment | where-object {$_.Name -like "audit-https-storage-assignment"}

    if ([string]::IsNullOrEmpty($Assignment))
    {
        Write-Host "No Policy Assignment found" -ForegroundColor Green
    }
    else
    {
    Remove-AzPolicyAssignment -Name 'audit-https-storage-assignment' -Scope "/subscriptions/$($ManagedSub.subscriptionId)" -Verbose

    Write-Host "Policy Assignment has been deleted" -ForegroundColor Green
    }
}