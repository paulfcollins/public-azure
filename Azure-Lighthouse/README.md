## [Azure Lighthouse Overview](https://docs.microsoft.com/en-us/azure/lighthouse/overview)

Azure Lighthouse offers service providers a single control plane to view and manage Azure across all their customers with higher automation, scale, and enhanced governance. With Azure Lighthouse, service providers can deliver managed services using comprehensive and robust management tooling built into the Azure platform. This offering can also benefit enterprise IT organizations managing resources across multiple tenants.

## Azure Lighthouse Demo

These folders contain the necessary ARM templates and scripts to demo setting up Azure Lighthouse

_arm-templates_ folder contains ARM Templates for set up delegated management at a Subscription or Resource Group level, 
the templates also define the Subscription Role Assignments in the Managed (Customer) tenant.

_policy-templates-samples_ folider contains two sample policy templates:
  * Audit Storage Accounts that do not have Secure Access (Https) enabled
  * Deny Storage Accounts from being created if Secure Access (Https) is disabled during the provisioning process

_scripts_ folder contains sample scripts to:
* Enable management of a Customer Tenant
* Query Azure Resource Manager (ARG) for storage accounts that do have Secure Transfer enabled
* Query ARG (as above) and deploy the Audit policy
* Query ARG (as above) and deploy the Deny policy
* Scripts to remove the assignments and definitions for the Audit and Deny polices

## Deploy the Demo

1. The first part of the process is the create Azure Active Directory groups that will be used to manage a 'Customer' Tenant. These groups could be based on specific roles and it easier to assign permissions to groups rather than having to manage indivdual users. Users that need access to the Tenant can then be added to the group appropriate to their role.
  * Create an AAD Group that will be assigned the _Contributor_** role
  * Create an AAD Group that will be assigned the _Resource Policy Contributor_** role
  * Add users to these groups
  
2. The process requires the _Id_ of the Tenant that will be the 'Management' Tenant. One way to find the tenant Id is to use the [Get-AzTenant](https://docs.microsoft.com/en-us/powershell/module/az.accounts/get-aztenant?view=azps-4.3.0) cmdlet either in [Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview) from the Azure Portal or via a PowerShell. After running the command and noting the returned value for the _TenantId_, it can then be used in the deployment scripts in the [Scripts Folder](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/deployment).
  
3. 