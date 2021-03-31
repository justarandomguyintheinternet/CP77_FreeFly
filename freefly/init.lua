-- This mod was created by keanuWheeze from CP2077 Modding Tools Discord.
-- Thanks to NonameNonumber and perfnormbeast for the new input method

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
	CPS = nil
}

function freefly:new()

	registerForEvent('onInit', function()
		freefly.CPS = GetMod("CPStyling"):New()
		freefly.miscUtils.loadStandardFile(freefly)
		freefly.input.startInputObserver(freefly)
	end)

registerForEvent("onUpdate", function(deltaTime)
	freefly.counter = freefly.counter + deltaTime
    if (freefly.counter > freefly.settings.timeStep) then
		freefly.counter = freefly.counter - freefly.settings.timeStep
	    if (freefly.active and freefly.input.isMoving and not freefly.constantTp) then
			freefly.flyUtils.fly(freefly, freefly.input.currentDirections, freefly.settings.angle)
			Game.Heal("100000", "0")
		elseif (freefly.active and not freefly.input.isMoving and freefly.settings.constantTp) then
			Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Game.GetPlayer():GetWorldPosition() , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
			Game.Heal("100000", "0")
		end
    end
	if freefly.active and not freefly.settings.constantTp then
		freefly.grav.gravOff()
	end
end)

registerForEvent("onDraw", function()
	if freefly.isUIVisible then	
		freefly.ui.draw(freefly)
	end
end)   

registerForEvent("onOverlayOpen", function()
    freefly.isUIVisible = true
end)

registerForEvent("onOverlayClose", function()
    freefly.isUIVisible = false
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

registerHotkey("flymodsweitchangle", "Invert turning angle", function()
	freefly.settings.angle = -freefly.settings.angle
	freefly.miscUtils.saveConfig(freefly)
end)

end

return freefly:new()