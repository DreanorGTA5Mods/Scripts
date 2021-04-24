local currentPlayer = GetPlayerPed(-1)
local speedcams = {}

RegisterCommand('create', function(source, args, rawCommand)
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
    AddBlipForEntity(object)
    speedcams[#speedcams+1] = object    
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for i, obj in ipairs(speedcams) do
            local pos = GetEntityCoords(obj)

            local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(obj, 0.0, -20.0, 0.0))
            local lensOffset = 0.16
            DrawLine(pos.x, pos.y, pos.z + lensOffset, x, y, z + lensOffset, 255, 0, 0, 255)  
        end
    end
end)