miscUtil = {}

function miscUtil.deepcopy(origin)
	local orig_type = type(origin)
    local copy
    if orig_type == 'table' then
        copy = {}
        for origin_key, origin_value in next, origin, nil do
            copy[miscUtil.deepcopy(origin_key)] = miscUtil.deepcopy(origin_value)
        end
        setmetatable(copy, miscUtil.deepcopy(getmetatable(origin)))
    else
        copy = origin
    end
    return copy
end

function miscUtil.tryNoWeapon(freefly, state)
    if freefly.settings.noWeapon and state then
        Game.ApplyEffectOnPlayer("GameplayRestriction.NoCombat")
    else
        local rmStatus = Game['StatusEffectHelper::RemoveStatusEffect;GameObjectTweakDBID']
        rmStatus(GetPlayer(), "GameplayRestriction.NoCombat")
    end
end

return miscUtil