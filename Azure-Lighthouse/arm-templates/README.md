# Arm Templates

This folder contains ARM template and parameter files to deploy Azure Lighthouse in a 'Customer' Tenant
  
There are two ARM Template examples:
  
1. Subscription level  - uses _DelegatedResourceManagement.json_ and _DelegatedResourceManagement.parameters.json_
2. Resource Group level - uses _DelegatedResourceManagement.parameters.json_ and _rgDelegatedResourceManagement.parameters.json_

**Note: You only need to make changes to the ARM Template parameters file as these values will be used when the deployment script is run**  

The parameters that need to be updated are:  

* mspName - this can be anything e.g. 'ACME Managed Services'
* mspOfferDescription - this can be anything e.g. 'ACME Managed Services'
* managedByTenantId - this is the value returned from the _Get-AzTenant_ cmdlet
  
If you are going to delegate a Resource Group, then there is an additional parameter in the _rgDelegatedResourceManagement.parameters.json_ file that needs to be updated:  
  
* rgName - this needs to be the name of the resource group that is being delegated 
  
The section below will also need to be edited to provide the appropriate values for permissions that are being assigned as part of the deployment:

```yaml  
{
    "principalId": "<AAD GROUP ID>",
    "roleDefinitionId": "ENTER SUBSCRIPTION ROLE ID",
    "principalIdDisplayName": "<ENTER AAD GROUP NAME>"
}
```

Use `(Get-AzADGroup -DisplayName '<AAD GROUP NAME').id` to get the value required for _principalId_.  
Use `(Get-AzRoleDefinition -Name 'Contributor').id` as an example to get the value of the `Contributor` role for _roleDefinitionId_.  
Use the Display Name of the Azure AD Group that role is being assigned to for _principalIdDisplayName_.  
  
[ **Note:** additional sections will be required if more than one role is being assigned, as will the the _roleDefinitionId_ for those roles.]  
  
To deploy Azure Policy to a delegated subscription, the _roleDefinitionId_ for the **Resource Policy Contributor** role is required.
  
It is also [recommended](https://docs.microsoft.com/en-us/azure/lighthouse/how-to/onboard-customer) to assign the **Managed Services Registration assignment Delete Role** Id (91c1777a-f3dc-4fae-b103-61d183457e46) to templates. This allows designated users to remove a delegation from a customer tenant if required.  
  
Below is a screenshot of a sample Parameters file:  
![ARM Template Parameters File](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/exampleARMtemplateParams.png)  
  
The _Contributor_ role has a _roleDefinitionId_ of `b24988ac-6180-42a0-ab88-20f7382dd24c`  
The _Resource Policy Contributor_ role has a _roleDefinitionId_ of `36243c78-bf99-498c-9df9-86d9f8d28608`  
