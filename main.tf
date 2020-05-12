locals {
  module_tag          = {
    "module" = basename(abspath(path.module))
  }
  tags                = merge(var.tags,local.module_tag)
}

data "azurerm_subscription" "current" {
}

provider "azurerm" {
  version = ">=2.8.0"
  features {}
}
