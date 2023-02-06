/*
Pour ajouter un vendeur :
// Définir la position et le menu
Dans config.lua, dans Config.Locations ajouter :
['Velo0'] = {                                               -- Identifant unique du vendeur
    name = "Location de vélo",                              -- Libellé
    type="velo",                                            -- Type de vendeur, fait référence à l'identifiant unique d'un menu de vente configuré dans Config.Vehicles
    SpawnLocation = vector3(-1467.32, -1005.69, 6.34),      -- Point de spawn du véhicule
    location = vector3(-1479.8, -996.8, 5.41),              -- Point du pnj et du blips
    heading = 185.64,                                       -- Angle de rotation du pnj
    blipTrue = true,                                        -- Si on active le blips
    Sprite = 365,                                           -- Modèle du blips
    Scale = 0.8,                                            -- Taille du blips
    Colour = 2,                                             -- Couleur du blips
}, 

// Définir le ped
Dans config.lua, dans Config.PedList ajouter :
Faire référence à la configuration créé dans Config.Locations 
{ model = "a_f_y_beach_01", 
coords = Config.Locations['Velo0'].location,    
heading = Config.Locations['Velo0'].heading, 
gender = "female", 
scenario = "WORLD_HUMAN_CLIPBOARD", }, 


// Gestion du pop ped : (provisoire en attendant un màj du qb-target)
Dans client/main.lua ajouter dans le thread de gestion de loueur
-- Gestion loueur
Citizen.CreateThread(function()
	exports['qb-target']:AddCircleZone("Velo0", Config.Locations['Velo0'].location, 2.0, { name="tradeitems", debugPoly=false, useZ=true, },
    { options = { { event = "gm-rent:Rent:MenuVelo0", icon = "fas fa-key", label = "Loueur", }, },
					distance = 2
    })

// Gestion du menu : (provisoire en attendant un màj du qb-target)   
    Dans client/main.lua ajouter une nouvelle fonction, propore au vendeur
RegisterNetEvent('gm-rent:Rent:MenuVelo1', function()
    local data ={
        type=Config.Locations['Velo1'].type,
        SpawnLocation=Config.Locations['Velo1'].SpawnLocation
    }
    TriggerEvent('gm-menu:client:GenMenu',data)
end)


*/