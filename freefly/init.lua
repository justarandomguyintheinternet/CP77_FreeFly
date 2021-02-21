registerForEvent("onInit", function()

	isVisible = false

	move = false
	active = false
	moveDirection = "none"

	counter = 0
	speed = 1

	function noClipTp(direction)
		if (direction ~= "none") then
		    if direction == "forward" or direction == "backward" then
		      dir = Game.GetCameraSystem():GetActiveCameraForward()
		    elseif direction == "right" or direction == "left" then
		      dir = Game.GetCameraSystem():GetActiveCameraRight()
		    end
		    pos = Game.GetPlayer():GetWorldPosition()
		    if direction == "forward" or direction == "right" then
					xNew = pos.x + (dir.x * speed)
					yNew = pos.y + (dir.y * speed)
					zNew = pos.z + (dir.z * speed)
		    elseif direction == "backward" or direction == "left" then
					xNew = pos.x - (dir.x * speed)
					yNew = pos.y - (dir.y * speed)
					zNew = pos.z - (dir.z * speed)
		    elseif direction == "up" then
					xNew = pos.x
					yNew = pos.y
					zNew = pos.z + (0.5 * speed)
		    elseif direction == "down" then
					xNew = pos.x
					yNew = pos.y
					zNew = pos.z - (0.5 * speed)
		    end
		    tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
		    Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
	end	


end)

registerForEvent("onDraw", function()
	if (isVisible) then
		ImGui.SetNextWindowSize(100,65)
		if (ImGui.Begin("FreeFly")) then
			ImGui.Text(string.format("Speed: %.1f", speed))
		end
	end
	ImGui.End()
end)

registerForEvent("onUpdate", function(deltaTime)
	counter = counter + deltaTime
    if (counter > 0.05) then
    counter = counter - 0.05
	    if (active and move) then
			noClipTp(moveDirection)
		end
    end	
end)

registerHotkey("freeflyActivation", "ActivationKey", function()	
	active = not active
	moveDirection = "none"
	move = false
	if (active) then
      Game.SetTimeDilation(0.00001)
    elseif not (active) then
      Game.SetTimeDilation(0)
    end
end)

registerHotkey("freeflyMoveForward", "MoveForwardKey", function()
	move = not move
	moveDirection = "forward"
end)

registerHotkey("freeflyMoveBackwards", "MoveBackwardsKey", function()
	move = not move
	moveDirection = "backward"
end)

registerHotkey("freeflyMoveRight", "MoveRightKey", function()
	move = not move
	moveDirection = "right"
end)

registerHotkey("freeflyMoveLeft", "MoveLeftKey", function()
	move = not move
	moveDirection = "left"
end)

registerHotkey("freeflyMoveUp", "MoveUpKey", function()
	move = not move
	moveDirection = "up"
end)

registerHotkey("freeflyMoveDown", "MoveDownKey", function()
	move = not move
	moveDirection = "down"
end)

registerHotkey("freeflyMoreSpeed", "More Speed", function()
	speed = speed + 0.5
end)

registerHotkey("freeflylLessSpeed", "Less Speed", function()
	speed = speed - 0.5
end)

registerHotkey("flymodgui", "Trigger window", function()
	isVisible = not isVisible
end)
