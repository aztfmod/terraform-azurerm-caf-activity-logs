locals {
    convention = "random"
    name = "caftest"
    location = "southeastasia"
    prefix = "test"
    resource_groups = {
        test = { 
            name     = "test-caf"
            location = "southeastasia" 
        },
    }
    tags = {
        environment     = "DEV"
        owner           = "CAF"
    }

    azure_activity_logs_event_hub = true
    azure_activity_logs_retention = 180
}