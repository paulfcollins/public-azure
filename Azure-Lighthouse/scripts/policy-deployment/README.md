This folder contains the scripts to deploy Azure Policy into a 'Customer' Tenant.
  
The scripts query [Azure Resource Graph](https://azure.microsoft.com/en-us/features/resource-graph/) to identify resources that will be targets for Azure Policy.
  
The `$MSPTenant` variable in the scripts need to be updated with the _Tenant Id_ value returned by the _Get-AzTenant_ cmdlet.
  
*Exmaple Scripts*
  
1. Query Storage Accounts for the Secure Transfer setting
2. Deploy an Audit Policy for Storage Accounts where the Secure Transfer setting is disabled
3. Deploy a Deny Policy to prevent Storage Accounts being created with the Secure Transfer setting disabled