Config = {}
Config = {
	Blips = true, -- Enable Blips?
	BlipNamer = true, -- Enable to Name Blips different things, disable if you already have too many blips as this will group them together
	PropSpawn = true, -- Enable Ore Props
	Pedspawn = true, -- Do you want to spawn peds for main locations?
	Invincible = true, --Do you want the peds to be invincible?
	Frozen = true, --Do you want the peds to be unable to move? It's probably a yes, so leave true in there.
	Stoic = true, --Do you want the peds to react to what is happening in their surroundings?
	Fade = true, -- Do you want the peds to fade into/out of existence? It looks better than just *POP* its there.
	Distance = 40.0, --The distance you want peds to spawn at
	EnableOpeningHours = true, -- Enable opening hours? If disabled you can always open the pawnshop.
	OpenHour = 9, -- From what hour should the pawnshop be open?
	CloseHour = 21, -- From what hour should the pawnshop be closed?
	ThirdPartyStorageSystem = true, -- true for disc-inventory
	StorageSlots = 70, -- max slots.
	StorageWeight = 500,
}
Config.Draw3D = true -- If false then make sure you use another script to trigger the event
Config.MaxRental = 100 -- Max rentals allowed out at once without returning them
Config.Locations =  { -- Position des points de location
	['Velo0'] = { name = "Location : vélo",type="velo",SpawnLocation = vector3(-1477.42, -1000.19, 6.31), location = vector3(-1479.8, -996.8, 5.41), heading = 185.64, blipTrue = true, Sprite = 225, Scale = 0.6, Colour = 30, }, 
	['Summer0'] = { name = "Locations estivales",type="summer",SpawnLocation = vector3(-1608.09, -1187.31, 0.49), location =vector3(-1605.15, -1178.34, 0), heading = 271.18, blipTrue = true, Sprite = 365, Scale = 0.8, Colour = 2, }, 
--	['Velo1'] = { name = "Location de vélo",type="velo",SpawnLocation = vector3(-1488.49, -989.98, 6.46), location = vector3(-1483.71, -992.58, 5.48), heading = 39.18, blipTrue = true, Sprite = 365, Scale = 0.8, Colour = 2, }, 
	['Voiture0'] = { name = "Location : voiture",type="voiture",SpawnLocation = vector3(249.82, -563.96, 43.27), location = vector3(248.67, -569.4, 42.27), heading = 259.68, blipTrue = true, Sprite = 225, Scale = 0.6, Colour = 2, },   
	['Voiture1'] = { name = "Location : voiture",type="voiture",SpawnLocation = vector3(-1347.25, -400.19, 36.5), location = vector3(-1351.51, -408.23, 35.27), heading = 87.2, blipTrue = true, Sprite = 225, Scale = 0.6, Colour = 2, },   
	['Voiture2'] = { name = "Location : voiture",type="voiture",SpawnLocation = vector3(-671.22, -1033.58, 17.47), location = vector3(-674.27, -1038.19, 16.12), heading = 238.64, blipTrue = true, Sprite = 225, Scale = 0.6, Colour = 2, },   
	['Voiture3'] = { name = "Location : voiture",type="voiture",SpawnLocation = vector3(422.24, -1560.93, 29.28), location = vector3(416.64, -1565.05, 28.29), heading = 106.44, blipTrue = true, Sprite = 225, Scale = 0.6, Colour = 2, },   	
    ['Voiture4'] = { name = "Location : voiture",type="voiture",SpawnLocation = vector3(1768.36, 3348.65, 40.73), location = vector3(1769.6, 3355.15, 39.32), heading = 317.73, blipTrue = true, Sprite = 225, Scale = 0.6, Colour = 2, },   
	['Voiture5'] = { name = "Location : voiture",type="voiture",SpawnLocation = vector3(199.24, 6630.5, 31.52), location = vector3(203.6, 6628.07, 30.58), heading = 131.43, blipTrue = true, Sprite = 225, Scale = 0.6, Colour = 2, },   
}

Config.PedList = { -- Quel pnj à quel point de location
	{ model = "a_f_y_beach_01", coords = Config.Locations['Velo0'].location, heading = Config.Locations['Velo0'].heading, gender = "female", scenario = "WORLD_HUMAN_CLIPBOARD", }, 
	{ model = "s_m_y_baywatch_01", coords = Config.Locations['Summer0'].location, heading = Config.Locations['Summer0'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", }, 
	--{ model = "a_m_y_beach_01", coords = Config.Locations['Velo1'].location, heading = Config.Locations['Velo1'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", }, 
    { model = "s_m_m_gardener_01", coords = Config.Locations['Voiture0'].location, heading = Config.Locations['Voiture0'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", },      
    { model = "s_m_m_gardener_01", coords = Config.Locations['Voiture1'].location, heading = Config.Locations['Voiture1'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", },      
    { model = "s_m_m_gardener_01", coords = Config.Locations['Voiture2'].location, heading = Config.Locations['Voiture2'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", },    
    { model = "s_m_m_gardener_01", coords = Config.Locations['Voiture3'].location, heading = Config.Locations['Voiture3'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", },    
    { model = "s_m_m_gardener_01", coords = Config.Locations['Voiture4'].location, heading = Config.Locations['Voiture4'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", },    
    { model = "s_m_m_gardener_01", coords = Config.Locations['Voiture5'].location, heading = Config.Locations['Voiture5'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", },    

}

Config.Vehicles = {
    ['velo'] = {
        [1] = {label = 'Loueur',info = "Louez un vélo"}, -- Titre
        [2] = {label = '',info = '✘ Fermer',price = 0,modelhash = '',server = false, event = "gm-rent:client:closemenu",args = -2},-- Fermer le menu
        [3] = {label = 'BMX',info = 'Pour faire des tricks',price = 15,loc=50, modelhash = 'bmx',server = true,event = "gm-rent:server:rentVehicle",args = 1 },
        [4] = {label = 'Cruiser',info = 'Pour se balader',price = 15,loc=50,modelhash = 'cruiser',server = true,event = "gm-rent:server:rentVehicle",args = 2 },
        [5] = {label = 'Fin de location',info = 'Rendre le véhicule',price = 0,modelhash = '',server = false,event = "gm-rent:client:delete" }, -- Permet de rendre le véhicule et de toucher la caution        
    },
	['summer'] = {
        [0] = {label = 'Loueur',info = "Louez un véhicule estival"}, -- Titre
        [1] = {label = '',info = '✘ Fermer',price = 0,modelhash = '',server = false, event = "gm-rent:client:closemenu",args = -2},-- Fermer le menu
        [2] = {label = "Surf",info = '$200 et $100 de caution',price = 200,loc=100, modelhash = 'windsurf',server = true,event = "gm-rent:server:rentVehicle",args = 1 },      
		[3] = {label = "Pédalo",info = '$200 et $100 de caution',price = 200,loc=100, modelhash = 'rowerwodny',server = true,event = "gm-rent:server:rentVehicle",args = 2 },    
		[4] = {label = "Seashark",info = '$200 et $100 de caution',price = 200,loc=100, modelhash = 'seashark3',server = true,event = "gm-rent:server:rentVehicle",args = 3 },      
        [5] = {label = 'Fin de location',info = 'Rendre le véhicule',price = 0,modelhash = '',server = false,event = "gm-rent:client:delete" }, -- Permet de rendre le véhicule et de toucher la caution        
    },
    ['voiture'] = {
        [0] = {label = 'Loueur',info = "Louez une voiture"}, -- Titre
        [1] = {label = '',info = '✘ Fermer',price = 0,modelhash = '',server = false, event = "gm-rent:client:closemenu",args = -2},-- Fermer le menu
        [2] = {label = "C'est mieux que rien",info = '$300 et $500 de caution',price = 300,loc=500, modelhash = 'brioso2',server = true,event = "gm-rent:server:rentVehicle",args = 2 },        
        [3] = {label = 'Fin de location',info = 'Rendre le véhicule',price = 0,modelhash = '',server = false,event = "gm-rent:client:delete" }, -- Permet de rendre le véhicule et de toucher la caution        
    },
}