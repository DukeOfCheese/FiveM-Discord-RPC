---------------------------------------------
-------------Atlas Development---------------
---------------------------------------------
------Editing this file may cause issues-----
------------Use config.lua instead-----------
---------------------------------------------
local player = GetPlayerPed(-1)
local index = GetPlayerIndex(player)
local id = GetPlayerServerId(PlayerId())
local player_name = GetPlayerName(index)
local driveable = {0, 2, 3, 5, 6, 7, 11, 12}
local flyable = {1, 8, 9, 10}
local sail = {13, 15}

local function tableContains(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function(source)
    while true do
        -- DO NOT TOUCH THIS SECTION, it ensures your game doesn't crash and retrieves variables correctly
        local player_count = #GetActivePlayers()
        local start_fps = GetFrameCount()
        Citizen.Wait(5 * 1000)
        local end_fps = GetFrameCount()
        local fps = math.floor((end_fps - start_fps) / 5)
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player)

        -- Configuration-based Discord presence setup
        SetDiscordAppId(Config.AppID)
        SetRichPresence("Players: " .. player_count .. "/" .. Config.maxplayers)
        SetDiscordRichPresenceAsset("big")

        if vehicle then
            local speed = GetEntitySpeed(vehicle) * 2.2369 -- Convert m/s to mph
            local vehicleType = GetVehicleTypeRaw(vehicle)
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(player))))

            if tableContains(driveable, vehicleType) then
                SetDiscordRichPresenceAssetText("Player is driving on " .. streetName .. " at " .. math.floor(speed) .. " mph")
            elseif tableContains(flyable, vehicleType) then
                SetDiscordRichPresenceAssetText("Player is flying on " .. streetName .. " at " .. math.floor(speed) .. " mph")
            elseif tableContains(sail, vehicleType) then
                SetDiscordRichPresenceAssetText("Player is sailing on " .. streetName .. " at " .. math.floor(speed) .. " mph")
            end
        else
            SetDiscordRichPresenceAssetText("Player is walking on " .. GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(player)))))
        end

        SetDiscordRichPresenceAssetSmall("small")
        SetDiscordRichPresenceAssetSmallText("ID: " .. id .. " | FPS: " .. fps .. " fps")

        SetDiscordRichPresenceAction(0, Config.button1_text, Config.button1_link)
        SetDiscordRichPresenceAction(1, Config.button2_text, Config.button2_link)
    end
end)

-----Presented by Atlas Development-----
-------Created by DukeOfCheese----------