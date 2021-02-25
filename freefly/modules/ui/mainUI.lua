mainUI = {
	advancedSettingsUI = require("modules/ui/advancedSettingsUI")
}

function mainUI.draw(freefly)
	freefly.CPS.setThemeBegin()
	if (ImGui.Begin("FreeFly 1.5")) then
    	ImGui.SetWindowSize(400, 200)

		if ImGui.BeginTabBar("Tabbar", ImGuiTabBarFlags.NoTooltip) then
			freefly.CPS.styleBegin("TabRounding", 0)
	
			if ImGui.BeginTabItem("General Settings") then

				ImGui.EndTabItem()
			end
	
			if ImGui.BeginTabItem("Advanced Settings") then
				mainUI.advancedSettingsUI.draw(freefly)
				ImGui.EndTabItem()
			end
	
		end
		
	end
	freefly.CPS.setThemeEnd()
end

return mainUI

-- ImGui.Text(string.format("Speed: %.1f", freefly.settings.speed))
-- 		freefly.settings.loadDefault, changed = ImGui.Checkbox("Keep config", freefly.settings.loadDefault)
-- 		if changed then
-- 			freefly.miscUtils.saveConfig(freefly)
-- 		end
-- 		tooltips.drawBtn(freefly, "?", "test")