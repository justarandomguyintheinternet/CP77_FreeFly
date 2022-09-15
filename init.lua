-------------------------------------------------------------------------------------------------------------------------------
-- This mod was created by keanuWheeze from CP2077 Modding Tools Discord.
--
-- You are free to use this mod as long as you follow the following license guidelines:
--    * It may not be uploaded to any other site without my express permission.
--    * Using any code contained herein in another mod requires credits / asking me.
--    * You may not fork this code and make your own competing version of this mod available for download without my permission.
-------------------------------------------------------------------------------------------------------------------------------

local GameUI = require("modules/utils/GameUI")

freefly = {
    runtimeData = {
        inMenu = false,
        inGame = false,
        cetOpen = false,
        active = false
    },
    settings = {},
    defaultSettings = {
		speed = 2,
		speedIncrementStep = 0.2,
		angle = 0,
		noWeapon = true,
        timeStop = false
    },
    config = require("modules/utils/config"),
    ui = require("modules/ui/generalSettingsUI"),
    logic = require("modules/utils/logic"),
    nUI = require("modules/ui/settingsUI")
}

function freefly:new()
    registerForEvent("onInit", function()
        self.config.tryCreateConfig("config/config.json", self.defaultSettings)
        self.config.backwardComp("config/config.json", self.defaultSettings)
        self.settings = self.config.loadFile("config/config.json")

        Observe('RadialWheelController', 'OnIsInMenuChanged', function(_, isInMenu) -- Setup observer and GameUI to detect inGame / inMenu
            self.runtimeData.inMenu = isInMenu
        end)

        GameUI.OnSessionStart(function()
            self.runtimeData.inGame = true
            self.logic.registerInput(GetPlayer())
        end)

        GameUI.OnSessionEnd(function()
            self.runtimeData.inGame = false
        end)

        self.runtimeData.inGame = not GameUI.IsDetached() -- Required to check if ingame after reloading all mods
        self.logic.registerObservers(self)

        Override("ZoomEventsTransition", "OnEnter", function (_, context, interface, wrapped)
            if self.runtimeData.active then return end
            wrapped(context, interface)
        end)

        self.nUI.setupNative(self)
    end)

    registerForEvent("onUpdate", function(deltaTime)
        if not self.runtimeData.inMenu and self.runtimeData.inGame and self.runtimeData.active then
            self.logic.fly(self, deltaTime)
        end
        self.logic.time = self.logic.time + deltaTime
    end)

    registerForEvent("onDraw", function()
        if not self.runtimeData.cetOpen then return end
        self.ui.draw(self)
    end)

    registerForEvent("onOverlayOpen", function()
        self.runtimeData.cetOpen = true
    end)

    registerForEvent("onOverlayClose", function()
        self.runtimeData.cetOpen = false
    end)

    registerForEvent("onShutdown", function()
        if self.runtimeData.active then
            Game.RemoveEffectPlayer("GameplayRestriction.NoMovement")
            Game.RemoveEffectPlayer("GameplayRestriction.NoZooming")
            Game.RemoveEffectPlayer("GameplayRestriction.NoCombat")
        end
    end)

    registerHotkey("flymodsweitchangle", "Invert turning angle", function()
        self.settings.angle = -self.settings.angle
        self.config.saveFile("config/config.json", self.settings)
    end)

    registerHotkey("freeflyActivation", "ActivationKey", function()
        self.runtimeData.active = not self.runtimeData.active
        self.logic.toggleFlight(self, self.runtimeData.active)
    end)

    return self
end

return freefly:new()