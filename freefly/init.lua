local freefly = {
	description = "",
	isUIVisible = false,
	active = false,
	moving = false,
	moveDirection = "none",
	counter = 0,
	settings = {},
	settingsDefault = {
		loadDefault = false,
		speed = 2,
		speedIncrementStep = 0.2,
		timeStep = 0.05,
		angle = 0,
		constantTp = false
	},

	input = require("modules/ui/input"),
	ui = require("modules/ui/mainUI"),
	grav = require("modules/utils/gravityUtils"),
	flyUtils = require("modules/utils/flyUtils"),
	miscUtils = require("modules/utils/miscUtils"),
	CPS = require("CPStyling")
}

function freefly:new()

	registerForEvent('onInit', function()
		freefly.miscUtils.loadStandardFile(freefly)
		freefly.input.startInputObserver(freefly)
	end)

registerForEvent("onUpdate", function(deltaTime)
	freefly.counter = freefly.counter + deltaTime
    if (freefly.counter > freefly.settings.timeStep) then
		freefly.counter = freefly.counter - freefly.settings.timeStep

	    if (freefly.active and freefly.input.isMoving and not freefly.constantTp) then
			freefly.flyUtils.fly(freefly, freefly.input.currentDirections, freefly.settings.angle)
		elseif (freefly.active and not freefly.input.isMoving and freefly.settings.constantTp) then
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Game.GetPlayer():GetWorldPosition() , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
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
	if freefly.active and not freefly.settings.constantTp then
		freefly.grav.gravOff()
	else
		freefly.grav.gravOn()
	end
end)

registerHotkey("flymodgui", "Toggle window", function()
	freefly.isUIVisible = not freefly.isUIVisible
end)

end

return freefly:new()