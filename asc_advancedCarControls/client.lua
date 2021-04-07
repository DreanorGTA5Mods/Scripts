local enableMph = false
local cruiseControlState = false
local shiftSpeed = 0

function GetMinimapAnchor()
    -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
    -- 0.05 * ((safezone - 0.9) * 10)
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

function DrawMinimapText(text, yAdjust)
    SetTextEntry("STRING")
    SetTextScale(0.0, 0.3)
    local ui = GetMinimapAnchor()
    AddTextComponentString(text)
    SetTextDropShadow(0, 0, 0, 0,255)
    DrawText(ui.right_x + 0.03, ui.y + yAdjust)    
end

function SetCruiseControl(vehicle, speed, shifter)
    if (IsVehicleOnAllWheels(vehicle) and speed*3.6 > 50 + shifter)
    then
        SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), speed)
    end
end

-- Speedometer / Cruisecontrol
Citizen.CreateThread(function()
    while true do 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local speed = GetEntitySpeed(vehicle)
		local kmh = 3.6
		local mph = 2.23694
        Citizen.Wait( 0 )   

        if (vehicle > 0) 
        then
            --Y 
            if (IsControlJustPressed(0, 246)) 
            then
                cruiseControlState = not cruiseControlState
                shiftSpeed = 0
            end   

            if(cruiseControlState == true)
            then
                DrawMinimapText("Cruise", 0.02)

                --Shift
                if (IsControlPressed(0, 21)) 
                then
                    shiftSpeed = shiftSpeed + 3;
                end

                --Capslock
                if (IsControlPressed(0, 137)) 
                then
                    shiftSpeed = shiftSpeed - 3;
                end

                SetCruiseControl(vehicle, speed, shiftSpeed)
            end

        
            if (enableMph == true) 
            then 
                DrawMinimapText("" .. math.floor(speed*mph, 2) .." mph", 0)
            else 
                DrawMinimapText("" .. math.floor(speed*kmh, 2) .." km/h", 0)
            end
        end
    end
end)

--DEBUG shit
function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

RegisterCommand('car', function(source, args, rawCommand)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local veh = args[1]
    if veh == nil then veh = "Sheava" end
    vehiclehash = GetHashKey(veh)
    RequestModel(vehiclehash)
    
    Citizen.CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                ShowNotification("~r~Could not load the vehicle model in time, a crash was prevented.")
                break
            end
        end
        CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
    end)
end)
