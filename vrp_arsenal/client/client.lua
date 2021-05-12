  
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

vhG = Tunnel.getInterface("vrp_arsenal")

--[ VARIAVEIS ]----------------------------------------------------------------------------------------------------------------------------

local onNui = false
local weapons = {
    { ['weapon'] = 'WEAPON_COMBATPISTOL', ['ammo'] = 'WEAPON_PISTOL_AMMO' },
    { ['weapon'] = 'WEAPON_PISTOL50', ['ammo'] = 'WEAPON_PISTOL_AMMO' },
    { ['weapon'] = 'WEAPON_SMG', ['ammo'] = 'WEAPON_SMG_AMMO' },
    { ['weapon'] = 'WEAPON_CARBINERIFLE', ['ammo'] = 'WEAPON_RIFLE_AMMO' },
    { ['weapon'] = 'WEAPON_SPECIALCARBINE', ['ammo'] = 'WEAPON_RIFLE_AMMO' },
    { ['weapon'] = 'WEAPON_PUMPSHOTGUN', ['ammo'] = 'WEAPON_SHOTGUN_AMMO' },
    { ['weapon'] = 'WEAPON_SAWNOFFSHOTGUN', ['ammo'] = 'WEAPON_SHOTGUN_AMMO' },
    { ['weapon'] = 'WEAPON_STUNGUN', ['ammo'] = '' },
    { ['weapon'] = 'WEAPON_STUNGUN', ['ammo'] = '' },
}
local locs = {
    vec3(452.38,-980.23,30.69),
    vec3(1848.51,3690.16,34.27),
    vec3(-448.33,6007.92,31.72)
}

--[ FUNCTION ]----------------------------------------------------------------------------------------------------------------------------

function ToggleActionNui()
    onNui = not onNui
    if onNui then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showMenu"
        })
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "hideMenu"
        })
    end
end

--[ NUICALLBACK ]----------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("addWeapon", function(data)
    TriggerEvent("Notify","sucesso","Você pegou esse armamento.", 3000)
    vhG.giveWeapon(data.weaponName, data.ammoName)
end)

RegisterNUICallback("removeWeapon", function(data)
    TriggerEvent("Notify","sucesso","Você guardou esse armamento.", 3000)
    RemoveWeaponFromPed(PlayerPedId(), data.weaponName)
    vhG.keepWeapon(data.weaponName, data.ammoName)
end)

RegisterNUICallback("Close", function()
    ToggleActionNui()
end)

RegisterNUICallback("keppAll", function()
    for k,v in pairs(weapons) do
        RemoveWeaponFromPed(PlayerPedId(), v.weapon)
        vhG.keepWeapon(v.weapon, v.ammo)
    end
end)

--[ OPEN ]----------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(locs) do
            local distance = #(coords - v)

            if distance <= 3 then
                idle = 5
                DrawText3D(v.x,v.y,v.z,"~w~ Pressione ~r~E~w~ para acessar o arsenal.")
                if IsControlJustPressed(1, 38) and distance <= 1.2 then
                    if vhG.GetPermission() then
                        ToggleActionNui()
                    else
                        TriggerEvent("Notify","aviso","Você não pode acessar o arsenal.", 3000)
                    end
                end
            end
        end
        Wait(idle)
    end
end)

--[ NO CRASH ]----------------------------------------------------------------------------------------------------------------------------

CreateThread(function()
	SetNuiFocus(false, false)
end)

function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.4,0.4)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 375) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end