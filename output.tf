
output "seclogs_map" {
    description = "Ouputs a map with storage account id (activity_sa), eventhub name (activity_eh_name) and id (activity_eh_id) - if enabled"
    depends_on = [ azurerm_storage_account.log ]

    value = "${
        map(
            "activity_sa", azurerm_storage_account.log.id,
            "activity_eh_name", var.enable_event_hub == true ? azurerm_eventhub_namespace.log[0].name : null,
            "activity_eh_id", var.enable_event_hub == true ? azurerm_eventhub_namespace.log[0].id : null, 
        )
    }"
}