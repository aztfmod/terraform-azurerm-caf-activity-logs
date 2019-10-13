#Defines the subscription-wide logging and eventing settings
#Creating the containers 
#Using EventHubs and Storage Account
#And defining fundamentals of subscription logging for all regions 

resource "random_string" "storageaccount_name" {
    length  = 3
    upper   = false
    special = false
}

resource "azurerm_storage_account" "log" {
  name                     = "seclogs${var.prefix}${random_string.storageaccount_name.result}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.location}"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  enable_https_traffic_only = true
  tags                     = local.tags
}

resource "azurerm_eventhub_namespace" "log" {
  name                = "seclogs${var.prefix}${random_string.storageaccount_name.result}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
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
# updated Oct 02 2019 
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
    "germanywestcentral"
  ]

# RootManageSharedAccessKey is created by default with listen, send, manage permissions
servicebus_rule_id = "${azurerm_eventhub_namespace.log.id}/authorizationrules/RootManageSharedAccessKey"
storage_account_id = "${azurerm_storage_account.log.id}"

  retention_policy {
    enabled = true
    days    = var.logs_rentention
  }
}