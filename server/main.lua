TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vac_crackhouse:weedEffect')
AddEventHandler('vac_crackhouse:weedEffect', function()
    TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
end)

RegisterServerEvent('vac_crackhouse:kokainEffect')
AddEventHandler('vac_crackhouse:kokainEffect', function()
    TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
end)
