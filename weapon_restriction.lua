--[[ 
    Made by Bizarre
    Discord Role Weapon Restriction Script for FiveM
]]

-- Weapon restrictions based on Discord roles
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Check every 5 seconds

        local player = GetPlayerPed(-1)
        local playerId = PlayerId()
        local discordId = GetDiscordIdentifier(playerId)

        if discordId then
            TriggerServerEvent('checkDiscordRoles', discordId)
        end
    end
end)

-- Server-side script to check the player's Discord roles
RegisterNetEvent('checkDiscordRoles')
AddEventHandler('checkDiscordRoles', function(discordId)
    local discordRoles = exports.DiscordRoles:GetRoles(discordId)

    -- Management roles, unrestricted
    if discordRoles["909667100963008552"] or discordRoles["1111495205384896512"] then
        -- CM has access to all weapons, including snipers and explosives
        return
    end

    -- Law enforcement roles, restricted access but can use Heavy Sniper and MK2
    if discordRoles["879196160064118844"] or discordRoles["878846101153808385"] or discordRoles["878841439092604988"] then
        RestrictLEOWeapons()
        return
    end

    -- Civilian Restriction Level 2 (only melee weapons)
    if discordRoles["1294730432012877906"] then
        RestrictWeaponsLevel2()
        return
    end

    -- Civilian Restriction Level 1 (only pistols and melee weapons)
    if discordRoles["1294730430792073347"] then
        RestrictWeaponsLevel1()
        return
    end

    -- Regular Civilian role (restricted access to realistic weapons only)
    if discordRoles["1041855685954109552"] then
        RestrictCivilianWeapons()
    end
end)

-- Function to restrict unrealistic weapons for LEO but allow Heavy Sniper and Heavy Sniper MK2
function RestrictLEOWeapons()
    local restrictedWeapons = {
        -- Unrealistic/explosive weapons
        "WEAPON_GRENADE",              -- Grenade
        "WEAPON_STICKYBOMB",           -- Sticky Bomb
        "WEAPON_PROXMINE",             -- Proximity Mine
        "WEAPON_PIPEBOMB",             -- Pipe Bomb
        "WEAPON_RPG",                  -- RPG
        "WEAPON_HOMINGLAUNCHER",       -- Homing Launcher
        "WEAPON_MINIGUN",              -- Minigun
        "WEAPON_RAILGUN",              -- Railgun
        "WEAPON_GRENADELAUNCHER",      -- Grenade Launcher
        "WEAPON_COMPACTLAUNCHER",      -- Compact Grenade Launcher
        -- Other snipers (restricted)
        "WEAPON_SNIPERRIFLE",          -- Sniper Rifle
        "WEAPON_MARKSMANRIFLE"         -- Marksman Rifle
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end

-- Function to restrict unrealistic weapons for Civilian Restriction Level 1 (only pistols and melee weapons)
function RestrictWeaponsLevel1()
    local restrictedWeapons = {
        "WEAPON_ASSAULTRIFLE", 
        "WEAPON_CARBINERIFLE",         -- Carbine Rifle
        "WEAPON_SNIPERRIFLE",          -- Sniper Rifle
        "WEAPON_MARKSMANRIFLE",        -- Marksman Rifle
        -- Unrealistic/explosive weapons
        "WEAPON_GRENADE",              -- Grenade
        "WEAPON_STICKYBOMB",           -- Sticky Bomb
        "WEAPON_PROXMINE",             -- Proximity Mine
        "WEAPON_PIPEBOMB",             -- Pipe Bomb
        "WEAPON_RPG",                  -- RPG
        "WEAPON_HOMINGLAUNCHER",       -- Homing Launcher
        "WEAPON_MINIGUN",              -- Minigun
        "WEAPON_RAILGUN",              -- Railgun
        "WEAPON_GRENADELAUNCHER",      -- Grenade Launcher
        "WEAPON_COMPACTLAUNCHER",      -- Compact Grenade Launcher
        "WEAPON_BZGAS",                -- BZ Gas
        "WEAPON_MOLOTOV"               -- Molotov Cocktail
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end

-- Function to restrict all weapons except melee for Civilian Restriction Level 2
function RestrictWeaponsLevel2()
    local restrictedWeapons = {
        "WEAPON_PISTOL", 
        "WEAPON_SMG",                  -- Submachine Gun
        "WEAPON_ASSAULTRIFLE", 
        "WEAPON_CARBINERIFLE",         -- Carbine Rifle
        "WEAPON_SNIPERRIFLE",          -- Sniper Rifle
        "WEAPON_MARKSMANRIFLE",        -- Marksman Rifle
        -- Unrealistic/explosive weapons
        "WEAPON_GRENADE",              -- Grenade
        "WEAPON_STICKYBOMB",           -- Sticky Bomb
        "WEAPON_PROXMINE",             -- Proximity Mine
        "WEAPON_PIPEBOMB",             -- Pipe Bomb
        "WEAPON_RPG",                  -- RPG
        "WEAPON_HOMINGLAUNCHER",       -- Homing Launcher
        "WEAPON_MINIGUN",              -- Minigun
        "WEAPON_RAILGUN",              -- Railgun
        "WEAPON_GRENADELAUNCHER",      -- Grenade Launcher
        "WEAPON_COMPACTLAUNCHER",      -- Compact Grenade Launcher
        "WEAPON_BZGAS",                -- BZ Gas
        "WEAPON_MOLOTOV"               -- Molotov Cocktail
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end

-- Function to restrict regular civilians to realistic weapons, allowing Molotov and BZ Gas
function RestrictCivilianWeapons()
    local restrictedWeapons = {
        "WEAPON_ASSAULTRIFLE", 
        "WEAPON_CARBINERIFLE",         -- Carbine Rifle
        "WEAPON_SNIPERRIFLE",          -- Sniper Rifle
        "WEAPON_MARKSMANRIFLE",        -- Marksman Rifle
        -- Unrealistic/explosive weapons
        "WEAPON_GRENADE",              -- Grenade
        "WEAPON_STICKYBOMB",           -- Sticky Bomb
        "WEAPON_PROXMINE",             -- Proximity Mine
        "WEAPON_PIPEBOMB",             -- Pipe Bomb
        "WEAPON_RPG",                  -- RPG
        "WEAPON_HOMINGLAUNCHER",       -- Homing Launcher
        "WEAPON_MINIGUN",              -- Minigun
        "WEAPON_RAILGUN",              -- Railgun
        "WEAPON_GRENADELAUNCHER",      -- Grenade Launcher
        "WEAPON_COMPACTLAUNCHER"       -- Compact Grenade Launcher
    }

    for _, weapon in pairs(restrictedWeapons) do
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end

-- Utility function to get Discord identifier
function GetDiscordIdentifier(playerId)
    for i = 0, GetNumPlayerIdentifiers(playerId) - 1 do
        local identifier = GetPlayerIdentifier(playerId, i)
        if string.find(identifier, "discord:") then
            return identifier
        end
    end
    return nil
end
