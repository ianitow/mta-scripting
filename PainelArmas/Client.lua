-- #############################
-- ## Weapons Transfer System ##
-- ## By : |Mr|-Talal07-|     ##
-- ## Side : Client           ##
-- #############################

local KEY = "F10" -- Hot Key

-- ## Important Functions

function centerWindow(center_window) -- https://wiki.multitheftauto.com/wiki/CenterWindow
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

function getPedWeapons(ped) -- https://wiki.multitheftauto.com/wiki/GetPedWeapons
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=2,9 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end

-- ## Main Window ##

wnd = guiCreateWindow(202,74,427,458,"--REVOLUTION ARMAS--",false)
players_grid = guiCreateGridList(0.0211,0.0546,0.4707,0.9258,true,wnd)
guiGridListSetSelectionMode(players_grid,1)
guiGridListAddColumn(players_grid,"Jogadores:",0.9)
weapons_grid = guiCreateGridList(0.5035,0.0546,0.4707,0.5415,true,wnd)
guiGridListSetSelectionMode(weapons_grid,1)
guiGridListAddColumn(weapons_grid,"Arma",0.6)
guiGridListAddColumn(weapons_grid,"Muni��o",0.3)
info = guiCreateLabel(0.5012,0.6092,0.4707,0.0699,"Munição para enviar",true,wnd)
guiLabelSetColor(info,0,255,0)
guiLabelSetVerticalAlign(info,"center")
guiLabelSetHorizontalAlign(info,"center",false)
guiSetFont(info,"default-bold-small")
ammo = guiCreateEdit(0.5035,0.679,0.4731,0.0852,"",true,wnd)
send = guiCreateButton(0.5035,0.7838,0.4731,0.0895,"Enviar Arma",true,wnd)
guiSetFont(send,"default-bold-small")
close = guiCreateButton(0.5035,0.8843,0.4731,0.0895,"Sair",true,wnd)
guiSetFont(close,"default-bold-small")
guiSetVisible(wnd,false)
centerWindow(wnd)

bindKey(KEY,"down",
	function ()
		if guiGetVisible(wnd) then
			guiSetVisible(wnd,false)
			showCursor(false)
			guiSetInputEnabled(false)
		else
			guiSetVisible(wnd,true)
			showCursor(true)
			guiSetInputEnabled(true)
			putPlayers()
			putWeapons()
		end
	end
)

function putPlayers()
	guiGridListClear(players_grid)
	for _,player in ipairs(getElementsByType("player")) do
		local row = guiGridListAddRow(players_grid)
		guiGridListSetItemText(players_grid,row,1,getPlayerName(player),false,false)
	end
end

function putWeapons()
	guiGridListClear(weapons_grid)
	for _,weapon in ipairs(getPedWeapons(localPlayer)) do
		if getPedTotalAmmo(localPlayer,getSlotFromWeapon(weapon)) > 0 then
			local row = guiGridListAddRow(weapons_grid)
			guiGridListSetItemText(weapons_grid,row,1,getWeaponNameFromID(weapon),false,false)
			guiGridListSetItemText(weapons_grid,row,2,getPedTotalAmmo(localPlayer,getSlotFromWeapon(weapon)),false,false)
		end
	end
end

function RefreshLists()
	putPlayers()
	putWeapons()
end

addEventHandler("onClientGUIClick",close,
	function ()
		guiSetVisible(wnd,false)
		showCursor(false)
		guiSetInputEnabled(false)
	end
,false)

addEventHandler("onClientGUIClick",send,
	function ()
		local sel_1 = guiGridListGetSelectedItem(players_grid)
		local sel_2 = guiGridListGetSelectedItem(weapons_grid)
		if sel_1 ~= -1 and sel_2 ~= -1 then
			local PlayerName = guiGridListGetItemText(players_grid,sel_1,1)
			local player = getPlayerFromName(PlayerName)
			if isElement(player) then
				if player ~= localPlayer then
					local WeaponName = guiGridListGetItemText(weapons_grid,sel_2,1)
					local WeaponAmmo = guiGridListGetItemText(weapons_grid,sel_2,2)
					local WeaponID = getWeaponIDFromName(WeaponName)
					local Ammo = guiGetText(ammo)
					if tonumber(Ammo) and tonumber(Ammo) >= 10 then
						if tonumber(WeaponAmmo) >= tonumber(Ammo) then
							setTimer(RefreshLists,500,1)
							triggerServerEvent("SendWeapon",localPlayer,player,WeaponID,Ammo)
						else
							outputChatBox("#0000FF[REVOLUTION]#FF0000Você não tem munição!",255,0,0,true)
						end
					else
						
						outputChatBox("#0000FF[REVOLUTION]#FF0000 Escreva um número e sendo maior que 10.",255,0,0,true)
					end
				else
					outputChatBox("#0000FF[REVOLUTION]#FF0000Erro desconhecido!",255,0,0,true)
				end
			else
				RefreshLists()
				outputChatBox("#0000FF[REVOLUTION]#FF0000Erro, jogador não encontrado!",255,0,0,true)
			end
		end
	end
)

fileDelete("Client.lua")