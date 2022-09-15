local config = require("modules/utils/config")

local settings = {
    nativeOptions = {},
    nuiInstalled = false,
    nui = nil
}

function settings.setupNative(mod)
    local nativeSettings = GetMod("nativeSettings")
    settings.nui = nativeSettings

    if not nativeSettings then
        print("[FreeFly] Info: NativeSettings lib not found, use the ImGui UI instead!")
        return
    end

    local cetVer = tonumber((GetVersion():gsub('^v(%d+)%.(%d+)%.(%d+)(.*)', function(major, minor, patch, wip) -- <-- This has been made by psiberx, all credits to him
        return ('%d.%02d%02d%d'):format(major, minor, patch, (wip == '' and 0 or 1))
    end)))

    if cetVer < 1.18 then
        print("[FreeFly] Error: CET version below recommended!")
        return
    end

    settings.nuiInstalled = true

    nativeSettings.addTab("/freefly", "Freefly")
    nativeSettings.addSubcategory("/freefly/gen", "General Settings")

    settings.nativeOptions["speed"] = nativeSettings.addRangeFloat("/freefly/gen", "NoClip Speed", "Controls how fast you fly", 0.01, 50, 0.01, "%.2f",  mod.settings.speed,  mod.defaultSettings.speed, function(value)
        mod.settings.speed = value
        config.saveFile("config/config.json", mod.settings)
    end)

    settings.nativeOptions["speedIncrementStep"] = nativeSettings.addRangeFloat("/freefly/gen", "Increase amount", "This is the value by which the speed gets increased / decreased when scrolling", 0, 5, 0.01, "%.2f",  mod.settings.speedIncrementStep,  mod.defaultSettings.speedIncrementStep, function(value)
        mod.settings.speedIncrementStep = value
        config.saveFile("config/config.json", mod.settings)
    end)

    settings.nativeOptions["angle"] = nativeSettings.addRangeFloat("/freefly/gen", "Turning angle", "Changing this value makes you fly in smooth curves / circles. Great for cinematic shots", -4, 5, 0.01, "%.2f",  mod.settings.angle,  mod.defaultSettings.angle, function(value)
        mod.settings.angle = value
        config.saveFile("config/config.json", mod.settings)
    end)

    settings.nativeOptions["noWeapon"] = nativeSettings.addSwitch("/freefly/gen", "No Weapons During Flight", "Use this option to disable weapons during flight",  mod.settings.noWeapon,  mod.defaultSettings.noWeapon, function(state)
        mod.settings.noWeapon = state
        config.saveFile("config/config.json", mod.settings)
    end)

    settings.nativeOptions["timeStop"] = nativeSettings.addSwitch("/freefly/gen", "Stop time during flight", "Check this option if you want to stop time during flight",  mod.settings.timeStop,  mod.defaultSettings.timeStop, function(state)
        mod.settings.timeStop = state
        config.saveFile("config/config.json", mod.settings)
    end)
end

return settings