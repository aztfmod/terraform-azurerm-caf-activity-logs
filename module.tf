# Defines the subscription-wide logging and eventing settings
# Creating the containers on Storage Account and Event Hub (optional)
resource "azurecaf_naming_convention" "caf_name_st" {  
  name    = var.name
  prefix  = var.prefix != "" ? var.prefix : null
  postfix       = var.postfix != "" ? var.postfix : null
  max_length    = var.max_length != "" ? var.max_length : null
  resource_type    = "azurerm_storage_account"
  convention  = var.convention
}

resource "azurecaf_naming_convention" "caf_name_evh" {  
  name    = var.name
  prefix  = var.prefix != "" ? var.prefix : null
  postfix       = var.postfix != "" ? var.postfix : null
  max_length    = var.max_length != "" ? var.max_length : null
  resource_type    = "evh"
  convention  = var.convention
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
  # kafka_enabled         = true

}

resource "azurerm_monitor_diagnostic_setting" "audit" {

  name                           = var.name
  target_resource_id             = data.azurerm_subscription.current.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  eventhub_authorization_rule_id = var.enable_event_hub == true ? "${azurerm_eventhub_namespace.log[0].id}/authorizationrules/RootManageSharedAccessKey" : null
  eventhub_name                  = azurerm_eventhub_namespace.log[0].name
  storage_account_id             = azurerm_storage_account.log.id

  log {
      category = "Administrative"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
  log {
      category = "Security"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
  log {
      category = "ServiceHealth"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
  log {
      category = "Alert"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
  log {
      category = "Recommendation"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
  log {
      category = "Policy"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
  log {
      category = "Autoscale"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
  log {
      category = "ResourceHealth"
      enabled  = true
      retention_policy {
        days = 0
        enabled = false
      }
  }
}