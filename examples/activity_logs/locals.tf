locals {
    convention = "cafrandom"
    name = "caftest"
    laname = "caflogtest"
    diagnostic_name = "cafaudit"
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
    audit = {
        log = [
                    # ["Audit category name",  "Audit enabled)"] 
                    ["Administrative", true],
                    ["Security", true],
                    ["ServiceHealth", true],
                    ["Alert", true],
                    ["Recommendation", true],
                    ["Policy", true],
                    ["Autoscale", true],
                    ["ResourceHealth", true],

            ]
    }

    azure_activity_logs_event_hub = false
}