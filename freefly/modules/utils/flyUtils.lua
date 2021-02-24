flyUtils = {}

function flyUtils.tpStraightDirection(freefly, direction)
    if (direction ~= "none") then
        if direction == "forward" or direction == "backward" then
          dir = Game.GetCameraSystem():GetActiveCameraForward()
        elseif direction == "right" or direction == "left" then
          dir = Game.GetCameraSystem():GetActiveCameraRight()
        end
        pos = Game.GetPlayer():GetWorldPosition()
        if direction == "forward" or direction == "right" then
                xNew = pos.x + (dir.x * freefly.speed)
                yNew = pos.y + (dir.y * freefly.speed)
                zNew = pos.z + (dir.z * freefly.speed)
        elseif direction == "backward" or direction == "left" then
                xNew = pos.x - (dir.x * freefly.speed)
                yNew = pos.y - (dir.y * freefly.speed)
                zNew = pos.z - (dir.z * freefly.speed)
        elseif direction == "up" then
                xNew = pos.x
                yNew = pos.y
                zNew = pos.z + (0.5 * freefly.speed)
        elseif direction == "down" then
                xNew = pos.x
                yNew = pos.y
                zNew = pos.z - (0.5 * freefly.speed)
        end
        tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
        Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
        Game.Heal("100000", "0")
    end
end

return flyUtils