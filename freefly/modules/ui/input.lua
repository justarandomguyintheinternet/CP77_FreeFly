input = {}

function input.movementKey(freefly, key)
    freefly.moving = not freefly.moving
    freefly.moveDirection = key
end

return input