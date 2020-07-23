locals {
  module_tag          = {
    "module" = basename(abspath(path.module))
  }
  tags                = merge(var.tags,local.module_tag)
}

data "azurerm_subscription" "current" {
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
