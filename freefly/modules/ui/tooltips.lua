tooltips = {}

function tooltips.drawBtn(freefly, label, key)
    ImGui.SameLine()
    ImGui.Button(label)
    active = ImGui.IsItemHovered()

    if active then
        if key == "keepConfig" then
            freefly.CPS.CPToolTip1Begin(300, 55)
            ImGui.TextWrapped("Check this box if you want to keep your settings when restarting the game / reloading mods")
            freefly.CPS.CPToolTip1End()
        elseif key == "tpDelay" then
            freefly.CPS.CPToolTip1Begin(400, 120)
            ImGui.TextWrapped("This setting sets the delay between each teleport. Use this if you have low FPS and or the camera movement while flying is stuttery.\nHigher Value => More stuttery but more camera control (Good for Low FPS)\nLower Value => Less stuttery but less camera control, perfect for fly in circles\nDefault value is 0.05")
            freefly.CPS.CPToolTip1End()
        elseif key == "constantTp" then
            freefly.CPS.CPToolTip1Begin(400, 120)
            ImGui.TextWrapped("blablalbalblblb")
            freefly.CPS.CPToolTip1End()
        end
    end
end

return tooltips