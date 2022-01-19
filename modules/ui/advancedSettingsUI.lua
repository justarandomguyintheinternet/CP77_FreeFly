asUI = {
    tooltips = require("modules/ui/tooltips")
}

function asUI.draw(freefly)
	freefly.settings.timeStep, changed = ImGui.SliderFloat("Teleport delay", freefly.settings.timeStep, 0, 0.15, "%.3f")
	if changed then
		freefly.miscUtils.saveConfig(freefly)
	end
	asUI.tooltips.drawBtn(freefly, "?", "tpDelay")

	freefly.settings.constantTp, changed = ImGui.Checkbox("Constant TP", freefly.settings.constantTp)
	if changed then
		freefly.miscUtils.saveConfig(freefly)
	end
	asUI.tooltips.drawBtn(freefly, "?", "constantTp")

	freefly.settings.loadDefault, changed = ImGui.Checkbox("Keep config", freefly.settings.loadDefault)
	if changed then
		freefly.miscUtils.saveConfig(freefly)
	end
	asUI.tooltips.drawBtn(freefly, "?", "keepConfig")

	freefly.settings.noWeapon, changed = ImGui.Checkbox("No Weapons During Flight", freefly.settings.noWeapon)
	if changed then
		freefly.miscUtils.saveConfig(freefly)
	end
	asUI.tooltips.drawBtn(freefly, "?", "noWeapon")

	pressed = ImGui.Button("Reset all settings")
	if pressed then
		freefly.settings = freefly.miscUtils.deepcopy(freefly.settingsDefault)
		freefly.miscUtils.saveConfig(freefly)
	end
end

return asUI