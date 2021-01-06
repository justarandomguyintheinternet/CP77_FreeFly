active = false
speed = 2

registerForEvent("onUpdate", function()

player = Game.GetPlayer()
tp = Game.GetTeleportationFacility()
cams = Game.GetCameraSystem()

local dir = cams:GetActiveCameraForward()
local pos = player:GetWorldPosition()


    local keyW = GetAsyncKeyState(0x57) -- W for teleport forward
    if keyW ~= space_state then
        space_state = keyW
        if space_state and active then
			local xNew = pos.x + (dir.x * speed)
			local yNew = pos.y + (dir.y * speed)
			local zNew = pos.z + (dir.z * speed)
			tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
			tp:Teleport(player, tpTo , EulerAngles.new(0,0,player:GetWorldYaw()))
		end
	end

	keyCaps = GetAsyncKeyState(0x35)	-- Trigger Mode (Im stupid and lazy)
	if keyCaps ~= space_state then
		space_state = keyCaps
		if space_state then
			active = not active

			if active then
				Game.SetTimeDilation("0.001")
				print("[FreeFly] Activated")
			end
			if not active then
				Game.SetTimeDilation("1")
				print("[FreeFly] Deactivated")
			end

		end
	end

	local keySpeedPlus = GetAsyncKeyState(0x36) -- 6 for moar speed
    if keySpeedPlus ~= space_state then
        space_state = keySpeedPlus
        if space_state then
        	speed = speed + 1
        	print("[FreeFly] Increased freefly speed to", speed)
		end
	end

	local keySpeedPlus = GetAsyncKeyState(0x37) -- 7 for less speed
    if keySpeedPlus ~= space_state then
        space_state = keySpeedPlus
        if space_state then
        	speed = speed - 1
        	print("[FreeFly] Decreased freefly speed to", speed)
		end
	end

end)