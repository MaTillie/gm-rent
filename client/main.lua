local QBCore = exports['qb-core']:GetCoreObject()
function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
Citizen.CreateThread(function()
    if Config.Blips == true then
		CreateBlips()
	end
end)
Citizen.CreateThread(function()
	if Config.Pedspawn == true then
		CreatePeds()
	end
end)
function CreateBlips()
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].blipTrue then
			local blip = AddBlipForCoord(v.location)
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, v.Sprite)
			SetBlipColour(blip, v.Colour)
			SetBlipScale(blip, v.Scale)
			SetBlipDisplay(blip, 6)
			BeginTextCommandSetBlipName('STRING')
			if Config.BlipNamer then
                AddTextComponentString(v.name)
			else
				AddTextComponentString("Location")
			end
			EndTextCommandSetBlipName(blip)
		end
	end
end
-----------------------------------------------------------------
--PedSpawning Locations
local peds = {}
local shopPeds = {}
function CreatePeds()
	while true do
		Citizen.Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)
			if dist < Config.Distance and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end
			if dist >= Config.Distance and peds[k] then
				if Config.Fade then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(peds[k].ped, i, false)
					end
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end
function nearPed(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(1)
	end
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end
	if Config.MinusOne then 
		local x, y, z = table.unpack(coords)
		ped = CreatePed(genderNum, GetHashKey(model), x, y, z - 1, heading, false, true)
		table.insert(shopPeds, ped)
	else
		ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
		table.insert(shopPeds, ped)
	end
	SetEntityAlpha(ped, 0, false)
	if Config.Frozen then
		FreezeEntityPosition(ped, true) --Don't let the ped move.
	end
	if Config.Invincible then
		SetEntityInvincible(ped, true) --Don't let the ped die.
	end
    if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(ped, true) --Don't let the ped react to his surroundings.
	end
	--Add an animation to the ped, if one exists.
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) -- begins peds animation
	end
	if Config.Fade then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(ped, i, false)
		end
	end
	return ped
end

-- Gestion loueur
Citizen.CreateThread(function()
	exports['qb-target']:AddCircleZone("Velo0", Config.Locations['Velo0'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVelo0", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })
	exports['qb-target']:AddCircleZone("Summer0", Config.Locations['Summer0'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuSummer0", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })
 /*   exports['qb-target']:AddCircleZone("Velo1", Config.Locations['Velo1'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVelo1", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })	*/
	exports['qb-target']:AddCircleZone("Voiture0", Config.Locations['Voiture0'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVoiture0", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })	
	exports['qb-target']:AddCircleZone("Voiture1", Config.Locations['Voiture1'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVoiture1", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })
	exports['qb-target']:AddCircleZone("Voiture2", Config.Locations['Voiture2'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVoiture2", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })
	exports['qb-target']:AddCircleZone("Voiture3", Config.Locations['Voiture3'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVoiture3", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })
	exports['qb-target']:AddCircleZone("Voiture4", Config.Locations['Voiture4'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVoiture4", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })
	exports['qb-target']:AddCircleZone("Voiture5", Config.Locations['Voiture5'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVoiture5", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })
end)


RegisterNetEvent('gm-menu:client:GenMenu')
AddEventHandler('gm-menu:client:GenMenu', function(data) --Config.Vehicles
    local Menu = {}
    local cpt = 0
    for k, v in pairs(Config.Vehicles[data.type]) do
        if cpt ==0 then
            Menu[#Menu+1] = {
                header = v.label,
                txt = v.info,
                isMenuHeader = true,
				
            }
        else
        Menu[#Menu+1] = {
            header = v.label,
            txt = v.info,
            params = {
				isServer = v.server,
				event = v.event,
				args = {
				--	choix  = v.args,
				price = v.price,
				loc = v.loc,
				modelhash = v.modelhash,
				SpawnLocation = data.SpawnLocation
				}
            }
        }
        end
        cpt = cpt + 1;
    end
    exports['qb-menu']:openMenu(Menu)
end)

-- Menu loueur de vélo
RegisterNetEvent('gm-rent:Rent:MenuVelo0', function()
    local data ={
        type=Config.Locations['Velo0'].type,
        SpawnLocation=Config.Locations['Velo0'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)

end)

RegisterNetEvent('gm-rent:Rent:MenuSummer0', function()
    local data ={
        type=Config.Locations['Summer0'].type,
        SpawnLocation=Config.Locations['Summer0'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)

end)

RegisterNetEvent('gm-rent:Rent:MenuVelo1', function()
    local data ={
        type=Config.Locations['Velo1'].type,
        SpawnLocation=Config.Locations['Velo1'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)

RegisterNetEvent('gm-rent:Rent:MenuVoiture0', function()
    local data ={
        type=Config.Locations['Voiture0'].type,
        SpawnLocation=Config.Locations['Voiture0'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)

RegisterNetEvent('gm-rent:Rent:MenuVoiture1', function()
    local data ={
        type=Config.Locations['Voiture1'].type,
        SpawnLocation=Config.Locations['Voiture1'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)

RegisterNetEvent('gm-rent:Rent:MenuVoiture2', function()
    local data ={
        type=Config.Locations['Voiture2'].type,
        SpawnLocation=Config.Locations['Voiture2'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)

RegisterNetEvent('gm-rent:Rent:MenuVoiture3', function()
    local data ={
        type=Config.Locations['Voiture3'].type,
        SpawnLocation=Config.Locations['Voiture3'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)

RegisterNetEvent('gm-rent:Rent:MenuVoiture4', function()
    local data ={
        type=Config.Locations['Voiture4'].type,
        SpawnLocation=Config.Locations['Voiture4'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)

RegisterNetEvent('gm-rent:Rent:MenuVoiture5', function()
    local data ={
        type=Config.Locations['Voiture5'].type,
        SpawnLocation=Config.Locations['Voiture5'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)

RegisterNetEvent('gm-rent:client:closemenu')
AddEventHandler('gm-rent:client:closemenu', function()
	exports['qb-menu']:closeMenu()
end)


RegisterNetEvent('gm-rent:client:spawnbike')
AddEventHandler('gm-rent:client:spawnbike', function(data)
	print("S1")
    print(data.vehicle)
	print(data.SpawnLocation)
    QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
		print("S2")
        SetVehicleNumberPlateText(veh, "LOC"..tostring(math.random(10000, 99999)))
        exports['if-fuel']:SetFuel(veh, 100.0)
        SetEntityHeading(veh, 250.0)
        --TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
		TriggerServerEvent('vehiclekeys:server:givekey', GetVehicleNumberPlateText(veh))
        local RentData ={
            plate = GetVehicleNumberPlateText(veh),
            price = data.price,
        }
		print(data.price)
		print(data.loc)
        TriggerServerEvent("gm-rent:server:AddRentVehicles", RentData)
    end, data.SpawnLocation, true)
end)

RegisterNetEvent('gm-rent:client:delete', function()
	print("F1")
	local ped = PlayerPedId()
	local curVeh = GetVehiclePedIsIn(ped)
	if curVeh == 0 then
		QBCore.Functions.Notify("Vous n'êtes pas dans un véhicule.", 'error')
	else
		plate = QBCore.Functions.GetPlate(curVeh)	
		print(plate)
		TriggerServerEvent('gm-rent:server:RentVehiclesBack',plate)
		TriggerServerEvent('vehiclekeys:server:removekey', GetVehicleNumberPlateText(veh))
	end
end)

RegisterNetEvent('gm-rent:client:DeleteRentVehicles', function()
	local ped = PlayerPedId()
	QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
end)