mainUI = {
	advancedSettingsUI = require("modules/ui/advancedSettingsUI"),
	generalSettingsUI = require("modules/ui/generalSettingsUI")
}

function mainUI.draw(freefly)
	freefly.CPS:setThemeBegin()
	if (ImGui.Begin("FreeFly 1.7", ImGuiWindowFlags.AlwaysAutoResize)) then
    	ImGui.SetWindowSize(415, 150)

		if ImGui.BeginTabBar("Tabbar", ImGuiTabBarFlags.NoTooltip) then
			freefly.CPS.styleBegin("TabRounding", 0)

			if ImGui.BeginTabItem("General Settings") then
				mainUI.generalSettingsUI.draw(freefly)
				ImGui.EndTabItem()
			end

			if ImGui.BeginTabItem("Advanced Settings") then
				mainUI.advancedSettingsUI.draw(freefly)
				ImGui.EndTabItem()
			end

			freefly.CPS.styleEnd(1)
            ImGui.EndTabBar()
		end

	end
	ImGui.End()
	freefly.CPS:setThemeEnd()
end

return mainUI
