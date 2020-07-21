# Defines the subscription-wide logging and eventing settings
# Creating the containers on Storage Account and Event Hub (optional)
resource "azurecaf_naming_convention" "caf_name_st" {  
  name              = var.name
  prefix            = var.prefix != "" ? var.prefix : null
  postfix           = var.postfix != "" ? var.postfix : null
  max_length        = var.max_length != "" ? var.max_length : null
  resource_type     = "azurerm_storage_account"
  convention        = var.convention
}

resource "azurecaf_naming_convention" "caf_name_evh" {  
  name              = var.name
  prefix            = var.prefix != "" ? var.prefix : null
  postfix           = var.postfix != "" ? var.postfix : null
  max_length        = var.max_length != "" ? var.max_length : null
  resource_type     = "azurerm_eventhub_namespace"
  convention        = var.convention
}

resource "azurerm_storage_account" "log" {
  name                      = azurecaf_naming_convention.caf_name_st.result
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
  
  name                    = azurecaf_naming_convention.caf_name_evh.result
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku                     = "Standard"
  capacity                = 2
  tags                    = local.tags
  auto_inflate_enabled    = false

}

resource "azurerm_monitor_diagnostic_setting" "audit" {
  name                           = var.diagnostic_name
  target_resource_id             = data.azurerm_subscription.current.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  eventhub_authorization_rule_id = var.enable_event_hub ? "${azurerm_eventhub_namespace.log[0].id}/authorizationrules/RootManageSharedAccessKey" : null
  eventhub_name                  = var.enable_event_hub ? azurerm_eventhub_namespace.log[0].name : null
  storage_account_id             = azurerm_storage_account.log.id

  dynamic "log" {
        for_each = var.audit_settings_object.log
        content {
            category    = log.value[0]
            enabled =     log.value[1]
        }
    } 
}