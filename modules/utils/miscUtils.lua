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

function miscUtil.fileExists(filename)
    local f=io.open(filename,"r")
    if (f~=nil) then io.close(f) return true else return false end
end

function miscUtil.loadStandardFile(freefly)
    if not miscUtil.fileExists("config/config.json") then
        local file = io.open("config/config.json", "w")
        local jconfig = json.encode(freefly.settingsDefault)
        file:write(jconfig)
        file:close()
    end

    local file = io.open("config/config.json", "r")
    local config = json.decode(file:read("*a"))
    file:close()
    if config.loadDefault then
        freefly.settings = config
    else
        freefly.settings = freefly.miscUtils.deepcopy(freefly.settingsDefault)
    end

    if freefly.settings.noWeapon == nil then --Ugly backwards compatibility
        freefly.settings.noWeapon = true
    end

end

function miscUtil.saveConfig(freefly)
    local file = io.open("config/config.json", "w")
    local jconfig = json.encode(freefly.settings)
    file:write(jconfig)
    file:close()
end

function miscUtil.tryNoWeapon(freefly, state)
    if freefly.settings.noWeapon and state then
        Game.ApplyEffectOnPlayer("GameplayRestriction.NoCombat")
    else
        local rmStatus = Game['StatusEffectHelper::RemoveStatusEffect;GameObjectTweakDBID']
        rmStatus(Game.GetPlayer(), "GameplayRestriction.NoCombat")
    end
end

return miscUtil