This folder contains the scripts to remove Azure Policy Assignments and Definitions from a 'Customer' Tenant. 
  
There are four sample scripts provided: 
   * Remove the Audit Policy assignment - `RemoveStorageAuditPolicyAssignment.ps1`
   * Remove the Audit Policy definition - `RemoveStorageAuditPolicyDefinition.ps1`
   * Remove the Deny Policy assignment - `RemoveStorageDenyPolicyAssignment.ps1`
   * Remove the Deny Policy definition - `RemoveStorageDenyPolicyDefinition.ps1`
  
[**Note:** Ensure that you are running these in the context of the Service Provider] 
  
Each script will query ARG for the Delegated Subscriptions and then look for the Azure Policy assignments and definitions. Four scripts are provided to illustrate the process but it is possible to combine the deletion of the assignment and the definition within a single script. 
