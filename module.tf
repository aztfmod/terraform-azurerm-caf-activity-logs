#Defines the subscription-wide logging and eventing settings
#Creating the containers on Storage Account and Event Hub (optional)

resource "random_string" "name" {
    length  = 24 - length(var.prefix)
    upper   = false
    special = false
}

locals {
    name = "${var.prefix}${random_string.name.result}"
}

resource "azurerm_storage_account" "log" {
  name                     = local.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  enable_https_traffic_only = true
  tags                     = local.tags
}

resource "azurerm_eventhub_namespace" "log" {
  count = var.enable_event_hub ? 1 : 0 
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 2
  tags                = local.tags
  auto_inflate_enabled = false
  kafka_enabled       = true
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
# updated Nov 08 2019 
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