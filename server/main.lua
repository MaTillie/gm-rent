local QBCore = exports['qb-core']:GetCoreObject()
local RentVehicles = {}

RegisterNetEvent('gm-rent:server:rentVehicle', function(data)
    print("R1")
    
    print(data.price)
    print(data.modelhash)
    local src = source
    print("R2")
    local spawndata = {
        vehicle = data.modelhash,
        SpawnLocation = data.SpawnLocation,    
        price = data.loc,
    }

    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money['cash']
    local bank = Player.PlayerData.money['bank']
    local flg = false;
    priceTot = data.price + data.loc
        if cash >= priceTot then
            TriggerClientEvent("gm-rent:client:spawnbike", src, spawndata)
            Player.Functions.RemoveMoney('cash', priceTot)
            flg = true;            
        elseif bank >= priceTot then
            TriggerClientEvent("gm-rent:client:spawnbike", src, spawndata)
            Player.Functions.RemoveMoney('bank', priceTot)
            flg = true;
        else
            TriggerClientEvent('QBCore:Notify', src, "Vous n'avez pas assez d'argent.", "error", "2500")
        end

        if flg then
            TriggerClientEvent('QBCore:Notify', src, "La caution de $"..data.loc.." vous a été prélevée.", "success", "5000")
            TriggerClientEvent('QBCore:Notify', src, "La prix de location de $"..data.price.." vous a été prélevée.", "success", "5000")
        end
    print("R3")
end)


RegisterNetEvent('gm-rent:server:AddRentVehicles', function(data)
    print(data.price)
    print(data.plate)
    RentVehicles[data.plate] = data.price
end)

function setContains(set, key)
    return set[key] ~= nil
end

RegisterNetEvent('gm-rent:server:RentVehiclesBack', function(plate)
    local src = source
        local Player = QBCore.Functions.GetPlayer(src)

    if setContains(RentVehicles,plate) then
        
        Player.Functions.AddMoney('cash', RentVehicles[plate])
        
        TriggerClientEvent('gm-rent:client:DeleteRentVehicles', src);
        TriggerClientEvent('QBCore:Notify', src, "Voici la caution de $"..RentVehicles[plate]..".", "success", "2500")           
    else

        TriggerClientEvent('QBCore:Notify', src, "Ce n'est pas un véhicule de location.", "error", "2500")  
    end
end)

