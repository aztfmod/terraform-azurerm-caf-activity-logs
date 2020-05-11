variable "resource_group_name" {
  description = "(Required) Name of the resource group to deploy the activity logs."
}

variable "location" {
  description = "(Required) Define the region where the resources will be created."
}

variable "diagnostic_name" {
  description = "name of the diagnostic setting"
}
variable "log_analytics_workspace_id" {
  description = "(Required) Id of the Log Analytics workspace"
}

variable "tags" {
  description = "(Required) Tags for the logs repositories to be created "
}

variable "enable_event_hub" {
  description = "(Optional) Determine to deploy Event Hub for the configuration"
  default = true
}

variable "convention" {
  description = "(Required) Naming convention method to use"  
}

variable "name" {
  description = "(Required) Name for the objects created (before naming convention applied.)"    
}

variable "prefix" {
  description = "(Optional) You can use a prefix to the name of the resource"
  type        = string
  default = ""
}

variable "postfix" {
  description = "(Optional) You can use a postfix to the name of the resource"
  type        = string
  default = ""
}

variable "max_length" {
  description = "(Optional) You can speficy a maximum length to the name of the resource"
  type        = string
  default = ""
}

variable "audit_settings_object" {
  description = "(Required) Contains the settings for Azure Audit activity log retention"
}
