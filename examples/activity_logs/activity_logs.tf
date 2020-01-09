module "rg_test" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"
  
    prefix          = local.prefix
    resource_groups = local.resource_groups
    tags            = local.tags
}

module "al_test" {
  source = "../../"
  
    convention          = local.convention
    location            = local.location
    name                = local.name
    
    prefix              = local.prefix
    tags                = local.tags

    resource_group_name = module.rg_test.names.test
    
    logs_rentention     = local.azure_activity_logs_retention
    enable_event_hub    = local.azure_activity_logs_event_hub
}
