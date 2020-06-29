Write-Host 'Sign in using an account on the Customer Tenant' -ForegroundColor Green

Connect-AzAccount

<# 
    Upload the Policy ARM Template Files to CloudShell 
    Update the paths below as required 
#>

$templatefile = "<FOLDER>/DelegatedResourceManagement.json"
$templateparameterfile = "<FOLDER>/DelegatedResourceManagement.parameters.json"

Write-Host 'Setting Internal Sub as target' -ForegroundColor Green

<# 
    I wanted to test against a single subscription, so specified the Subscription name
    If you don't know the Subscription name, then run the command first and then
    update the Subscription Name here as appropriate
    
    Also update the Deployment Name and Location as appropriate
#>

$mySub = Get-AzSubscription -SubscriptionName '<TARGET SUBSCRIPTION NAME>'
$DeploymentName = 'Lighthouse'                     
$location = 'northeurope'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
Set-AzContext -Subscription $mysub.SubscriptionId

Write-Host 'Enable Lighthouse Connection' -ForegroundColor Green
New-AzDeployment -Name $DeploymentName -Location $location -TemplateFile $templatefile -TemplateParameterFile $templateparameterfile -Verbose