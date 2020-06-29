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
