mainUI = {}

function mainUI.draw(freefly)
	if (ImGui.Begin("FreeFly")) then
		ImGui.Text(string.format("Speed: %.1f", freefly.speed))
		ImGui.Spacing()
		ImGui.Text(tostring(freefly.input.isMoving))
	end
end

return mainUI