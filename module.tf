# Defines the subscription-wide logging and eventing settings
# Creating the containers on Storage Account and Event Hub (optional)

module "caf_name_st" {
  source = "github.com/aztfmod/terraform-azurerm-caf-naming.git?ref=proto"
  
  name    = var.name
  type    = "st"
  convention  = var.convention
}

module "caf_name_evh" {
  source = "github.com/aztfmod/terraform-azurerm-caf-naming.git?ref=proto"
  
  name    = var.name
  type    = "evh"
  convention  = var.convention
}

resource "azurerm_storage_account" "log" {
  name                      = module.caf_name_st.st
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  access_tier               = "Hot"
  enable_https_traffic_only = true
  tags                      = local.tags
}

resource "azurerm_eventhub_namespace" "log" {
  count = var.enable_event_hub ? 1 : 0 
  
  name                    = module.caf_name_evh.evh
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku                     = "Standard"
  capacity                = 2
  tags                    = local.tags
  auto_inflate_enabled    = false
  # kafka_enabled         = true

}

resource "azurerm_monitor_log_profile" "subscription" {
  name = "default"

  categories = [
    "Action",
    "Delete",
    "Write"
  ]

# Add all regions - > put in variable
# az account list-locations --query '[].name' 
# updated Dec 15 2019 
  locations = [
  "global",
  "eastasia",
  "southeastasia",
  "centralus",
  "eastus",
  "eastus2",
  "westus",
  "northcentralus",
  "southcentralus",
  "northeurope",
  "westeurope",
  "japanwest",
  "japaneast",
  "brazilsouth",
  "australiaeast",
  "australiasoutheast",
  "southindia",
  "centralindia",
  "westindia",
  "canadacentral",
  "canadaeast",
  "uksouth",
  "ukwest",
  "westcentralus",
  "westus2",
  "koreacentral",
  "koreasouth",
  "francecentral",
  "francesouth",
  "australiacentral",
  "australiacentral2",
  "uaecentral",
  "uaenorth",
  "southafricanorth",
  "southafricawest",
  "switzerlandnorth",
  "switzerlandwest",
  "germanynorth",
  "germanywestcentral",
  "norwaywest",
  "norwayeast"
  ]

# RootManageSharedAccessKey is created by default with listen, send, manage permissions
servicebus_rule_id = var.enable_event_hub == true ? "${azurerm_eventhub_namespace.log[0].id}/authorizationrules/RootManageSharedAccessKey" : null
storage_account_id = azurerm_storage_account.log.id

  retention_policy {
    enabled = true
    days    = var.logs_rentention
  }
}