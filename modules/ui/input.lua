input = {
    isMoving = false,
    currentDirections = {
        forward = false,
        backwards = false,
        right = false,
        left = false,
        up = false,
        down = false
    },
    lastReload = 0,
    lastSprint = 0,
    lastToggled = 0,
    time = 0,

    analogForward = 0,
    analogBackwards = 0,
    analogRight = 0,
    analogLeft = 0,
    analogUp = 0,
    analogDown = 0
}

function input.startInputObserver(freefly)

    Observe('PlayerPuppet', 'OnGameAttached', function(this)
        input.startListeners(this)
    end)

    Observe('PlayerPuppet', 'OnAction', function(_, action)
        local actionName = Game.NameToString(action:GetName(action))
        local actionType = action:GetType(action).value

        if actionName == "MoveX" then -- Controller movement
            local x = action:GetValue(action)
            if x < 0 then
                input.currentDirections.left = true
                input.currentDirections.right = false
                input.analogRight = 0
                input.analogLeft = -x
            else
                input.currentDirections.right = true
                input.currentDirections.left = false
                input.analogRight = x
                input.analogLeft = 0
            end
            if x == 0 then
                input.currentDirections.right = false
                input.currentDirections.left = false
                input.analogRight = 0
                input.analogLeft = 0
            end
        elseif actionName == "MoveY" then
            local x = action:GetValue(action)
            if x < 0 then
                input.currentDirections.backwards = true
                input.currentDirections.forward = false
                input.analogForward = 0
                input.analogBackwards = -x
            else
                input.currentDirections.backwards = false
                input.currentDirections.forward = true
                input.analogForward = x
                input.analogBackwards = 0
            end
            if x == 0 then
                input.currentDirections.backwards = false
                input.currentDirections.forward = false
                input.analogForward = 0
                input.analogBackwards = 0
            end
        elseif actionName == "right_trigger" and actionType == "AXIS_CHANGE" then
            local z = action:GetValue(action)
            if z == 0 then
                input.analogUp = 0
                input.currentDirections.up = false
            else
                input.currentDirections.up = true
                input.analogUp = z
            end
        elseif actionName == "left_trigger" and actionType == "AXIS_CHANGE" then
            local z = action:GetValue(action)
            if z == 0 then
                input.analogDown = 0
                input.currentDirections.down = false
            else
                input.currentDirections.down = true
                input.analogDown = z
            end
        end

        if actionName == 'Forward' then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.forward = true
                input.analogForward = 1
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.forward = false
                input.analogForward = 0
            end
        elseif actionName == 'Back' then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.backwards = true
                input.analogBackwards = 1
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.backwards = false
                input.analogBackwards = 0
            end
        elseif actionName == 'Right' then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.right = true
                input.analogRight = 1
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.right = false
                input.analogRight = 0
            end
        elseif actionName == 'Left' then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.left = true
                input.analogLeft = 1
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.left = false
                input.analogLeft = 0
            end
        elseif actionName == 'ToggleSprint' and input.time - input.lastToggled > 0.2 then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.down = true
                input.analogDown = 1
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.down = false
                input.analogDown = 0
            end
        elseif actionName == 'Jump' then
            if actionType == 'BUTTON_PRESSED' or actionType == 'BUTTON_HOLD_COMPLETE' then
                input.currentDirections.up = true
                input.analogUp = 1
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.up = false
                input.analogUp = 0
            end
        elseif actionName == 'ChoiceScrollUp' then
            if actionType == 'BUTTON_PRESSED'then
                if freefly.active then
                    freefly.settings.speed = freefly.settings.speed + freefly.settings.speedIncrementStep
                    freefly.miscUtils.saveConfig(freefly)
                end
                if freefly.settings.speed < 0 then
                    freefly.settings.speed = 0
                end
            end
        elseif actionName == 'ChoiceScrollDown' then
            if actionType == 'BUTTON_PRESSED'then
                if freefly.active then
                    freefly.settings.speed = freefly.settings.speed - freefly.settings.speedIncrementStep
                    freefly.miscUtils.saveConfig(freefly)
                end
                if freefly.settings.speed < 0 then
                    freefly.settings.speed = 0
                end
            end
        elseif actionName == 'context_help' then
            if actionType == 'BUTTON_PRESSED'then
                input.lastSprint = input.time
                if input.lastSprint - input.lastReload < 0.2 and input.time - input.lastToggled ~= 0 then
                    freefly.active = not freefly.active
                    freefly.miscUtils.tryNoWeapon(freefly, freefly.active)
                    freefly.moveDirection = "none"
                    freefly.moving = false
                    if freefly.active and not freefly.settings.constantTp then
                        freefly.grav.gravOff()
                    else
                        freefly.grav.gravOn()
                    end
                    input.lastToggled = input.time
                end
            end
        elseif actionName == 'one_click_confirm' then
            if actionType == 'BUTTON_PRESSED'then
                input.lastReload = input.time
                if input.lastReload - input.lastSprint < 0.2 and input.time - input.lastToggled ~= 0 then
                    freefly.active = not freefly.active
                    freefly.miscUtils.tryNoWeapon(freefly, freefly.active)
                    freefly.moveDirection = "none"
                    freefly.moving = false
                    if freefly.active and not freefly.settings.constantTp then
                        freefly.grav.gravOff()
                    else
                        freefly.grav.gravOn()
                    end
                    input.lastToggled = input.time
                end
            end
        end
          
        input.isMoving = false
        for _, v in pairs(input.currentDirections) do
            if v == true then
                input.isMoving = true
            end
        end

    end)
end

function input.startListeners(player)
    player:UnregisterInputListener(player, 'Forward')
    player:UnregisterInputListener(player, 'Back')
    player:UnregisterInputListener(player, 'Right')
    player:UnregisterInputListener(player, 'Left')
    player:UnregisterInputListener(player, 'ToggleSprint')
    player:UnregisterInputListener(player, 'Jump')
    player:UnregisterInputListener(player, 'ChoiceScrollUp')
    player:UnregisterInputListener(player, 'ChoiceScrollDown')
    player:UnregisterInputListener(player, 'Ping')
    player:UnregisterInputListener(player, 'context_help')

    player:RegisterInputListener(player, 'Forward')
    player:RegisterInputListener(player, 'Back')
    player:RegisterInputListener(player, 'Right')
    player:RegisterInputListener(player, 'Left')
    player:RegisterInputListener(player, 'ToggleSprint')
    player:RegisterInputListener(player, 'Jump')
    player:RegisterInputListener(player, 'ChoiceScrollUp')
    player:RegisterInputListener(player, 'ChoiceScrollDown')
    player:RegisterInputListener(player, 'Ping')
    player:RegisterInputListener(player, 'context_help')
end

return input