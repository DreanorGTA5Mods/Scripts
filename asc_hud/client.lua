function HideHudElements()
    --HideHudComponentThisFrame(0) --HUD
    HideHudComponentThisFrame(1) --HUD_WANTED_STARS
    HideHudComponentThisFrame(2) --HUD_WEAPON_ICON
    HideHudComponentThisFrame(3) --HUD_CASH
    HideHudComponentThisFrame(4) --HUD_MP_CASH
    HideHudComponentThisFrame(5) --HUD_MP_MESSAGE
    HideHudComponentThisFrame(6) --HUD_VEHICLE_NAME
    HideHudComponentThisFrame(7) --HUD_AREA_NAME
    HideHudComponentThisFrame(8) --HUD_VEHICLE_CLASS
    HideHudComponentThisFrame(9) --HUD_STREET_NAME 
    HideHudComponentThisFrame(10) --HUD_HELP_TEXT
    HideHudComponentThisFrame(11) --HUD_FLOATING_HELP_TEXT_1
    HideHudComponentThisFrame(12) --HUD_FLOATING_HELP_TEXT_2
    HideHudComponentThisFrame(13) --HUD_CASH_CHANGE
    HideHudComponentThisFrame(14) --HUD_RETICLE
    HideHudComponentThisFrame(15) --HUD_SUBTITLE_TEXT
    HideHudComponentThisFrame(16) --HUD_RADIO_STATIONS
    HideHudComponentThisFrame(17) --HUD_SAVING_GAME
    HideHudComponentThisFrame(18) --HUD_GAME_STREAM
    HideHudComponentThisFrame(19) --HUD_WEAPON_WHEEL
    HideHudComponentThisFrame(20) --HUD_WEAPON_WHEEL_STATS
    HideHudComponentThisFrame(21) --MAX_HUD_COMPONENTS
    HideHudComponentThisFrame(22) --MAX_HUD_WEAPONS

    -- Hide Minimap if player is not in a vehicle
    if IsPedInAnyVehicle(PlayerPedId(), false) 
    then
        DisplayRadar(true)
    else
        DisplayRadar(false)
    end
    
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        HideHudElements()
    end
end)