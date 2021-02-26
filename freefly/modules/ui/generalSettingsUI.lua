gsUI = {
    tooltips = require("modules/ui/tooltips")
}

function gsUI.draw(freefly)
    freefly.settings.speed, changed = ImGui.SliderFloat("Fly Speed", freefly.settings.speed, 0, 25, "%.1f")
    if changed then
		freefly.miscUtils.saveConfig(freefly)
	end
    gsUI.tooltips.drawBtn(freefly, "?", "speed")
    freefly.settings.speedIncrementStep, changed = ImGui.SliderFloat("Increase amount", freefly.settings.speedIncrementStep, 0, 5, "%.1f")
    if changed then
		freefly.miscUtils.saveConfig(freefly)
	end
    gsUI.tooltips.drawBtn(freefly, "?", "speedStep")

    freefly.settings.angle, changed = ImGui.SliderFloat("Turning angle", freefly.settings.angle, -4, 4, "%.2f")
    if changed then
		freefly.miscUtils.saveConfig(freefly)
	end
    gsUI.tooltips.drawBtn(freefly, "?", "angle")

    pressed = ImGui.Button("Reset settings")
    if pressed then
        freefly.settings.speed = freefly.settingsDefault.speed
        freefly.settings.speedIncrementStep = freefly.settingsDefault.speedIncrementStep
        freefly.settings.angle = freefly.settingsDefault.angle
        freefly.miscUtils.saveConfig(freefly)
    end
end

return gsUI