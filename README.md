[![Build status](https://dev.azure.com/azure-terraform/Blueprints/_apis/build/status/modules/activity_logs)](https://dev.azure.com/azure-terraform/Blueprints/_build/latest?definitionId=7)
# Configures the Azure Activity Logs for a subscription

Configures the Azure Activity Logs rention for a subscription into:
1. Event Hub for short term and fast access.
2. Storage account for long term retention. 

Reference the module to a specific version (recommended):
```hcl
module "activity_logs" {
    source  = "aztfmod/caf-activity-logs/azurerm"
    version = "0.1"
    
    resource_group_name   = var.rg
    location              = var.locations
    tags                  = var.tags
    prefix                = var.prefix
    logs_rentention       = var.retention
}
```

# Parameters

## resource_group_name
(Required) (Required) Name of the resource group to deploy the activity logs.
```hcl
variable "resource_group_name" {
  description = "(Required) Name of the resource group to deploy the activity logs."
}

```
Example
```hcl
    resource_group_name   = "myrg" 
```

## location
(Required) Define the region where the resources will be created
```hcl
variable "location" {
  description = "(Required) Define the region where the resources will be created"
}
```
Example
```hcl
    location   = "southeastasia"
```

## tags
(Required) Map of tags for the deployment
```hcl
variable "tags" {
  description = "(Required) map of tags for the deployment"
}
```
Example
```hcl
tags = {
    environment     = "DEV"
    owner           = "Arnaud"
    deploymentType  = "Terraform"
  }
```

## prefix
(Optional) You can use a prefix to add to the list of resource groups you want to create
```hcl
variable "prefix" {
    description = "(Optional) You can use a prefix to add to the list of resource groups you want to create"
}
```
Example
```hcl
locals {
    prefix = "${random_string.prefix.result}-"
}

resource "random_string" "prefix" {
    length  = 4
    upper   = false
    special = false
}
```

## logs_rentention
(Required) Number of days to keep the logs for long term retention (storage account)
```hcl
variable "logs_rentention" {
  description = "(Required) Number of days to keep the logs for long term retention"
}
```
Example
```hcl
logs_rentention = 60


```

## enable_event_hub 
(Optional) Determine to deploy Event Hub for the configuration
```hcl
variable "enable_event_hub" {
  description = "(Optional) Determine to deploy Event Hub for the configuration"
  default = true
}
```

Example
```hcl
enable_event_hub = false

```

# Output
```hcl
"seclogs_map" {
    value = "${
        map(
            "activity_sa", "${azurerm_storage_account.log.id}",
            "activity_eh_name",  "${azurerm_eventhub_namespace.log.name}",
            "activity_eh_id", "${azurerm_eventhub_namespace.log.id}"
        )
    }"
}
```