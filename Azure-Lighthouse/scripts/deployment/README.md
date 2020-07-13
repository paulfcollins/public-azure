# Deployment Scripts  

his folder contains two scripts to deploy Azure Lighthouse into a 'Customer' Tenant.

1. Via Cloud Shell - `deployAzL-cloudshell.ps1`
2. Via Visual Studio Code on a local machine (Windows or Linux) - `deployAzL-vscode.ps1`
  
The [Arm Templates folder](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/arm-templates) has example templates to enable Azure Lighthouse at:
  
1. Subscription level and uses _DelegatedResourceManagement.json_ and _DelegatedResourceManagement.parameters.json_
2. Resource Group level and uses _DelegatedResourceManagement.parameters.json_ and _rgDelegatedResourceManagement.parameters.json_
  
The scripts are targeting a Subscription, so update the scripts if you wish to target a Resource Group.  
  
**Note:** Update the paths in the scripts to reflect the folder where the files have been uploaded or downloaded to.  
  
Once the deployment has completed successfully, in addition to the screenshots shown on the ['root' README.md](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse#deploy-the-demo), it is also possible to confirm the Role Permissions in more detail by clicking the Role Assignments link from the _Delegations_ view in either the **My Customers** or **Service Providers** view as shown below:
  
![Subscription Role Assignments](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/confirmmsproles.png)
