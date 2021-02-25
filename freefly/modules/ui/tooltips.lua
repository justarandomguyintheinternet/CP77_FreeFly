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
            freefly.CPS.CPToolTip1Begin(400, 145)
            ImGui.TextWrapped("This setting sets the delay between each teleport. Use this if you have low FPS and or the camera movement while flying is stuttery.")
            ImGui.Separator()
            ImGui.TextWrapped("Higher Value => More stuttery but more camera control (Good for Low FPS)")
            ImGui.Separator()
            ImGui.TextWrapped("Lower Value => Less stuttery but less camera control, perfect for fly in circles")
            ImGui.Separator()
            ImGui.TextWrapped("Default value is 0.05")
            freefly.CPS.CPToolTip1End()
        elseif key == "constantTp" then
            freefly.CPS.CPToolTip1Begin(350, 120)
            ImGui.TextWrapped("When checked, this replaces the time stop with an alternative system (Time wont get stopped with this), which instead constantly teleports the player to the same position when not moving, to prevent falling down. This works pretty good, but has its issues (You will fall down veeeery slow), changing the TP Delay will change this, just try it :D")
            freefly.CPS.CPToolTip1End()
        elseif key == "speedStep" then
            freefly.CPS.CPToolTip1Begin(250, 60)
            ImGui.TextWrapped("This is the value by which the speed gets increased / decreased when scrolling")
            freefly.CPS.CPToolTip1End()
        elseif key == "angle" then
            freefly.CPS.CPToolTip1Begin(275, 110)
            ImGui.TextWrapped("Changing this value makes you fly in curves / circles. Combine this with some multidirectional movement (Right and forward), a low TP Delay value and Constant TP on (Both can be found in the advanced tab) to get some really cinematic shots")
            freefly.CPS.CPToolTip1End()
        end
    end
end

return tooltips