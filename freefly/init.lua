local freefly = {
	description = "",
	isUIVisible = false,
	active = false,
	moving = false,
	moveDirection = "none",
	speed = 1,
	speedIncrementStep = 0.25,
	counter = 0,
	timeStep = 0.05,

	input = require("modules/ui/input"),
	ui = require("modules/ui/mainUI"),
	flyUtils = require("modules/utils/flyUtils")
}

function freefly:new()

registerForEvent("onUpdate", function(deltaTime)
	freefly.counter = freefly.counter + deltaTime
    if (freefly.counter > freefly.timeStep) then
		freefly.counter = freefly.counter - freefly.timeStep
	    if (freefly.active and freefly.moving) then
			freefly.flyUtils.tpStraightDirection(freefly, freefly.moveDirection)
		end
    end	
end)

registerForEvent("onDraw", function()
	if freefly.isUIVisible then		
		freefly.ui.draw(freefly)
	end
end)   

registerHotkey("freeflyActivation", "ActivationKey", function()	
	freefly.active = not freefly.active
	freefly.moveDirection = "none"
	freefly.moving = false
end)

registerHotkey("freeflyMoveForward", "MoveForwardKey", function()
	freefly.input.movementKey(freefly, "forward")
end)

registerHotkey("freeflyMoveBackwards", "MoveBackwardsKey", function()
	freefly.input.movementKey(freefly, "backward")
end)

registerHotkey("freeflyMoveRight", "MoveRightKey", function()
	freefly.input.movementKey(freefly, "right")
end)

registerHotkey("freeflyMoveLeft", "MoveLeftKey", function()
	freefly.input.movementKey(freefly, "left")
end)

registerHotkey("freeflyMoveUp", "MoveUpKey", function()
	freefly.input.movementKey(freefly, "up")
end)

registerHotkey("freeflyMoveDown", "MoveDownKey", function()
	freefly.input.movementKey(freefly, "down")
end)

registerHotkey("freeflyMoreSpeed", "More Speed", function()
	freefly.speed = freefly.speed + freefly.speedIncrementStep
end)

registerHotkey("freeflylLessSpeed", "Less Speed", function()
	freefly.speed = freefly.speed - freefly.speedIncrementStep
end)

registerHotkey("flymodgui", "Toggle window", function()
	freefly.isUIVisible = not freefly.isUIVisible
end)

end

return freefly:new()