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
	angle = 0,

	input = require("modules/ui/input"),
	ui = require("modules/ui/mainUI"),
	grav = require("modules/utils/gravityUtils"),
	flyUtils = require("modules/utils/flyUtils")
}

function freefly:new()

	registerForEvent('onInit', function()
		freefly.input.startInputObserver()
	end)

registerForEvent("onUpdate", function(deltaTime)
	freefly.counter = freefly.counter + deltaTime
    if (freefly.counter > freefly.timeStep) then
		freefly.counter = freefly.counter - freefly.timeStep
	    if (freefly.active and freefly.input.isMoving) then
			freefly.flyUtils.fly(freefly, freefly.input.currentDirections, 0)
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
	if freefly.active then
		freefly.grav.gravOff()
	else
		freefly.grav.gravOn()
	end
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