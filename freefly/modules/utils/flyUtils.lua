flyUtils = {}

function flyUtils.fly(freefly, directions, angle)
        newPos = Game.GetPlayer():GetWorldPosition()
        for directionKey, state in pairs(directions) do
                if state == true then
                        flyUtils.calculateNewPos(freefly, directionKey, newPos)
                end
        end
        Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), newPos , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw() + angle))
end

function flyUtils.calculateNewPos(freefly, direction, newPos)
        if direction == "forward" or direction == "backwards" then
          dir = Game.GetCameraSystem():GetActiveCameraForward()
        elseif direction == "right" or direction == "left" or direction == "upleft" then
          dir = Game.GetCameraSystem():GetActiveCameraRight()
        end
        if direction == "forward" or direction == "right" then
                newPos.x = newPos.x + (dir.x * freefly.speed)
                newPos.y = newPos.y + (dir.y * freefly.speed)
                newPos.z = newPos.z + (dir.z * freefly.speed)
        elseif direction == "backwards" or direction == "left" then
                newPos.x = newPos.x - (dir.x * freefly.speed)
                newPos.y = newPos.y - (dir.y * freefly.speed)
                newPos.z = newPos.z - (dir.z * freefly.speed)
        elseif direction == "up" then
                newPos.z = newPos.z + (0.7 * freefly.speed)
        elseif direction == "down" then
                newPos.z = newPos.z - (0.7 * freefly.speed)
        end
end

return flyUtils