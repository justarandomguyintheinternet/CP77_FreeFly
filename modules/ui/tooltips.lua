local CPS = require("CPStyling")

tooltips = {}

function tooltips.drawBtn(label, key)
    ImGui.SameLine()
    ImGui.Button(label)
    local active = ImGui.IsItemHovered()

    if active then
        if key == "speedStep" then
            CPS.CPToolTip1Begin(250, 60)
            ImGui.TextWrapped("This is the value by which the speed gets increased / decreased when scrolling")
            CPS.CPToolTip1End()
        elseif key == "speed" then
            CPS.CPToolTip1Begin(250, 70)
            ImGui.TextWrapped("This controls the speed you are flying at, can also be changed using mouse wheel up/down (Only while freefly mode is active)")
            CPS.CPToolTip1End()
        elseif key == "angle" then
            CPS.CPToolTip1Begin(275, 110)
            ImGui.TextWrapped("Changing this value makes you fly in curves / circles. Combine this with some multidirectional movement (Right and forward), a low TP Delay value and Constant TP on (Both can be found in the advanced tab) to get some really cinematic shots")
            CPS.CPToolTip1End()
        elseif key == "noWeapon" then
            CPS.CPToolTip1Begin(275, 60)
            ImGui.TextWrapped("Use this option to disable weapons during flight, to avoid scrolling through them when changing speed.")
            CPS.CPToolTip1End()
        end
    end
end

return tooltips