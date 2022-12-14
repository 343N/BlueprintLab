data:extend({
    {
        type = "bool-setting",
        name = "blueprint-lab-design-use-technology",
        setting_type = "startup",
        default_value = false
    },
    {
        type = "string-setting",
        name = "blueprint-lab-design-unlock-technology",
        setting_type = "startup",
        default_value = "automation",
        allowed_values = {"automation", "logistics", "logistics-2", "construction-robotics"}
    },
    {
        type = "bool-setting",
        name = "blueprint-lab-design-allow-all-technology",
        setting_type = "runtime-global",
        default_value = false
    },
    {
        type = "bool-setting",
        name = "blueprint-lab-design-disable-fog",
        setting_type = "runtime-global",
        default_value = false
    },
    {
        type = "bool-setting",
        name = "blueprint-lab-pause-game",
        setting_type = "runtime-global",
        default_value = true
    },
})