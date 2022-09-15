local config = require("modules/utils/config")
local utils = require("modules/utils/miscUtils")

logic = {
        lastReload = 0,
        lastSprint = 0,
        lastToggled = 0,
        time = 0,

        analogForward = 0,
        analogBackwards = 0,
        analogRight = 0,
        analogLeft = 0,
        analogUp = 0,
        analogDown = 0,

        yaw = 0
}

function logic.registerInput(this)
        this:UnregisterInputListener(this, 'Forward')
        this:UnregisterInputListener(this, 'Back')
        this:UnregisterInputListener(this, 'Right')
        this:UnregisterInputListener(this, 'Left')
        this:UnregisterInputListener(this, 'ToggleSprint')
        this:UnregisterInputListener(this, 'Jump')
        this:UnregisterInputListener(this, 'ChoiceScrollUp')
        this:UnregisterInputListener(this, 'ChoiceScrollDown')
        this:UnregisterInputListener(this, 'Ping')
        this:UnregisterInputListener(this, 'context_help')

        this:RegisterInputListener(this, 'Forward')
        this:RegisterInputListener(this, 'Back')
        this:RegisterInputListener(this, 'Right')
        this:RegisterInputListener(this, 'Left')
        this:RegisterInputListener(this, 'ToggleSprint')
        this:RegisterInputListener(this, 'Jump')
        this:RegisterInputListener(this, 'ChoiceScrollUp')
        this:RegisterInputListener(this, 'ChoiceScrollDown')
        this:RegisterInputListener(this, 'Ping')
        this:RegisterInputListener(this, 'context_help')
end

function logic.registerObservers(mod)
        Observe('PlayerPuppet', 'OnGameAttached', function(this)
              logic.registerInput(this)
        end)

        Observe('PlayerPuppet', 'OnAction', function(_, action)
                local actionName = Game.NameToString(action:GetName(action))
                local actionType = action:GetType(action).value

                if actionName == "MoveX" then -- Controller movement
                    local x = action:GetValue(action)
                    if x < 0 then
                        logic.analogRight = 0
                        logic.analogLeft = -x
                    else
                        logic.analogRight = x
                        logic.analogLeft = 0
                    end
                    if x == 0 then
                        logic.analogRight = 0
                        logic.analogLeft = 0
                    end
                elseif actionName == "MoveY" then
                    local x = action:GetValue(action)
                    if x < 0 then
                        logic.analogForward = 0
                        logic.analogBackwards = -x
                    else
                        logic.analogForward = x
                        logic.analogBackwards = 0
                    end
                    if x == 0 then
                        logic.analogForward = 0
                        logic.analogBackwards = 0
                    end
                elseif actionName == "right_trigger" and actionType == "AXIS_CHANGE" then
                    local z = action:GetValue(action)
                    if z == 0 then
                        logic.analogUp = 0
                    else
                        logic.analogUp = z
                    end
                elseif actionName == "left_trigger" and actionType == "AXIS_CHANGE" then
                    local z = action:GetValue(action)
                    if z == 0 then
                        logic.analogDown = 0
                    else
                        logic.analogDown = z
                    end
                end

                if actionName == 'Forward' then
                    if actionType == 'BUTTON_PRESSED' then
                        logic.analogForward = 1
                    elseif actionType == 'BUTTON_RELEASED' then
                        logic.analogForward = 0
                    end
                elseif actionName == 'Back' then
                    if actionType == 'BUTTON_PRESSED' then
                        logic.analogBackwards = 1
                    elseif actionType == 'BUTTON_RELEASED' then
                        logic.analogBackwards = 0
                    end
                elseif actionName == 'Right' then
                    if actionType == 'BUTTON_PRESSED' then
                        logic.analogRight = 1
                    elseif actionType == 'BUTTON_RELEASED' then
                        logic.analogRight = 0
                    end
                elseif actionName == 'Left' then
                    if actionType == 'BUTTON_PRESSED' then
                        logic.analogLeft = 1
                    elseif actionType == 'BUTTON_RELEASED' then
                        logic.analogLeft = 0
                    end
                elseif actionName == 'ToggleSprint' and logic.time - logic.lastToggled > 0.2 then
                    if actionType == 'BUTTON_PRESSED' then
                        logic.analogDown = 1
                    elseif actionType == 'BUTTON_RELEASED' then
                        logic.analogDown = 0
                    end
                elseif actionName == 'Jump' then
                    if actionType == 'BUTTON_PRESSED' or actionType == 'BUTTON_HOLD_COMPLETE' then
                        logic.analogUp = 1
                    elseif actionType == 'BUTTON_RELEASED' then
                        logic.analogUp = 0
                    end
                elseif actionName == 'ChoiceScrollUp' then
                    if actionType == 'BUTTON_PRESSED'then
                        if mod.runtimeData.active then
                                mod.settings.speed = mod.settings.speed + mod.settings.speedIncrementStep
                                config.saveFile("config/config.json", mod.settings)
                        end
                        if mod.settings.speed < 0 then
                                mod.settings.speed = 0
                        end
                    end
                elseif actionName == 'ChoiceScrollDown' then
                    if actionType == 'BUTTON_PRESSED'then
                        if mod.runtimeData.active then
                                mod.settings.speed = mod.settings.speed - mod.settings.speedIncrementStep
                                config.saveFile("config/config.json", mod.settings)
                        end
                        if mod.settings.speed < 0 then
                                mod.settings.speed = 0
                        end
                    end
                elseif actionName == 'context_help' then
                    if actionType == 'BUTTON_PRESSED'then
                        logic.lastSprint = logic.time
                        if logic.lastSprint - logic.lastReload < 0.2 and logic.time - logic.lastToggled ~= 0 then
                                mod.runtimeData.active = not mod.runtimeData.active
                                logic.toggleFlight(mod, mod.runtimeData.active)
                                logic.lastToggled = logic.time
                        end
                    end
                elseif actionName == 'one_click_confirm' then
                    if actionType == 'BUTTON_PRESSED'then
                        logic.lastReload = logic.time
                        if logic.lastReload - logic.lastSprint < 0.2 and logic.time - logic.lastToggled ~= 0 then
                                mod.runtimeData.active = not mod.runtimeData.active
                                logic.toggleFlight(mod, mod.runtimeData.active)
                            logic.lastToggled = logic.time
                        end
                    end
                end

                if actionName == "CameraMouseX" then
                local x = action:GetValue(action)
                        local sens = Game.GetSettingsSystem():GetVar("/controls/fppcameramouse", "FPP_MouseX"):GetValue() / 2.9
                        logic.yaw = - (x / 35) * sens
                end
                if actionName == "right_stick_x" then
                local x = action:GetValue(action)
                        local sens = Game.GetSettingsSystem():GetVar("/controls/fppcamerapad", "FPP_PadX"):GetValue() / 10
                        logic.yaw = - x * 1.7 * sens
                end
        end)
end

function logic.toggleFlight(mod, state)
        utils.tryNoWeapon(mod, state)

        if state then
                Game.ApplyEffectOnPlayer("GameplayRestriction.NoMovement")
                Game.ApplyEffectOnPlayer("GameplayRestriction.NoZooming")
                if mod.settings.timeStop then
                        Game.SetTimeDilation(0.000000001)
                end
        elseif not state then
                Game.RemoveEffectPlayer("GameplayRestriction.NoMovement")
                Game.RemoveEffectPlayer("GameplayRestriction.NoZooming")
                Game.SetTimeDilation(0)
        end
end

function logic.fly(mod, dt)
        local newPos = GetPlayer():GetWorldPosition()

        newPos = logic.calculateNewPos("forward", newPos, mod.settings.speed * dt * 15)
        newPos = logic.calculateNewPos("backwards", newPos, mod.settings.speed * dt * 15)
        newPos = logic.calculateNewPos("right", newPos, mod.settings.speed * dt * 15)
        newPos = logic.calculateNewPos("left", newPos, mod.settings.speed * dt * 15)
        newPos = logic.calculateNewPos("up", newPos, mod.settings.speed * dt * 15)
        newPos = logic.calculateNewPos("down", newPos, mod.settings.speed * dt * 15)

        local angle = mod.settings.angle
        Game.GetTeleportationFacility():Teleport(GetPlayer(), newPos , EulerAngles.new(0, 0, Game.GetPlayer():GetWorldYaw() + angle + logic.yaw))

        Game.Heal()
end

function logic.calculateNewPos(direction, newPos, speed)
        if direction == "forward" then
                speed = speed * logic.analogForward
        elseif direction == "backwards" then
                speed = speed * logic.analogBackwards
        elseif direction == "right" then
                speed = speed * logic.analogRight
        elseif direction == "left" then
                speed = speed * logic.analogLeft
        elseif direction == "up" then
                speed = speed * logic.analogUp
        elseif direction == "down" then
                speed = speed * logic.analogDown
        end

        local vec
        if direction == "forward" or direction == "backwards" then
                vec = Game.GetCameraSystem():GetActiveCameraForward()
        elseif direction == "right" or direction == "left" then
                vec = Game.GetCameraSystem():GetActiveCameraRight()
        end
        if direction == "forward" or direction == "right" then
                newPos.x = newPos.x + (vec.x * speed)
                newPos.y = newPos.y + (vec.y * speed)
                newPos.z = newPos.z + (vec.z * speed)
        elseif direction == "backwards" or direction == "left" then
                newPos.x = newPos.x - (vec.x * speed)
                newPos.y = newPos.y - (vec.y * speed)
                newPos.z = newPos.z - (vec.z * speed)
        elseif direction == "up" then
                newPos.z = newPos.z + (0.7 * speed)
        elseif direction == "down" then
                newPos.z = newPos.z - (0.7 * speed)
        end

        return newPos
end

return logic