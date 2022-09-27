require "util"


LabRadius = 8--in chunks
LabNameStub = "BPL_TheLab"

function LabName(force)
    return LabNameStub .. force.name
end

function IsLab(surface)
    return string.starts(surface.name, LabNameStub)
end

function DestroyEntity(entity, player_index)
	if (not entity.valid) then
		return
	end
    if (entity.type == "deconstructible-tile-proxy") then
        DestroyDeconstructibleTileProxy(entity)
        return
    end
    if (entity.type == "transport-belt") then
        ClearTransportLines(entity, 2)
    end
    if (entity.type == "underground-belt") then
        ClearTransportLines(entity, 4)
    end
    if (entity.type == "splitter") then
        ClearTransportLines(entity, 8)
    end
    if (entity.type == "loader") then
        ClearTransportLines(entity, 2)
    end
	
    script.raise_event(defines.events.script_raised_destroy,
        {player_index = player_index, entity = entity}) 

    entity.destroy()
end

function ClearTransportLines(entity, count)
    for i = 1, count do
        entity.get_transport_line(i).clear()
    end
end

function DestroyDeconstructibleTileProxy(entity)
    local hiddenTile = entity.surface.get_hidden_tile(entity.position)

    entity.surface.set_tiles {{name = hiddenTile, position = entity.position}}
    entity.destroy()
end

function DestroyTile(tile, surface)
    surface.set_tiles {{name = tile.hidden_tile, position = tile.position}}
end

function IsBlueprintOrBook(itemStack)
    return itemStack.is_blueprint or itemStack.is_blueprint_book
end

EmptyBlueprintString = "0eNqrrgUAAXUA+Q=="

function ReviveEntity(entity, player_index)
    if entity.type == "entity-ghost" then
        _, revived, request = entity.revive({true})
        if not revived then return end

        if request then
            for requestName, requestCount in pairs(request.item_requests) do
                request.proxy_target.insert {name = requestName, count = requestCount}
            end
            request.destroy()
        end
		
        script.raise_event(defines.events.script_raised_built, 
			{player_index = player_index, entity = revived})
    elseif entity.type == "tile-ghost" then
        entity.revive()
    end
end

function getActiveTableSize()
    local t = getActiveTable()
    if (t == nil) then return 0 end
    return #t
end

function getActiveTable()
    if (global["_blueprint_mod_active_status"] == nil) then
        global["_blueprint_mod_active_status"] = {}
    end
    return global["_blueprint_mod_active_status"]
end

function getActiveTableIndex()
    if (global["_blueprint_mod_active_status_index"] == nil) then
        global["_blueprint_mod_active_status_index"] = {}
    end
    return global["_blueprint_mod_active_status_index"]
end

function getActiveTableIndexSize()
    return #getActiveTableIndex()
end

function saveEntityStatus(entity)
    if (not entity.valid) then
        return false end
    if (not entity.unit_number) then 
        return false end
    
    local as = getActiveTableSize()

    getActiveTableIndex()[entity.unit_number] = as + 1
    table.insert(getActiveTable(), {
        entity=entity,
        active=entity.active
    })
    
    return true
end


if not global["_blueprint_mod_map_settings"] then
    global["_blueprint_mod_map_settings"] = {}
end

function pauseMapEvolution()
    if (global["_blueprint_mod_map_settings"] == nil) then
        return nil
    end

    local MAX_INT = 2147483647
    
    local p = game.map_settings.pollution
    p.enabled = false
    p.diffusion_ratio = 0
    p.min_to_diffuse = MAX_INT
    p.ageing = 0
    p.expected_max_per_chunk = 0
    p.enemy_attack_pollution_consumption_modifier = 0
    
    local evo = game.map_settings.enemy_evolution
    evo.enabled = false
    evo.time_factor = 0
    evo.destroy_factor = 0
    evo.pollution_factor = 0
    
    local exp = game.map_settings.enemy_expansion
    exp.enabled = false
    exp.min_expansion_cooldown = MAX_INT
    exp.max_expansion_cooldown = MAX_INT

    


end

function saveMapSettings()
    if (global["_blueprint_mod_map_settings"] == nil) then
        global["_blueprint_mod_map_settings"] = {}
    end

    global["_blueprint_mod_map_settings"] = getMapSettings()    
end

function restoreMapSettings()
    if (global["_blueprint_mod_map_settings"] == nil) then
        return nil
    end
    
    local s = global["_blueprint_mod_map_settings"]
    local p = game.map_settings.pollution
    local evo = game.map_settings.enemy_evolution
    local exp = game.map_settings.enemy_expansion

    p.enabled = s.p.enabled
    p.diffusion_ratio = s.p.diffusion_ratio
    p.min_to_diffuse = s.p.min_to_diffuse
    p.ageing = s.p.ageing
    p.expected_max_per_chunk = s.p.expected_max_per_chunk
    p.enemy_attack_pollution_consumption_modifier = s.p.enemy_attack_pollution_consumption_modifier
    
    evo.enabled = s.evo.enabled
    evo.time_factor = s.evo.time_factor
    evo.destroy_factor = s.evo.destroy_factor
    evo.pollution_factor = s.evo.pollution_factor
    
    exp.enabled = s.exp.enabled
    exp.min_expansion_cooldown = s.exp.min_expansion_cooldown
    exp.max_expansion_cooldown = s.exp.max_expansion_cooldown


end


function getMapSettings()
    local p = game.map_settings.pollution
    local evo = game.map_settings.enemy_evolution
    local exp = game.map_settings.enemy_expansion
    return {p={
        enabled = p.enabled,
        diffusion_ratio = p.diffusion_ratio,
        min_to_diffuse = p.min_to_diffuse,
        ageing = p.ageing,
        expected_max_per_chunk = p.expected_max_per_chunk,
        enemy_attack_pollution_consumption_modifier = p.enemy_attack_pollution_consumption_modifier
    }, evo={
        enabled = evo.enabled,
        time_factor = evo.time_factor,
        destroy_factor = evo.destroy_factor,
        pollution_factor = evo.pollution_factor
    }, exp={
        enabled = exp.enabled,
        min_expansion_cooldown = exp.min_expansion_cooldown,
        max_expansion_cooldown = exp.max_expansion_cooldown
    }}
end

function restoreEntityStatuses()
    local t = getActiveTableIndex()
    if (t == nil or #t == 0) then return end
    -- game.print("========================")
    -- print(getActiveTableIndexSize())

    for k,v in pairs(getActiveTableIndex()) do
        local data = getActiveTable()[v]
        local str0 = "unit number: " ..k
        local str1 = " name: " .. tostring(data.entity.name) 
        local str2 = " state: " .. tostring(data.entity.active)
        local str3 = " saved state: " .. tostring(data.active)
        local str4
        if data.entity.valid ~= nil then
            str4 = " valid: " .. tostring(data.entity.valid)
        else
            str4 = " valid: HAS NO VALID"
        end

            
        -- print("Restore entity data for " .. data.entity.name .. " - " .. data.entity.unit_number)
        data.entity.active = data.active
        -- game.print(str0 .. str1 .. str2 .. str3 .. str4)
        
    end
end


function freezeAllSurfaces()
    for _, surface in pairs(game.surfaces) do
        if (not IsLab(surface)) then 
            for _, entity in pairs(surface.find_entities()) do
                local ply = game.get_player(1)
                if entity == ply or entity == ply.character then
                    goto continue
                elseif entity.unit_number then
                    saveEntityStatus(entity)
                    
                    -- print("Saved entity data for " .. entity.name .. " - " .. entity.unit_number)
                    entity.active = false
                end
                ::continue::
            end
        end

    end
end

function clearActiveStatusTables()
    count = #getActiveTable()
    for i = 1, count do
        getActiveTable()[i] = nil
    end

    for k,v in pairs(getActiveTableIndex()) do
        getActiveTableIndex()[k] = nil
    end
end

function unfreezeAllSurfaces()
    restoreEntityStatuses()
    clearActiveStatusTables()
end

