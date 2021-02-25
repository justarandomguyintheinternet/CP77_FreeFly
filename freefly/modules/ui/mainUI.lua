mainUI = {}

function mainUI.draw(freefly)
	if (ImGui.Begin("FreeFly")) then
		ImGui.Text(string.format("Speed: %.1f", freefly.settings.speed))
		ImGui.Spacing()
		ImGui.Text(tostring(freefly.input.isMoving))
		freefly.settings.loadDefault, changed = ImGui.Checkbox("Keep config", freefly.settings.loadDefault)
		if changed then
			freefly.miscUtils.saveConfig(freefly)
		end
	end
end

return mainUI