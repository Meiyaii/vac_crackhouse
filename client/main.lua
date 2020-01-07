local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local isInWeed = false
local isInKokain = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Teleport in

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		if paVag then
			DisableControlAction(0, 38, true)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustReleased(0, Keys['E']) and isOutSideHouse then
			tpIn()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isOutSideHouse = false
		local currentZone = nil
		for i=1, #Config.DoorOutSide, 1 do
			if(GetDistanceBetweenCoords(coords, Config.DoorOutSide[i].x, Config.DoorOutSide[i].y, Config.DoorOutSide[i].z, true) < Config.DoorSize.x / 2) then
				isOutSideHouse = true
			end
		end
	end
end)

function tpIn()
	paVag = true
	TriggerEvent('vac_crackhouse:tpIn')
end

RegisterNetEvent('vac_crackhouse:tpIn')
AddEventHandler('vac_crackhouse:tpIn', function()
	while true do
		Citizen.Wait(5)

		ESX.ShowNotification('Du går in i huset.')
		Citizen.Wait(3000)
		DoScreenFadeOut(1000)
		Citizen.Wait(2000)
		SetEntityCoords(PlayerPedId(), 266.05, -1007.32, -102.01, 357.35)
		DoScreenFadeIn(1000)
		paVag = false
		break
	end
end)

-- Teleport Ut

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustReleased(0, Keys['E']) and isInSideHouse then
			tpUt()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isInSideHouse = false
		local currentZone = nil
		for i=1, #Config.DoorInSide, 1 do
			if(GetDistanceBetweenCoords(coords, Config.DoorInSide[i].x, Config.DoorInSide[i].y, Config.DoorInSide[i].z, true) < Config.DoorSize.x / 2) then
				isInSideHouse = true
			end
		end
	end
end)

function tpUt()
	paVag = true
	TriggerEvent('vac_crackhouse:tpUt')
end

RegisterNetEvent('vac_crackhouse:tpUt')
AddEventHandler('vac_crackhouse:tpUt', function()
	while true do
		Citizen.Wait(5)

		ESX.ShowNotification('Du går ut ur huset.')
		Citizen.Wait(3000)
		DoScreenFadeOut(1000)
		Citizen.Wait(2000)
		SetEntityCoords(PlayerPedId(), 1200.92, -575.62, 69.14, 132.95)
		DoScreenFadeIn(1000)
		paVag = false
		break
	end
end)

-- Weed

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustReleased(0, Keys['E']) and isInWeed then
			smokeWeed()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isInWeed = false
		local currentZone = nil
		for i=1, #Config.Weed, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Weed[i].x, Config.Weed[i].y, Config.Weed[i].z, true) < Config.WeedSize.x / 2) then
				isInWeed = true
			end
		end
	end
end)

function smokeWeed()
	smokesWeed = true
	TriggerEvent('vac_crackhouse:smokesWeed')
	ESX.ShowNotification('Röker en joint')
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if smokesWeed then
			DisableControlAction(0, 38, true)
		end
	end
end)

RegisterNetEvent('vac_crackhouse:smokesWeed')
AddEventHandler('vac_crackhouse:smokesWeed', function()

	local playerPed = GetPlayerPed(-1)

	 while smokesWeed do
		Citizen.Wait(1)

		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
		Citizen.Wait(Config.smokeTime)
		TriggerServerEvent('vac_crackhouse:weedEffect')
		ESX.ShowNotification('Du rökte nyss en joint')
		smokesWeed = false
		ClearPedTasksImmediately(playerPed)
	end
end)

-- Weed end -
-- Kokain

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustReleased(0, Keys['E']) and isInKokain then
			sniffKokain()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isInKokain = false
		local currentZone = nil
		for i=1, #Config.Kokain, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Kokain[i].x, Config.Kokain[i].y, Config.Kokain[i].z, true) < Config.KokainSize.x / 2) then
				isInKokain = true
			end
		end
	end
end)

function sniffKokain()
	sniffarKokain = true
	TriggerEvent('vac_crackhouse:sniffKokain')
	ESX.ShowNotification('Du sniffar 1g kokain')
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if sniffarKokain then
			DisableControlAction(0, 38, true)
		end
	end
end)

RegisterNetEvent('vac_crackhouse:sniffKokain')
AddEventHandler('vac_crackhouse:sniffKokain', function()

	local playerPed = GetPlayerPed(-1)

	 while sniffarKokain do
		Citizen.Wait(1)

		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
		Citizen.Wait(Config.sniffTime)
		TriggerServerEvent('vac_crackhouse:kokainEffect')
		ESX.ShowNotification('Du sniffade nyss 1g kokain')
		sniffarKokain = false
		ClearPedTasksImmediately(playerPed)
	end
end)
