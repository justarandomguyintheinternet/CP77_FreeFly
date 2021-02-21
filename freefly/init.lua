local freefly = {
	description = "",
	isUIVisible = false,
	active = false,
	moving = false,
	moveDirection = "none"
}

function freefly:new()

registerForEvent("onInit", function()

end)

registerForEvent("onDraw", function()
	if freefly.isUIVisible then
		
	end
end)   

registerHotkey("freeflyActivation", "ActivationKey", function()	

end)

registerHotkey("freeflyMoveForward", "MoveForwardKey", function()

end)

registerHotkey("freeflyMoveBackwards", "MoveBackwardsKey", function()

end)

registerHotkey("freeflyMoveRight", "MoveRightKey", function()

end)

registerHotkey("freeflyMoveLeft", "MoveLeftKey", function()

end)

registerHotkey("freeflyMoveUp", "MoveUpKey", function()

end)

registerHotkey("freeflyMoveDown", "MoveDownKey", function()

end)

registerHotkey("freeflyMoreSpeed", "More Speed", function()

end)

registerHotkey("freeflylLessSpeed", "Less Speed", function()

end)

registerHotkey("flymodgui", "Toggle window", function()
	freefly.isUIVisible = not freefly.isUIVisible
end)

end

return freefly