# Using Resource Graph to detect storage accounts not being secured by https
Write-Host 'Importing required modules' -ForegroundColor Green
Install-Module -Name Az.ResourceGraph
# import-module Az.Resources

# [ Update the Tenant ID as appropriate ]
$MspTenant = "<ENTER YOUR TENANTID>"

# [ Get Managed Subscriptions ]
$subs = Get-AzSubscription

$ManagedSubscriptions = Search-AzGraph -Query "ResourceContainers | where type == 'microsoft.resources/subscriptions' | where tenantId != '$($mspTenant)' | project name, subscriptionId, tenantId" -subscription $subs.subscriptionId

# Search-AzGraph -Query "Resources | where type =~ 'Microsoft.Storage/storageAccounts' | project name, location, subscriptionId, tenantId, properties.supportsHttpsTrafficOnly" -subscription $ManagedSubscriptions.subscriptionId | convertto-json

# Deploying Azure Policy using ARM templates at scale across multiple customer scopes, to deny creation of storage accounts not using https

Write-Host "In total, there are $($ManagedSubscriptions.Count) delegated customer subscriptions to be managed" -ForegroundColor Green

foreach ($ManagedSub in $ManagedSubscriptions)
{
    Select-AzSubscription -SubscriptionId $ManagedSub.subscriptionId
    Write-Host "Deploying Azure Policy to prevent deployment of storage accounts not using https to $($ManagedSub.Name)" -ForegroundColor Green

    # [ UPDATE THE VARIABLES AS REQUIRED ]
    $DeploymentName = 'AzlStorageAuditPolicy'                     
    $location = 'northeurope'
    $policytemplateURI = 'https://raw.githubusercontent.com/paulfcollins/public-azure/master/Azure-Lighthouse/policy-template-samples/enforceHttpsStorage.json' 

    New-AzDeployment -Name $DeploymentName `
        -Location $location `
        -TemplateUri $policytemplateURI `
        -AsJob
}