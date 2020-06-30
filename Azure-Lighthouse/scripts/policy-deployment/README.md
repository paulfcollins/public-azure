This folder contains the scripts to deploy Azure Policy into a 'Customer' Tenant.

[ **Note:** Before running these scripts make sure that you have running them under the context of the MSPTenant. Use `Connect-AzAccount` to switch if required ] 
  
The scripts query [Azure Resource Graph](https://azure.microsoft.com/en-us/features/resource-graph/) to identify resources that will be targets for Azure Policy.
  
The `$MSPTenant` variable in the scripts need to be updated with the _Tenant Id_ value returned by the `Get-AzTenant` cmdlet.
  
*Exmaple Scripts*
  
1. Query Storage Accounts for the Secure Transfer setting
2. Deploy an Audit Policy for Storage Accounts where the Secure Transfer setting is disabled 
Below are a couple of screenshots showing the Compliance of the deployed Azure Policy templates and a filtered view based on the Category that was assigned via the ARM Template 
![Azure Policy Compliance](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/auditpolicycompliance.png) 
![View of Azure Policies filtered by Category](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/policyfiltered.png) 
  
3. Deploy a Deny Policy to prevent Storage Accounts being created with the Secure Transfer setting disabled  
Once the Deny policy has been deployed, try to create a new Storage Account but disable the Secure Transfer option 
When the user tries to create the Storage Account, the policy will prevent the creation of the storage account as shown below:

![Failure to create Storage Account Error](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/denypolicy1.png)
![Error Details showing Policy denied creation](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/denypolicy2.png)
