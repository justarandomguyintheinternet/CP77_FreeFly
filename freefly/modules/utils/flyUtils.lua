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
        speed = freefly.settings.speed / 2
        if direction == "forward" or direction == "backwards" then
          dir = Game.GetCameraSystem():GetActiveCameraForward()
        elseif direction == "right" or direction == "left" or direction == "upleft" then
          dir = Game.GetCameraSystem():GetActiveCameraRight()
        end
        if direction == "forward" or direction == "right" then
                newPos.x = newPos.x + (dir.x * speed)
                newPos.y = newPos.y + (dir.y * speed)
                newPos.z = newPos.z + (dir.z * speed)
        elseif direction == "backwards" or direction == "left" then
                newPos.x = newPos.x - (dir.x * speed)
                newPos.y = newPos.y - (dir.y * speed)
                newPos.z = newPos.z - (dir.z * speed)
        elseif direction == "up" then
                newPos.z = newPos.z + (0.7 * speed)
        elseif direction == "down" then
                newPos.z = newPos.z - (0.7 * speed)
        end
end

return flyUtils