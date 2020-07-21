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
<!--- END_TF_DOCS --->