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

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(player, false)
        local player_count = #GetActivePlayers()

        SetDiscordAppId(Config.AppID)
        SetDiscordRichPresenceAsset("big")
        SetDiscordRichPresenceAssetSmall("small")
        SetRichPresence("Players: " .. player_count .. "/" .. Config.maxplayers)

        if IsPedInAnyVehicle(player, false) then
            local speed = GetEntitySpeed(vehicle) * 2.2369 -- m/s to mph
            local vehicleType = GetVehicleTypeRaw(vehicle)
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(player))))

            if tableContains(driveable, vehicleType) then
                SetDiscordRichPresenceAssetText("Driving on " .. streetName .. " at " .. math.floor(speed) .. " mph")
            elseif tableContains(flyable, vehicleType) then
                SetDiscordRichPresenceAssetText("Flying over " .. streetName .. " at " .. math.floor(speed) .. " mph")
            elseif tableContains(sail, vehicleType) then
                SetDiscordRichPresenceAssetText("Sailing near " .. streetName .. " at " .. math.floor(speed) .. " mph")
            end
        else
            local coords = GetEntityCoords(player)
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
            SetDiscordRichPresenceAssetText("Walking on " .. streetName)
        end

        local start_fps = GetFrameCount()
        Citizen.Wait(1000)
        local fps = GetFrameCount() - start_fps

        SetDiscordRichPresenceAssetSmallText("ID: " .. id .. " | FPS: " .. fps)
        SetDiscordRichPresenceAction(0, Config.button1_text, Config.button1_link)
        SetDiscordRichPresenceAction(1, Config.button2_text, Config.button2_link)
        Citizen.Wait(5000)
    end
end)

-----Presented by Atlas Development-----
-------Created by DukeOfCheese----------