# [Azure Lighthouse Overview](https://docs.microsoft.com/en-us/azure/lighthouse/overview)

Azure Lighthouse offers service providers a single control plane to view and manage Azure across all their customers with higher automation, scale, and enhanced governance. With Azure Lighthouse, service providers can deliver managed services using comprehensive and robust management tooling built into the Azure platform. This offering can also benefit enterprise IT organizations managing resources across multiple tenants.

## Table of Contents

* [Introduction](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse#introduction)  
* [Deploy the Demo](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse#deploy-the-demo)  
* [Manage a Subscription](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse#manage-a-customer-subscription)  
* [Deploy Azure Policy](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse#deploy-azure-policy-to-a-delegated-subscription)
* [Remove an Azure Policy](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse#remove-an-azure-policy-from-a-delegated-subscription)
* [Remove a Delegation](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse#remove-the-delegation-of-the-subscription)  

## Introduction

The goal I had in mind here was to show how an Enterprise customer with multiple Azure AD Tenants could manage those tenants effectively without necesarily having to use multiple portals with multiple accounts. In order to test this out I utilised a personal MSDN subscription (the MSP) and a subscription in a enterprise tenant.  
  
There are some key scenatios where Azure Lighthouse can be utilised as shown below:
![Azure Lighthouse Overview](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/lighthouseoverview.png)  
In this demo I chose to show how to deploy Azure Policy from an MSP tenant to an enterprise subscription.  
  
These folders contain the necessary ARM templates and scripts to demo setting up Azure Lighthouse. I utilised [Visual Studio Code](https://code.visualstudio.com/) to run the scripts but you could upload all the necessary files into Cloud Shell and deploy it all from there (I have included a sample script in the _scripts_ folder for this scenario).

The [_arm-templates_](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/arm-templates) folder contains ARM Templates for setting up delegated management at a Subscription or Resource Group level,  
the templates also define the Subscription Role Assignments in the Managed (Customer) tenant.

The [_policy-templates-samples_](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/policy-template-samples) folder contains two sample policy templates:

* Audit Storage Accounts that do not have Secure Access (Https) enabled
* Deny Storage Accounts from being created if Secure Access (Https) is disabled during the provisioning process

The [_scripts_](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts) folder contains sample scripts to:

* Enable management of a Customer Tenant [<Link>](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/deployment)
* Query Azure Resource Graph (ARG) for storage accounts that do not have Secure Transfer enabled [<Link>](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/policy-deployment)
* Query ARG (as above) and deploy the Audit policy [<Link>](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/policy-deployment)
* Query ARG (as above) and deploy the Deny policy [<Link>](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/policy-deployment)
* Scripts to remove the assignments and definitions for the Audit and Deny policies [<Link>](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/policy-removal)

## Deploy the Demo
  
### Steps 1, 2, & 3 are carried out in the Azure AD Tenant of the MSP (referred to as the 'Management' tenant below)

1. The first part of the process is the create Azure Active Directory groups in the 'Management' Tenant that will be used to manage a 'Customer' subscription. These groups could be based on specific roles and it is easier to assign permissions to groups rather than having to manage indivdual users. Users that need access to the 'Customer' subscription can then be added to the group appropriate to their role.
   * Create an AAD Group that will be assigned the **_Contributor_** role
   * Create an AAD Group that will be assigned the **_Resource Policy Contributor_** role
   * Add users to these groups
  
2. The process requires the _Id_ of the 'Management' Tenant. One way to find the _Tenant Id_ is to use the [Get-AzTenant](https://docs.microsoft.com/en-us/powershell/module/az.accounts/get-aztenant?view=azps-4.3.0) cmdlet either in [Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview) from the Azure Portal or via PowerShell. After running the command and noting the returned value for the _TenantId_, it will be used in the deployment template parameter file in the [Arm Templates Folder](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/arm-templates).
  
3. Next, we need the _Id_ of the Azure AD Group(s) and Subscription Role(s) and we get these by running the following cmdlets:
   * `(Get-AzADGroup -DisplayName '<AAD GROUP NAME>').id`
   * `(Get-AzRoleDefinition -Name 'Contributor').id`  
   [ **Note:** If you are assigning more than one Subscription Role, you will need to run that cmdlet to get the appropriate Ids and update the ARM Template to reflect those addtional roles]
  
4. Next, update the ARM Template Parameter file. The [README.md file](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/arm-templates/README.md) has more information on what needs to be updated.  
  
### The remaining steps are carried out in the context of the 'Customer' subscription

5. Now, log into the 'Customer' tenant using `Connect-AzAccount` using a non-guest account in the 'Customer' tenant. This account must have the [Owner builtin role](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#owner) for the subscription to be managed by the MSP via Azure Lighthouse.  
  
6. If the Subscription owner has access to multiple subscriptions, run `Get-AzContext` to check that the correct subscription is set. If not, then run the following:
   * `Get-AzSubscription`, identify the correct subscription and note the Subscription Id
   * `Set-AzContext -Subscription <SubscriptionId>`
  
7. Next, enable Azure Lighthouse using one of the scripts in the [Deployment scripts folder](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/deployment). The example deployment scripts use Cloud Shell or Visual Studio Code, but it would also be possible to run the scripts directly from Powershell. Ensure that you update the file location paths before running the scripts.

8. It can take several minutes after a successful deployment before it is visbile in the Azure Portal via two views:
   * Service Providers - in the 'Customer' portal
   * Azure Lighthouse / Manage your Customers - in the 'Management' Portal
  
Below is a screenshot of how it would look in the Azure Portal from the MSP point of view:
![My Customers view in Azure Portal](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/MSPLighthouseview.png)
  
Below is a screenshot from the point of view of the 'Customer':  
![Service Providers view in Azure Portal](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/customerviewofmsp.png)
  
## Manage a 'Customer' Subscription
  
After the successful delegation of subscription(s), it is possible to work in the context of the delegated subscription without switching directories as follows:

1. Select the **Directory + Subscription** icon in the top righthand corner of the Azure Portal.
2. Use the **Global subscription** filter and select the directory and delegated subscriptions as shown below:
![Directory and Subscription filter in Azure Portal](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/subscriptionpicker.png)
  
It is now possible to manage the delegated subscription based on the granted role assignments.
  
## Deploy Azure Policy to a Delegated Subscription
  
Let's take it a step further and deploy two sample policies to the delegated subscription. The scripts are in the [_policy-deployment_ folder](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/policy-deployment) within the _scripts_ folder.  
  
## Remove an Azure Policy from a Delegated Subscription  
  
Now that we have tested and proved the deplyment of Azure Policy to a Delegated 'Customer' Subscription, there a number of ways to remove the assigned policies and definitions:  

1. Via the Azure Portal as shown below:
![Delete Azure Policy via Portal](https://github.com/paulfcollins/public-azure/blob/master/Azure-Lighthouse/images/deletepolicyassignment1.png)  
This method is fine if you do not have too many Delegated Subscriptions, but using scripts would be more efficient for a scale deployment.  
2. Programmatically using the example scripts in the [_policy-removal_](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/policy-removal) folder. There are four sample scripts provided:  
   * Remove the Audit Policy assignment
   * Remove the Audit Policy definition
   * Remove the Deny Policy assignment
   * Remove the Deny Policy definition
  
## Remove the Delegation of the Subscription

Removing a Delegation can be achieved in one of two ways:  

1. Via the Azure Portal:
   * Subscription Owners can go to the Service Providers page and delete the delegation
   * Service Provider users who have been assigned the **Managed Services Registration Assignment Delete Role** can go the the My Customers page and delete the delegation
  
2. Programmatically using a script, an exmaple of which is available in the [_Removal_](https://github.com/paulfcollins/public-azure/tree/master/Azure-Lighthouse/scripts/removal) folder within the _scripts_ folder.  
  