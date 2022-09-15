local tooltips = require("modules/ui/tooltips")
local config = require("modules/utils/config")
local utils = require("modules/utils/miscUtils")
local CPS = require("CPStyling")

gsUI = {}

function gsUI.draw(mod)
    CPS:setThemeBegin()
	if (ImGui.Begin("FreeFly 2.0", ImGuiWindowFlags.AlwaysAutoResize)) then
        mod.settings.speed, changed = ImGui.SliderFloat("Fly Speed", mod.settings.speed, 0, 50, "%.2f")
        if changed then
            config.saveFile("config/config.json", mod.settings)
            if mod.nUI.nuiInstalled then
                mod.nUI.nui.setOption(mod.nUI.nativeOptions["speed"], mod.settings.speed)
            end
        end
        tooltips.drawBtn("?", "speed")
        mod.settings.speedIncrementStep, changed = ImGui.SliderFloat("Increase amount", mod.settings.speedIncrementStep, 0, 5, "%.2f")
        if changed then
            config.saveFile("config/config.json", mod.settings)
            if mod.nUI.nuiInstalled then
                mod.nUI.nui.setOption(mod.nUI.nativeOptions["speedIncrementStep"], mod.settings.speedIncrementStep)
            end
        end
        tooltips.drawBtn("?", "speedStep")

        mod.settings.angle, changed = ImGui.SliderFloat("Turning angle", mod.settings.angle, -4, 4, "%.2f")
        if changed then
            config.saveFile("config/config.json", mod.settings)
            if mod.nUI.nuiInstalled then
                mod.nUI.nui.setOption(mod.nUI.nativeOptions["angle"], mod.settings.angle)
            end
        end
        tooltips.drawBtn("?", "angle")

        mod.settings.noWeapon, changed = ImGui.Checkbox("No Weapons During Flight", mod.settings.noWeapon)
        if changed then
            config.saveFile("config/config.json", mod.settings)
            if mod.nUI.nuiInstalled then
                mod.nUI.nui.setOption(mod.nUI.nativeOptions["noWeapon"], mod.settings.noWeapon)
            end
        end
        tooltips.drawBtn("?", "noWeapon")

        mod.settings.timeStop, changed = ImGui.Checkbox("Stop time during flight", mod.settings.timeStop)
        if changed then
            config.saveFile("config/config.json", mod.settings)
            if mod.nUI.nuiInstalled then
                mod.nUI.nui.setOption(mod.nUI.nativeOptions["timeStop"], mod.settings.timeStop)
            end
        end

        if ImGui.Button("Reset all settings") then
            mod.settings = utils.deepcopy(mod.defaultSettings)
            config.saveFile("config/config.json", mod.settings)
            local options = {"timeStop", "noWeapon", "angle", "speedIncrementStep", "speed"}
            for _, option in pairs(options) do
                if mod.nUI.nuiInstalled then
                    mod.nUI.nui.setOption(mod.nUI.nativeOptions[option], mod.settings[option])
                end
            end
        end
	end
	ImGui.End()
	CPS:setThemeEnd()
end

return gsUI