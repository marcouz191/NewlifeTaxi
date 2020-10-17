ESX = nil

RegisterNetEvent('esx:playerLoaded' )
AddEventHandler('esx:playerLoaded', fonction(xPlayer)
	PlayerData = xPlayer
Fin)

RegisterNetEvent('esx:setJob' )
AddEventHandler('esx:setJob', fonction(emploi)
 PlayerData. emploi = emploi
Fin)

Citoyen. CreateThread(fonction)()
	tandis que ESX == nil do
		TriggerEvent('esx:getSharedObject', fonction(obj) ESX = obj fin)
 Citoyen. Attente(0)
	Fin
Fin)

----
-- véhicules @var[plate_number] = newVehicle Object
véhicules locaux = {}

---- Récupérer les clés d’un joueur lorsqu’il se reconnecte.
-- Les touches sont synchronisées avec le serveur. Si vous redémarrez le serveur, toutes les touches disparaissent.
AddEventHandler("playerSpawned« , fonction()
    TriggerServerEvent("ls:retrieveVehiclesOnconnect» )
Fin)

---- Fil principal
-- La logique du script est ici
Citoyen. CreateThread(fonction)()
    tandis que vrai faire
        Attente(0)

        -- Si la clé définie est pressée
        si(IsControlJustPressed(1, Config. clé))puis

            -- Infos sur les joueurs init
            pli local = GetPlayerPed(-1)
            pCoords locaux = GetEntityCoords(ply, true)
            px local, py, pz = table. déballer(GetEntityCoords(ply, true))
 isInside = faux

            -- Récupérer l’id local du véhicule ciblé
            si(IsPedInAnyVehicle(pli, vrai))puis
                -- en s’asseyant à l’intérieur de lui
 localVehId = GetVehiculePedIsIn(GetPlayerPed(-1), faux)
 isInside = vrai
            Autre
                -- en ciblant le véhicule
 localVehId = GetTargetedVehicule(pCoords, ply)
            Fin

            -- Obtenir des informations ciblées sur les véhicules
            si(localVehId et localVehId ~= 0)puis
                 localVehPlateTest = GetVehiculeNumberPlateText(localVehId)
                si localVehPlateTest ~= nil, puis
                     localVehPlate = string.lower(localVehPlateTest)
                    local LocalVehLockStatus = GetVehiculeDoorLockStatus(localVehId)
                    local hasKey = false

                    -- Si le véhicule apparaît dans la table (s’il s’agit du véhicule du joueur ou d’un véhicule verrouillé)
                    pour la plaque, le véhicule par paires(véhicules) ne
                        si(string.lower(plaque) == localVehPlate)puis
                            -- Si le véhicule n’est pas verrouillé (c’est le véhicule du joueur)
                            si(véhicule ~=  "verrouillé")alors
 hasKey = vrai
                                si(heure > minuterie),puis
                                    -- mettre à jour les informations du véhicule (Utile pour les instances hydratantes créées par la commande /givekey)
 Véhicule. mise à jour(localVehId, localVehLockStatus)
                                    -- Verrouiller ou déverrouiller le véhicule
 Véhicule. serrure()
 temps = 0
                                Autre
                                    TriggerEvent("ls:notify", _U("lock_cooldown", (minuterie / 1000)))
                                Fin
                            Autre
                                TriggerEvent("ls:notify", _U("keys_not_inside» ))
                            Fin
                        Fin
                    Fin

                    -- Si le joueur n’a pas les clés
                    si(n’a pasKey) puis
                        -- Si le joueur est à l’intérieur du véhicule
                        si(est à l’écart)puis
                            -- Si le joueur trouve les clés
                            si(canSteal())alors
                                -- Vérifiez si le véhicule est déjà la propriété.
                                -- Et envoyez les paramètres pour créer l’objet du véhicule si ce n’est pas le cas.
                                TriggerServerEvent('ls:checkOwner', localVehId, localVehPlate, localVehLockStatus)
                            Autre
                                -- Si le joueur ne trouve pas les clés
                                -- Verrouiller le véhicule (les joueurs ne peuvent pas essayer de trouver les clés à nouveau)
 véhicules[localVehPlate] =  "verrouillé» 
                                TriggerServerEvent("ls:lockTheVehicule", localVehPlate)
                                TriggerEvent("ls:notify", _U("keys_not_inside» ))
                            Fin
                        Fin
                    Fin
                Autre
                    TriggerEvent("ls:notify", _U("could_not_find_plate» ))
                Fin
            Fin
        Fin
    Fin
Fin)

RegisterNetEvent('VerouillerLeVehiculeMenu' )
AddEventHandler('VerouillerLeVehiculeMenu', fonction()
	pos local = GetEntityCoords(GetPlayerPed(-1),vrai)
	Citizen.Wait(100)
	imprimer(pos)
	localVehId = ESX. Jeu. GetClosestVehicle(pos)
	Citizen.Wait(100)
	imprimer(localVehId)
	imprimer(GetVehiculeEngineHealth(localVehId))
    si(localVehId et localVehId ~= 0)puis
         localVehPlateTest = GetVehiculeNumberPlateText(localVehId)
        si localVehPlateTest ~= nil, puis
             localVehPlate = string.lower(localVehPlateTest)
            local LocalVehLockStatus = GetVehiculeDoorLockStatus(localVehId)
            local hasKey = false

            -- Si le véhicule apparaît dans la table (s’il s’agit du véhicule du joueur ou d’un véhicule verrouillé)
            pour la plaque, le véhicule par paires(véhicules) ne
                si(string.lower(plaque) == localVehPlate)puis
                    -- Si le véhicule n’est pas verrouillé (c’est le véhicule du joueur)
                    si(véhicule ~=  "verrouillé")alors
 hasKey = vrai
                        si(heure > minuterie),puis
                            -- mettre à jour les informations du véhicule (Utile pour les instances hydratantes créées par la commande /givekey)
 Véhicule. mise à jour(localVehId, localVehLockStatus)
                            -- Verrouiller ou déverrouiller le véhicule
 Véhicule. serrure()
 temps = 0
                        Autre
                            TriggerEvent("ls:notify", _U("lock_cooldown", (minuterie / 1000)))
                        Fin
                    Autre
                        TriggerEvent("ls:notify", _U("keys_not_inside» ))
                    Fin
                Fin
            Fin

            -- Si le joueur n’a pas les clés
            si(n’a pasKey) puis
                -- Si le joueur est à l’intérieur du véhicule
                si(est à l’écart)puis
                    -- Si le joueur trouve les clés
                    si(canSteal())alors
                        -- Vérifiez si le véhicule est déjà la propriété.
                        -- Et envoyez les paramètres pour créer l’objet du véhicule si ce n’est pas le cas.
                        TriggerServerEvent('ls:checkOwner', localVehId, localVehPlate, localVehLockStatus)
                    Autre
                        -- Si le joueur ne trouve pas les clés
                        -- Verrouiller le véhicule (les joueurs ne peuvent pas essayer de trouver les clés à nouveau)
 véhicules[localVehPlate] =  "verrouillé» 
                        TriggerServerEvent("ls:lockTheVehicule", localVehPlate)
                        TriggerEvent("ls:notify", _U("keys_not_inside» ))
                    Fin
                Fin
            Fin
        Autre
            TriggerEvent("ls:notify", _U("could_not_find_plate» ))
        Fin
    Fin
Fin)

---- Minuterie
Citoyen. CreateThread(fonction)()
 minuterie = Config. lockTimer * 1000
 temps = 0
	tandis que vrai faire
		Wait(1000)
 temps = temps + 1000
	Fin
Fin)

---- Empêche le joueur de casser la fenêtre si le véhicule est verrouillé
-- (correction d’un bogue dans la version précédente)
Citoyen. CreateThread(fonction)()
	tandis que vrai faire
		Attente(0)
		ped local = GetPlayerPed(-1)
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) puis
        	veh local = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
	        serrure locale = GetVehiculeDoorLockStatus(veh)
	        si le verrou == 4, puis
	        	ClearPedTasks(ped)
	        Fin
        Fin
	Fin
Fin)

---- Verrouille les véhicules si des personnages non jouables y sont
-- Peut être désactivé dans « config/shared.lua »
si(Config. disableCar_NPC)puis
 Citoyen. CreateThread(fonction)()
        tandis que vrai faire
            Attente(0)
            ped local = GetPlayerPed(-1)
            if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) puis
                veh local = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
                serrure locale = GetVehiculeDoorLockStatus(veh)
                si le verrou == 7, puis
                    SetVehiculeDoorsLocked(veh, 2)
                Fin
                pedd local = GetPedInVehicleSeat(veh, -1)
                si pedd alors
                    SetPedCanBeDraggedOut(pedd, false)
                Fin
            Fin
        Fin
    Fin)
Fin

-------------------------- ---------------------- EVENTS
------------------------     :)         ------------------------

---- Mettre à jour une plaque de véhicule (pour les développeurs)
-- @param chaîne oldPlate
-- @param chaîne newPlate
RegisterNetEvent("ls:updateVehiclePlate» )
AddEventHandler("ls:updateVehiclePlate", fonction(oldPlate, newPlate)
    local oldPlate = string.lower(oldPlate)
    local newPlate = string.lower(newPlate)

    si(véhicules[oldPlate])alors
 véhicules[newPlate] = véhicules[oldPlate]
 véhicules[oldPlate] = nil

        TriggerServerEvent("ls:updateServerVehiclePlate", oldPlate, newPlate)
    Fin
Fin)

---- Événement appelé à partir du serveur
-- Obtenez les clés et créez l’objet du véhicule si le véhicule n’a pas de propriétaire
-- @param boolean hasOwner
-- @param int localVehId
-- chaîne @param localVehPlate
-- @param int localVehLockStatus
RegisterNetEvent("ls:getHasOwner» )
AddEventHandler("ls:getHasOwner", fonction(hasOwner, localVehId, localVehPlate, localVehLockStatus)
    si(n’a pas Propriétaire)alors
        TriggerEvent("ls:newVehicule", localVehPlate, localVehId, localVehLockStatus)
        TriggerServerEvent("ls:addOwner« ,localVehPlate)

        TriggerEvent("ls:notify", getRandomMsg())
    Autre
        TriggerEvent("ls:notify", _U("vehicle_not_owned» ))
    Fin
Fin)

-- Test pour les clé en sortie de garage

RegisterNetEvent("ls:getHasOwner2» )
AddEventHandler("ls:getHasOwner2", fonction(hasOwner, localVehId, localVehPlate, localVehLockStatus)
    TriggerEvent("ls:newVehicule", localVehPlate, localVehId, localVehLockStatus)
    TriggerServerEvent("ls:addOwner« ,localVehPlate)
    TriggerEvent("ls:notify", getRandomMsg())
Fin)

---- Créer un nouvel objet de véhicule
-- @param int id [opt]
-- plaque de corde @param
-- @param lock stringStatus [opt]
RegisterNetEvent("ls:newVehicle» )
AddEventHandler("ls:newVehicle", fonction(plaque, id, lockStatus)
    si(plaque)puis
        plaque locale = string.lower(plaque)
        si(pas id)puis id = fin nulle
        si(pas lockStatus)puis lockStatus = fin nulle
 véhicules[plaque] = newVehicle()
 véhicules[plaque]. __construct(plaque, id, lockStatus)
    Autre
        imprimer( " Impossiblede créer l’instance du véhicule. Argument manquant PLATE» )
    Fin
Fin)

---- Événement appelé à partir du serveur lorsqu’un joueur exécute la commande /givekey
-- Créer un nouvel objet de véhicule avec sa plaque
-- plaque de corde @param
RegisterNetEvent("ls:giveKeys» )
AddEventHandler("ls:giveKeys", fonction(plaque)
    plaque locale = string.lower(plaque)
    TriggerEvent("ls:newVehicle« ,plaque, zéro, zéro)
Fin)

---- Morceau de code du script InteractSound de Scott : https://forum.fivem.net/t/release-play-custom-sounds-for-interactions/8282
-- J’ai décidé d’utiliser une seule partie de son script afin que les administrateurs n’ont pas à télécharger plus de scripts. J’espère que vous n’oublierez pas de le remercier!
RegisterNetEvent('InteractSound_CL:PlayWithinDistance' )
AddEventHandler('InteractSound_CL:PlayWithinNistance', fonction(playerNetId, maxNistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    eCoords locaux = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    distIs locaux = Vdist(lCoords. x, lCoords. y, lCoords. z, eCoords. x, eCoords. y, eCoords. z)
    si(distIs <= maxDistance) puis
        SendNUIMessage({
 transactionType =  'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    Fin
Fin)

RegisterNetEvent('ls:notify' )
AddEventHandler('ls:notify', fonction(texte, durée)
	Notify(texte, durée)
Fin)

------------------------ FONCTIONS ------------------------
------------------------        :O         ------------------------

---- Un algorithme simple qui vérifie si le joueur trouve les clés ou non.
-- @return booléen
fonction canSteal()
    nb = math.random(1, 100)
 pourcentage = Config. pourcentage
    si(nb < pourcentage)puis
        retour vrai
    Autre
        retourner false
    Fin
Fin

---- Renvoyer un message aléatoire
-- chaîne @return
fonction getRandomMsg()
 msgNb = math.random(1, #Config. randomMsg)
    retour Config. randomMsg[msgNb]
Fin

---- Mettre un véhicule en direction
-- @param tableau coordonneDe
-- @param tableau coordTo
-- @return nt
fonction GetVehicleInDirection(coordFrom, coordTo)
	rayHandle local = CastRayPointToPoint(coordFrom. x, coordDe. y, coordonneDe. z, coordTo. x, coordTo. y, coordTo. z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, véhicule = GetRaycastResult(rayHandle)
	véhicule de retour
Fin

---- Ez le véhicule devant le joueur
-- @param tableau pCoords
-- @param nt ply
-- @return nt
fonction GetTargetedVehicle(pCoords, pli)
    --pour i = 1, 200 ne
    pour _, i in ipairs(GetActivePlayers()) 
        coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, (6.281)/i, 0.0)
        targetedVehicle = GetVehicleInDirection(pCoords, coordB)
        si(targetedVehicle ~= nil et targetedVehicle ~= 0)alors
            retour cibléVéhicule
        Fin
    Fin
    Retour
Fin

---- Aviser le joueur
-- Peut être configuré dans « config/shared.lua »
-- @param texte de chaîne
-- @param durée du flotteur [opt]
fonction Notify(texte, durée)
	si(Config. notification)puis
		si(Config. notification == 1)puis
			si(pas la durée)alors
 durée = 0,080
			Fin
			SetNotificationTextEntry("STRING» )
			AddTextComponentString(texte)
 Citoyen. InvokeNative(0x1E6611149DB3DB6B,  "CHAR_PEGASUS_DELIVERY",  "CHAR_PEGASUS_DELIVERY« , true, 1,  "Système de clé« .   _VERSION,  "OriginalBigCityQc« ,durée)
			DrawNotification_4(faux, vrai)
		elsesif(Config. notification == 2)puis
			TriggerEvent('chatMessage',  '^1LockSystem V'  .. _VERSION, {255, 255, 255}, texte)
		Autre
			Retour
		Fin
	Autre
		Retour
	Fin
Fin
