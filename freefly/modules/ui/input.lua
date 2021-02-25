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
}

function input.startInputObserver(freefly)
    Observe('PlayerPuppet', 'OnAction', function(action)
        local actionName = Game.NameToString(action:GetName(action))
        local actionType = action:GetType(action).value
        if actionName == 'Forward'then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.forward = true
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.forward = false
            end
        elseif actionName == 'Back'then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.backwards = true
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.backwards = false
            end
        elseif actionName == 'Right'then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.right = true
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.right = false
            end
        elseif actionName == 'Left'then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.left = true
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.left = false
            end
        elseif actionName == 'ToggleSprint'then
            if actionType == 'BUTTON_PRESSED' then
                input.currentDirections.down = true
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.down = false
            end
        elseif actionName == 'Jump'then
            if actionType == 'BUTTON_PRESSED' or actionType == 'BUTTON_HOLD_COMPLETE' then
                input.currentDirections.up = true
            elseif actionType == 'BUTTON_RELEASED' then
                input.currentDirections.up = false
            end
        elseif actionName == 'ChoiceScrollUp'then
            if actionType == 'BUTTON_PRESSED'then
                if freefly.active then
                    freefly.settings.speed = freefly.settings.speed + freefly.settings.speedIncrementStep
                    freefly.miscUtils.saveConfig(freefly)
                end
                if freefly.settings.speed < 0 then
                    freefly.settings.speed = 0
                end
            end
        elseif actionName == 'ChoiceScrollDown'then
            if actionType == 'BUTTON_PRESSED'then
                if freefly.active then
                    freefly.settings.speed = freefly.settings.speed - freefly.settings.speedIncrementStep
                    freefly.miscUtils.saveConfig(freefly)
                end
                if freefly.settings.speed < 0 then
                    freefly.settings.speed = 0
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

return input