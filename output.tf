
output "seclogs_map" {
    depends_on = [
        azurerm_storage_account.log, 
        azurerm_eventhub_namespace.log,
        azurerm_eventhub_namespace.log
        ]

    value = "${
        map(
            "activity_sa", "${azurerm_storage_account.log.id}",
            "activity_eh_name",  "${azurerm_eventhub_namespace.log.name}",
            "activity_eh_id", "${azurerm_eventhub_namespace.log.id}"
        )
    }"
}