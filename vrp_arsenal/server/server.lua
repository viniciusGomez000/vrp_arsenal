local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vhG = {}
Tunnel.bindInterface("vrp_arsenal",vhG)

--[ Give Weapon ]-----------------------------------------------------------------------------------------------------------------------------

function vhG.GetPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,'Policia') then
            return true
        else
            return false
        end
    end
end

function vhG.giveWeapon(weapon,ammo)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.giveInventoryItem(user_id,weapon,1,true)
        vRP.giveInventoryItem(user_id,ammo,200,true)
    end
end

function vhG.keepWeapon(weapon,ammo)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local weaponAmout = vRP.getInventoryItemAmount(user_id,weapon)
        local ammoAmout = vRP.getInventoryItemAmount(user_id,ammo)
        if weaponAmout ~= 0 then
            vRP.removeInventoryItem(user_id,weapon,weaponAmout,true)
        end
        if ammoAmout ~= 0 then
            vRP.removeInventoryItem(user_id,ammo,ammoAmout,true)
        end
    end
end