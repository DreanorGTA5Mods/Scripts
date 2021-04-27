--[[
EXTRASUNNY 
CLEAR 
NEUTRAL 
SMOG 
FOGGY 
OVERCAST 
CLOUDS 
CLEARING 
RAIN 
THUNDER 
SNOW 
BLIZZARD 
SNOWLIGHT 
XMAS 
HALLOWEEN
--]]

Citizen.CreateThread(function()
    while true do
        permaWeather = "EXTRASUNNY"
        SetWeatherTypePersist(permaWeather)
        SetWeatherTypeNowPersist(permaWeather)
        SetWeatherTypeNow(permaWeather)
        SetOverrideWeather(permaWeather)

        SetForcePedFootstepsTracks(true)
        SetForceVehicleTrails(true)
    
        Citizen.Wait(0)
    end
end)
