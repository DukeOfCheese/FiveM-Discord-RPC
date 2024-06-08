---------------------------------------------
-------------Atlas Development---------------
---------------------------------------------
------Editing this file may cause issues-----
------------Use config.lua instead-----------

Citizen.CreateThread(function(source)
    local player = GetPlayerPed(-1)
    local index = GetPlayerIndex(player)
    local id = GetPlayerServerId(PlayerId())
    local player_name = GetPlayerName(index)
    while true do
        -- DO NOT TOUCH THIS SECTION, it makes sure your game doesn't crash and is getting variables correctly
        -- If you do know what you are doing, feel free to make a pull request
        local player_count = #GetActivePlayers()
        local start_fps = GetFrameCount()
        Citizen.Wait(5*1000)
        local end_fps = GetFrameCount()
        local fps = math.floor((end_fps - start_fps) / 5)

        -- The values below are controlled by config.lua, so please edit them there
        -- NO NEED TO EDIT - USE CONFIG.LUA
        SetDiscordAppId(Config.AppID)
        SetRichPresence("Players: ".. player_count .. "/".. Config.maxplayers)
        SetDiscordRichPresenceAsset("big")
        if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
            local speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*2.2369
            SetDiscordRichPresenceAssetText("Player is driving on " .. GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(player)))) .. " at " .. math.floor(speed) .. " mph")
        elseif not (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
            SetDiscordRichPresenceAssetText("Player is walking on " .. GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(player)))))
        end
        SetDiscordRichPresenceAssetSmall("small")
        SetDiscordRichPresenceAssetSmallText("ID: ".. id .. " | " .. "FPS: " .. fps .. " fps")

        SetDiscordRichPresenceAction(0, Config.button1_text, Config.button1_link)
        SetDiscordRichPresenceAction(1, Config.button2_text, Config.button2_link)

    end
end)

-----Presented by Atlas Development-----
-------Created by DukeOfCheese----------