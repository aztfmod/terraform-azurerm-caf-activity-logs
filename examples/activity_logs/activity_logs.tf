resource "azurerm_resource_group" "rg_test" {
  name     = local.resource_groups.test.name
  location = local.resource_groups.test.location
  tags     = local.tags
}

module "al_test" {
  source = "../../"
  
    convention          = local.convention
    location            = local.location
    name                = local.name
    
    prefix              = local.prefix
    tags                = local.tags

    resource_group_name = azurerm_resource_group.rg_test.name
    
    logs_rentention     = local.azure_activity_logs_retention
    enable_event_hub    = local.azure_activity_logs_event_hub
}
