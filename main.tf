locals {
  module_tag          = {
    "module" = basename(abspath(path.module))
  }
  tags                = merge(var.tags,local.module_tag)
}

data "azurerm_subscription" "current" {
}

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}
