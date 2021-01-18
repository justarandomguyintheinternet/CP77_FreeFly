-- -- Key Settings go here
local ActivationKey = 0x35
local SpeedPlusKey = 0x36
local SpeedMinusKey = 0x37
local StopTimeToggleKey = 0x38
local ForwardKey = 0x57
local BackwardsKey = 0x53
local LeftKey = 0x41
local RightKey = 0x44
local UpKey = 0x20
local DownKey = 0x10
-- Key Settings go here

local active = false
local speed = 2
on = false

registerForEvent("onInit", function()
	print("[FreeFly] Mod loaded")
	on = true
end)

registerForEvent("onUpdate", function()
    local keyW = GetAsyncKeyState(ForwardKey) -- Teleport forward
    if keyW ~= space_state then
        space_state = keyW
        if space_state and active then

			dir = Game.GetCameraSystem():GetActiveCameraForward()
			pos = Game.GetPlayer():GetWorldPosition()

			local xNew = pos.x + (dir.x * speed)
			local yNew = pos.y + (dir.y * speed)
			local zNew = pos.z + (dir.z * speed)
			tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
	end

	local keyS = GetAsyncKeyState(BackwardsKey) -- Teleport backwards
    if keyS ~= space_state then
        space_state = keyS
        if space_state and active then

			dir = Game.GetCameraSystem():GetActiveCameraForward()
			pos = Game.GetPlayer():GetWorldPosition()

			local xNew = pos.x - (dir.x * speed)
			local yNew = pos.y - (dir.y * speed)
			local zNew = pos.z - (dir.z * speed)
			tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
	end

	local keyD = GetAsyncKeyState(RightKey) -- Teleport right
    if keyD ~= space_state then
        space_state = keyD
        if space_state and active then

			dir = Game.GetCameraSystem():GetActiveCameraForward()
			pos = Game.GetPlayer():GetWorldPosition()
			right = Game.GetCameraSystem():GetActiveCameraRight()

			local xNew = pos.x + (right.x * speed)
			local yNew = pos.y + (right.y * speed)
			local zNew = pos.z + (right.z * speed)
			tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
	end

	local keyA = GetAsyncKeyState(LeftKey) -- Teleport left
    if keyA ~= space_state then
        space_state = keyA
        if space_state and active then

        	dir = Game.GetCameraSystem():GetActiveCameraForward()
			pos = Game.GetPlayer():GetWorldPosition()
			right = Game.GetCameraSystem():GetActiveCameraRight()

			local xNew = pos.x - (right.x * speed)
			local yNew = pos.y - (right.y * speed)
			local zNew = pos.z - (right.z * speed)
			tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
	end

	local keyUp = GetAsyncKeyState(UpKey) -- Teleport up
    if keyUp ~= space_state then
        space_state = keyUp
        if space_state and active then

			pos = Game.GetPlayer():GetWorldPosition()

			local zNew = pos.z + (0.5 * speed)
			tpTo = Vector4.new(pos.x, pos.y ,zNew, pos.w)
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer() , tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
	end

	local keyDown = GetAsyncKeyState(DownKey) -- Teleport down
    if keyDown ~= space_state then
        space_state = keyDown
        if space_state and active then

			pos = Game.GetPlayer():GetWorldPosition()

			local zNew = pos.z - (0.5 * speed)
			tpTo = Vector4.new(pos.x, pos.y ,zNew, pos.w)
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer() , tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
	end

	keyCaps = GetAsyncKeyState(ActivationKey)	-- Trigger Mode (Im stupid and lazy)
	if keyCaps ~= space_state then
		space_state = keyCaps
		if space_state then
			active = not active

			if active then
				if slowTime then
					Game.SetTimeDilation("0.0001")
				end
				print("[FreeFly] Activated")
			end
			if not active then
				if slowTime then
					Game.SetTimeDilation("0.0001")
				end
				Game.SetTimeDilation("0")    -- 0 Is an invalid input which causes the function UnsetTimeDilation() to run (https://codeberg.org/adamsmasher/cyberpunk/src/branch/master/core/systems/timeSystem.ws)
				print("[FreeFly] Deactivated")
			end

		end
	end

	local keySpeedPlus = GetAsyncKeyState(SpeedMinusKey) -- Less speed
    if keySpeedPlus ~= space_state then
        space_state = keySpeedPlus
        if space_state then
        	speed = speed - 1
        	print("[FreeFly] Decreased freefly speed to", speed)
		end
	end

	local keySpeedPlus = GetAsyncKeyState(SpeedPlusKey) -- More speed
    if keySpeedPlus ~= space_state then
        space_state = keySpeedPlus
        if space_state then
        	speed = speed + 1
        	print("[FreeFly] Increased freefly speed to", speed)
		end
	end

	local keyStopTime = GetAsyncKeyState(StopTimeToggleKey) -- Toggle stopTime
    if keyStopTime ~= space_state then
        space_state = keyStopTime
        if space_state then
			if slowTime == true
				then slowTime = false
				else
					slowTime = true
				end
			print("[FreeFly] slowTime state :", slowTime)
		end
	end

end)