resource "azurerm_resource_group" "rg_test" {
  name     = local.resource_groups.test.name
  location = local.resource_groups.test.location
  tags     = local.tags
}

module "la_test" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "2.2.0"
  
  location                  = local.location
  name                      = local.laname
  solution_plan_map         = {}
  prefix                    = "log"
  resource_group_name       = azurerm_resource_group.rg_test.name
  tags                      = local.tags
  convention                = local.convention
}

module "al_test" {
  source = "../../"
  
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
