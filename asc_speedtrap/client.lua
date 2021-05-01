local currentPlayer = GetPlayerPed(-1)
local speedcams = {} --object size speed
local units = 3.6 --kmh
--local units = 2.23694 --mph

TriggerEvent('chat:addSuggestion', '/create', 'creates a speedtrap', {
    { name="size", help="size of the speedtrap" },
    { name="speed", help="speed on which to trigger" }
})

RegisterCommand('create', function(source, args, rawCommand)
    if args[2] == nil then
        return
    end
    
    -- Create object
    local hash = GetHashKey("prop_cs_cctv")
    RequestModel(hash)
    while not HasModelLoaded(hash) 
    do 
        Citizen.Wait(0)
    end

    local pos = GetOffsetFromEntityInWorldCoords(currentPlayer, 0.0, 0, -1.0)
    object = CreateObject(hash, pos.x, pos.y, pos.z, true, true)

    -- View direction
    SetEntityHeading(object, GetEntityHeading(currentPlayer))
    
    -- Flip upside down
    local rotation = GetEntityRotation(object, 2)
    SetEntityRotation(object, rotation.x, rotation.y+180, rotation.z+180, 0, true)
    
    -- Persist
    SetEntityAsMissionEntity(object, true, true)
    local blip = AddBlipForEntity(object)

    speedcam = { cam = object, size = tonumber(args[1]) + .0, speed = tonumber(args[2]), blip = blip }
    speedcams[#speedcams+1] = speedcam    
end)

function GetSpeed()
    local vehicle = GetVehiclePedIsIn(currentPlayer, false)
    local speed = GetEntitySpeed(vehicle)

    return math.floor(speed*units, 2)
end

function SpeedTrapTriggered(speedcam, speed)
    --add whatever
    
end

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        for i, obj in ipairs(speedcams) do
            local trapPos = GetEntityCoords(obj.cam)

            DrawMarker(1, trapPos.x, trapPos.y, trapPos.z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, obj.size, obj.size, obj.size, 255, 0, 0, 50, false, true, 2, nil, nil, false)
            local playerPos = GetEntityCoords(currentPlayer);
            local vehSpeed = GetSpeed()
            if(IsPedInAnyVehicle(currentPlayer) 
                and GetDistanceBetweenCoords(trapPos, playerPos, true) < obj.size / 2
                and vehSpeed > obj.speed) then
                SpeedTrapTriggered(obj, vehSpeed)         
            end
        end
    end
end)

