mainUI = {}

function mainUI.draw(freefly)
    ImGui.SetNextWindowSize(100,65)
	if (ImGui.Begin("FreeFly")) then
		ImGui.Text(string.format("Speed: %.1f", freefly.speed))
	end
end

return mainUI