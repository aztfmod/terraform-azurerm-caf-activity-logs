variable "resource_group_name" {
  description = "(Required) Name of the resource group to deploy the activity logs."
}

variable "location" {
  description = "(Required) Define the region where the resources will be created."
}

variable "tags" {
  description = "(Required) Tags for the logs repositories to be created "
  
}
variable "prefix" {
  description = "(Optional) You can use a prefix to add to the list of resource groups you want to create"
}

variable "logs_rentention" {
  description = "(Required) Number of days to keep the logs for long term retention"
}
