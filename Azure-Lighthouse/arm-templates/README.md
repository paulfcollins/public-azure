This folder contains ARM template and parameter files to deploy Azure Lighthouse in a 'Customer' Tenant
  
There are two deployment examples:
  
1. Subscription level  - uses _DelegatedResourceManagement.json_ and _DelegatedResourceManagement.parameters.json_
2. Resource Group level - uses _DelegatedResourceManagement.parameters.json_ and _rgDelegatedResourceManagement.parameters.json_
  
The parameters that need to be updated are:

* mspName
* mspOfferDescription
* managedByTenantId
  
The section below will also need to be edited to provide the appropriate values

`  
{
    "principalId": "<AAD GROUP ID>",
    "roleDefinitionId": "ENTER SUBSCRIPTION ROLE ID",
    "principalIdDisplayName": "<ENTER AAD GROUP NAME>"
}
`