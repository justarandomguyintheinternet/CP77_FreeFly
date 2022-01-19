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
            freefly.CPS.CPToolTip1Begin(350, 205)
            ImGui.TextWrapped("When checked, this replaces the time stop with an alternative system (Time wont get stopped with this), which instead constantly teleports the player to the same position when not moving, to prevent falling down.")
            ImGui.Separator()
            ImGui.TextWrapped("Advantage:\n- Doesnt stop time, making it better for cinematic stuff")
            ImGui.Separator()
            ImGui.TextWrapped("Disadvantage:\n- You will still fall down veeeery slow when standing still in the air\n- Camera movement can get stuttery when standing still in the air")
            freefly.CPS.CPToolTip1End()
        elseif key == "speedStep" then
            freefly.CPS.CPToolTip1Begin(250, 60)
            ImGui.TextWrapped("This is the value by which the speed gets increased / decreased when scrolling")
            freefly.CPS.CPToolTip1End()
        elseif key == "speed" then
            freefly.CPS.CPToolTip1Begin(250, 70)
            ImGui.TextWrapped("This controls the speed you are flying at, can also be changed using mouse wheel up/down (Only while freefly mode is active)")
            freefly.CPS.CPToolTip1End()
        elseif key == "angle" then
            freefly.CPS.CPToolTip1Begin(275, 110)
            ImGui.TextWrapped("Changing this value makes you fly in curves / circles. Combine this with some multidirectional movement (Right and forward), a low TP Delay value and Constant TP on (Both can be found in the advanced tab) to get some really cinematic shots")
            freefly.CPS.CPToolTip1End()
        elseif key == "noWeapon" then
            freefly.CPS.CPToolTip1Begin(275, 60)
            ImGui.TextWrapped("Use this option to disable weapons during flight, to avoid scrolling through them when changing speed.")
            freefly.CPS.CPToolTip1End()
        end
    end
end

return tooltips