[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Configures the Azure Activity Logs for a subscription

Configures the Azure Activity Logs rention for a subscription into:
1. Event Hub for short term and fast access (optional).
2. Storage account for long term retention. 
3. Log Analytics

Reference the module to a specific version (recommended):
```hcl
module "activity_logs" {
    source  = "aztfmod/caf-activity-logs/azurerm"
    version = "0.x.y"
    
  convention                 = local.convention
  location                   = local.location
  name                       = local.name
  diagnostic_name            = local.diagnostic_name
  log_analytics_workspace_id = module.la_test.id
  prefix                     = local.prefix
  tags                       = local.tags
  audit_settings_object      = local.audit

  resource_group_name        = azurerm_resource_group.rg_test.name
    
  enable_event_hub           = local.azure_activity_logs_event_hub
}
```

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| audit\_settings\_object | (Required) Contains the settings for Azure Audit activity log retention | `any` | n/a | yes |
| convention | (Required) Naming convention method to use | `any` | n/a | yes |
| diagnostic\_name | name of the diagnostic setting | `any` | n/a | yes |
| enable\_event\_hub | (Optional) Determine to deploy Event Hub for the configuration | `bool` | `true` | no |
| location | (Required) Define the region where the resources will be created. | `any` | n/a | yes |
| log\_analytics\_workspace\_id | (Required) Id of the Log Analytics workspace | `any` | n/a | yes |
| max\_length | (Optional) You can speficy a maximum length to the name of the resource | `string` | `""` | no |
| name | (Required) Name for the objects created (before naming convention applied.) | `any` | n/a | yes |
| postfix | (Optional) You can use a postfix to the name of the resource | `string` | `""` | no |
| prefix | (Optional) You can use a prefix to the name of the resource | `string` | `""` | no |
| resource\_group\_name | (Required) Name of the resource group to deploy the activity logs. | `any` | n/a | yes |
| tags | (Required) Tags for the logs repositories to be created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| seclogs\_map | Ouputs a map with storage account id (activity\_sa), eventhub name (activity\_eh\_name) and id (activity\_eh\_id) - if enabled |

<!--- END_TF_DOCS --->