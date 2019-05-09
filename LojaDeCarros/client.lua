function centerWindow ( center_window )
	local sx, sy = guiGetScreenSize ( )
	local windowW, windowH = guiGetSize ( center_window, false )
	local x, y = ( sx - windowW ) / 2, ( sy - windowH ) / 2
	guiSetPosition ( center_window, x, y, false )
end

local customCarNames = -- Ids dos veiculos pra add mais copie e cole um abaixo do outro e mude o nome
{
	[483] = 'Kombi';
	[542] = 'Passat';
	[565] = 'Veloster';
	[559] = 'Fusion';
	[560] = 'Civic';
    	[579] = 'Hilux';
    	[400] = 'GL 63';
    	[506] = 'Bmw i8';
    	[411] = 'Lamborghini Huracan';	
   	[415] = 'McLaren';	
    	[468] = 'XT660';
    	[586] = 'BMW R1200';		
}





setTimer ( function ()

local theCol = getElementData(root, "BlockExportCol")
	
function isInColExport ()
	if isElement(theCol) and isElementWithinColShape(localPlayer,theCol) then
		return true else return false
	end
end

function ClientExplosionCFunction()
 if isInColExport ()  then
  cancelEvent ()
 end
end
addEventHandler("onClientExplosion", root, ClientExplosionCFunction)

end , 1000, 1 )

local screX, screY = guiGetScreenSize()
 
Window_VS = guiCreateWindow(373, 219, 557, 303,"Gerenciado De Seus Carros",false)
guiSetAlpha(Window_VS, 0.88)
guiWindowSetSizable(Window_VS, false)
guiSetVisible(Window_VS, false)
centerWindow(Window_VS)
Grid_VS = guiCreateGridList(10, 28, 361, 235, false, Window_VS)
guiGridListSetSelectionMode(Grid_VS, 1)
guiGridListAddColumn(Grid_VS, "Modelo", 0.4)
guiGridListAddColumn(Grid_VS, "Valor", 0.3)
guiGridListAddColumn(Grid_VS, "HP Auto", 0.2)

Button_VS_sn_s = guiCreateStaticImage(381, 28, 166, 25, "images/button_standard.png", false, Window_VS)
Button_VS_sn_o = guiCreateStaticImage(381, 28, 166, 25, "images/button_mouse.png", false, Window_VS)
Button_VS_sn = guiCreateLabel(381, 28, 166, 25, "Spawnar", false, Window_VS)
guiSetFont(Button_VS_sn, "default-bold-small")
guiLabelSetColor(Button_VS_sn, 255, 255, 255)
guiLabelSetVerticalAlign(Button_VS_sn, "center")
guiLabelSetHorizontalAlign(Button_VS_sn, "center")
---remover abaixo
Button_VS_bp_s = guiCreateStaticImage(381, 63, 166, 25, "images/button_standard.png", false, Window_VS)
Button_VS_bp_o = guiCreateStaticImage(381, 63, 166, 25, "images/button_mouse.png", false, Window_VS)

Button_VS_bp = guiCreateLabel(381, 63, 166, 25, "Localizar/Deslocalizar", false, Window_VS)
guiSetFont(Button_VS_bp, "default-bold-small")
guiLabelSetColor(Button_VS_bp, 255, 255, 255)
guiLabelSetVerticalAlign(Button_VS_bp, "center")
guiLabelSetHorizontalAlign(Button_VS_bp, "center")

Button_VS_lk_s = guiCreateStaticImage(381, 168, 166, 25, "images/button_standard.png", false, Window_VS)
Button_VS_lk_o = guiCreateStaticImage(381, 168, 166, 25, "images/button_mouse.png", false, Window_VS)
Button_VS_lk = guiCreateLabel(381, 168, 166, 25, "Trancar - Destrancar", false, Window_VS)
guiSetFont(Button_VS_lk, "default-bold-small")
guiLabelSetColor(Button_VS_lk, 255, 255, 255)
guiLabelSetVerticalAlign(Button_VS_lk, "center")
guiLabelSetHorizontalAlign(Button_VS_lk, "center")

Button_VS_sl_s = guiCreateStaticImage(381, 203, 166, 25, "images/button_standard.png", false, Window_VS)
Button_VS_sl_o = guiCreateStaticImage(381, 203, 166, 25, "images/button_mouse.png", false, Window_VS)
Button_VS_sl = guiCreateLabel(381, 203, 166, 25, "Vender Veiculo", false, Window_VS)
guiSetFont(Button_VS_sl, "default-bold-small")
guiLabelSetColor(Button_VS_sl, 255, 255, 255)
guiLabelSetVerticalAlign(Button_VS_sl, "center")
guiLabelSetHorizontalAlign(Button_VS_sl, "center")

Button_VS_give_s = guiCreateStaticImage(381, 238, 166, 25, "images/button_standard.png", false, Window_VS)
Button_VS_give_o = guiCreateStaticImage(381, 238, 166, 25, "images/button_mouse.png", false, Window_VS)
Button_VS_give = guiCreateLabel(381, 238, 166, 25, "Vender Para Jogador", false, Window_VS)
guiSetFont(Button_VS_give, "default-bold-small")
guiLabelSetColor(Button_VS_give, 255, 255, 255)
guiLabelSetVerticalAlign(Button_VS_give, "center")
guiLabelSetHorizontalAlign(Button_VS_give, "center")

adLabel = guiCreateLabel(130, 269, 296, 24, "CIDADE OUSADA RP", false, Window_VS)  -------------- Nome do seu servidor
guiSetFont(adLabel, "default-bold-small")
guiLabelSetHorizontalAlign(adLabel, "center", false)
guiLabelSetVerticalAlign(adLabel, "center")  

guiSetVisible(Button_VS_sn_o,false)--


guiSetVisible(Button_VS_bp_o,false)
guiSetVisible(Button_VS_lk_o,false)
guiSetVisible(Button_VS_sl_o,false)
guiSetVisible(Button_VS_give_o,false)

--Button_VS_Warp_info
--Button_VS_Fix_info


Window_CHK = guiCreateWindow(screX/2-155,screY/2-60,310,120,"Vender Veiculo!",false)
guiSetVisible(Window_CHK, false)
guiSetProperty(Window_CHK, "AlwaysOnTop", "true")
guiWindowSetSizable(Window_CHK, false)
Label_CHK = guiCreateLabel(21,28,266,36,"",false,Window_CHK)
guiLabelSetColor(Label_CHK, 38, 122, 216)
guiLabelSetHorizontalAlign(Label_CHK,"center",true)
Button_CHK_Y = guiCreateButton(17,73,129,36,"Deseja Vender?",false,Window_CHK)
Button_CHK_N = guiCreateButton(161,73,129,36,"Cancelar",false,Window_CHK)

function updateGridList()
	local data = getElementData(localPlayer, "VehicleInfo")
	if data then
		local rw, cl = guiGridListGetSelectedItem(Grid_VS)
		guiGridListClear(Grid_VS)
		for i, data in ipairs (data) do
			local carName = customCarNames[ data['Model'] ] or getVehicleNameFromModel(data["Model"])
			local ID = data["ID"]
			local Cost = data["Cost"]
			local HP = math.floor(data["HP"])
			local PreCost = math.ceil(Cost*.9*HP/100/10)
			local row = guiGridListAddRow(Grid_VS)
			guiGridListSetItemText(Grid_VS, row, 1, carName, false, true)
			guiGridListSetItemData(Grid_VS, row, 1, ID)
			guiGridListSetItemText(Grid_VS, row, 2, PreCost, false, true)
			guiGridListSetItemText(Grid_VS, row, 3, HP.." HP", false, true)
		end
		guiGridListSetSelectedItem(Grid_VS, rw, cl)
	end
end



bindKey("F7", "down",
function()
if getElementInterior(localPlayer) == 0 and getElementDimension(localPlayer) == 0 then
if getElementData(localPlayer, "MissionWarProtection") and getElementData(localPlayer, "MissionProtection")then return end
    guiSetVisible(Window_VS, not guiGetVisible(Window_VS))
	guiSetVisible (Window_CHK, false)
	showCursor(guiGetVisible(Window_VS))
	end
end)

triggerServerEvent("onOpenGui", localPlayer)

addEventHandler("onClientElementDataChange", root,
function(dd)
	if getElementType(source) == "player" and source == localPlayer and dd == "VehicleInfo" then
		local data = getElementData(source, dd)
		if data then
			updateGridList()
		end
	end
end)

function WINDOW_CLICK_VEHICLE (button, state, absoluteX, absoluteY)
	local id = guiGridListGetSelectedItem(Grid_VS)
	local ID = guiGridListGetItemData(Grid_VS, id, 1)
	if source == Button_VS_close then
		guiSetVisible(Window_VS, false)
		showCursor(false)
	end
	if (source == Grid_VS) then
		if id == -1 and idd then
			guiGridListSetSelectedItem(Grid_VS, idd, 1)
			return false
		else
			idd = guiGridListGetSelectedItem(Grid_VS)
		end
	elseif id == -1 then
	elseif (source == Button_VS_sn) then
	if not isInColExport () then
		triggerServerEvent("SpawnMyVehicle", localPlayer, ID)
                end
	elseif (source == Button_VS_lt) then 
		triggerServerEvent("LightsMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_bp) then 
		triggerServerEvent("BlipMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_lk) then 
		triggerServerEvent("LockMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_sl) then 
		guiSetVisible(Window_CHK, true)
		local carName = guiGridListGetItemText(Grid_VS, guiGridListGetSelectedItem(Grid_VS), 1)
		local carprice = guiGridListGetItemText(Grid_VS, guiGridListGetSelectedItem(Grid_VS), 2)
		guiSetText(Label_CHK, 'Você deseja realmente vender seu "'..carName..'" por $'..carprice)
	elseif source == Button_VS_give then
		createPlayersList(id)
	elseif source == Button_CHK_Y then
		triggerServerEvent("SellMyVehicle", localPlayer, ID)
		guiSetVisible(Window_VS, false)
		guiSetVisible(Window_CHK, false)
		showCursor(false)
	elseif source == Button_CHK_N then
		guiSetVisible (Window_CHK, false)
	elseif source == Button_VS_Spc then
      if getElementInterior(localPlayer) == 0 then
if getElementData(localPlayer,"Stats") < 2 then
		SpecVehicle(ID)
end
end
	elseif source == Button_VS_Fix then
		triggerServerEvent("FixMyVehicle", localPlayer, ID)
	elseif source == Button_VS_Warp then
	       if not isInColExport () then
		triggerServerEvent("WarpMyVehicle", localPlayer, ID)
                      end
	elseif source == Button_PLS_Y then
		local row = guiGridListGetSelectedItem ( playerList_PLS )
		if row and row ~= -1 then
			-- if guiGridListGetItemText ( playerList_PLS, row, 1 ) == getPlayerName ( localPlayer ) then
				-- return true
			-- end
			if (tonumber(guiGetText (edit_PLS_price)) or 0) >= 0 then
				outputMessage ( "#c1c1c1Esperar uma resposta do jogador.", 10, 250, 10,true )
				invitations_send = true
				triggerServerEvent ( 'inviteToBuyCarSended', localPlayer, guiGridListGetItemText ( playerList_PLS, row, 1 ), guiGetText (edit_PLS_price) or 0, guiGridListGetItemText(Grid_VS, id, 1), guiGridListGetItemData(Grid_VS, id, 1) )
				destroyElement ( Window_PLS )
			end
		end
	elseif source == Button_PLS_N then
		destroyElement ( Window_PLS)
	end
end
addEventHandler("onClientGUIClick", resourceRoot, WINDOW_CLICK_VEHICLE)

function invitationsClickVehicle ()
	if source == Button_ABC_Y then
		showCursor ( false )
		destroyElement ( Window_ABC )
		if getPlayerMoney () >= ( tonumber(inv_price) or 0 ) then
			triggerServerEvent ("invitationBuyCarAccepted",localPlayer, inv_player, inv_acc, inv_price, inv_veh_name, inv_veh_id)
		else
			triggerServerEvent ("invitationBuyCarNotAccepted",localPlayer, inv_player )
		end
		if #listOfInvitations > 0 then
			createAcceptBuyCarWindow (listOfInvitations[1][1],listOfInvitations[1][2],listOfInvitations[1][3],listOfInvitations[1][4] )
			table.remove (listOfInvitations,1)
		end
	elseif source == Button_ABC_N then
		showCursor ( false )
		triggerServerEvent ("invitationBuyCarNotAccepted",localPlayer, inv_player )
		destroyElement ( Window_ABC )
		if #listOfInvitations > 0 then
			createAcceptBuyCarWindow (listOfInvitations[1][1],listOfInvitations[1][2],listOfInvitations[1][3],listOfInvitations[1][4] )
			table.remove (listOfInvitations,1)
		end
	end
end

addEventHandler("onClientGUIClick", resourceRoot, invitationsClickVehicle)

function createPlayersList (row_id)
	showCursor ( true )
	Window_PLS = guiCreateWindow(screX/2-155,screY/2-220,310,420,"Venda de carros!",false)
	guiSetVisible(Window_PLS, true)
	guiSetProperty(Window_PLS, "AlwaysOnTop", "true")
	guiWindowSetSizable(Window_PLS, false)
	Label_PLS_info = guiCreateLabel(21,28,266,36,"Digite o preço dos carros:",false,Window_PLS)
	edit_PLS_price = guiCreateEdit ( 110,58,90,36, guiGridListGetItemText(Grid_VS, row_id, 2) or 0, false, Window_PLS )
	guiLabelSetColor(Label_PLS_info, 38, 122, 216)
	guiLabelSetHorizontalAlign(Label_PLS_info,"center",true)
	Button_PLS_Y = guiCreateButton(17,379,129,36,"Vender",false,Window_PLS)
	Button_PLS_N = guiCreateButton(161,379,129,36,"Fechar",false,Window_PLS)
	addEventHandler("onClientGUIChanged", edit_PLS_price, function(element) 
		guiSetText ( edit_PLS_price, string.gsub (guiGetText( edit_PLS_price ), "%a", "") )
	end)
	playerList_PLS = guiCreateGridList ( 21, 100, 268, 265, false, Window_PLS )
	local column = guiGridListAddColumn( playerList_PLS, "Jogadores", 0.85 )
	if ( column ) then
		for id, player in ipairs(getElementsByType("player")) do
			local row = guiGridListAddRow ( playerList_PLS )
			guiGridListSetItemText ( playerList_PLS, row, column, getPlayerName ( player ), false, false )
		end
	end

end

--createPlayersList ()

listOfInvitations = {}
inv_player, inv_acc, inv_price, inv_veh_name, inv_veh_id = nil, nil, nil, nil, nil


addEvent("recieveInviteToBuyCar", true)
addEventHandler("recieveInviteToBuyCar", root, 
function(player, acc, price, veh_name, veh_id)
	if player and price and acc and veh_name and veh_id then
		if getPlayerFromName ( player ) then
			if not isElement ( Window_ABC ) then
				createAcceptBuyCarWindow (player,acc,price, veh_name, veh_id)
			else	
				table.insert ( listOfInvitations, {player,acc,price, veh_name, veh_id})
			end
		else
			outputMessage ( "#c1c1c1Jogador não pode ser encontrado", source, 250, 10, 10,true)
		end
	end
end)

addEvent("cleanCarInvitations", true)
addEventHandler("cleanCarInvitations", root, 
function()
	invitations_send = false
end)

function createAcceptBuyCarWindow(player,acc,price, veh_name, veh_id)
	showCursor ( true )
	inv_player, inv_acc, inv_price, inv_veh_name, inv_veh_id = player,acc,price, veh_name, veh_id
	Window_ABC = guiCreateWindow(screX/2-155,screY/2-220,410,100,"Venda de carros",false)
	guiSetVisible(Window_ABC, true)
	guiSetProperty(Window_ABC, "AlwaysOnTop", "true")
	guiWindowSetSizable(Window_ABC, false)
	Label_ABC_info = guiCreateLabel(10,28,390,36,player.." Te ofereceu o "..veh_name.." por "..price.."$ (o seu dinheiro: "..getPlayerMoney() .."$)",false,Window_ABC)
	guiLabelSetColor(Label_ABC_info, 38, 216, 38)
	guiLabelSetHorizontalAlign(Label_ABC_info,"center",true)
	Button_ABC_Y = guiCreateButton(17,70,129,36,"Comprar",false,Window_ABC)
	Button_ABC_N = guiCreateButton(264,70,129,36,"Cancelar",false,Window_ABC)
end

function SpecVehicle(id)

	if spc then 
		removeEventHandler("onClientPreRender", root, Sp)
		setCameraTarget(localPlayer)
		if isTimer(freezTimer) then killTimer(freezTimer) end
		freezTimer = setTimer(function() setElementFrozen(localPlayer, false) end, 2500, 1)
		spc = false
	return end
	for i, vehicle in ipairs(getElementsByType("vehicle")) do
		if getElementData(vehicle, "Owner") == localPlayer and getElementData(vehicle, "ID") == id then
			cVeh = vehicle
			spc = true
			addEventHandler("onClientPreRender", root, Sp)
			guiSetVisible(Window_VS, false)
			showCursor(false)
			break
		  end
                        
	end
end

function Sp()
	if isElement(cVeh) then
		local x, y, z = getElementPosition(cVeh)
		setElementFrozen(localPlayer, true)
		setCameraMatrix(x, y-1, z+15, x, y, z)

	else
		removeEventHandler("onClientPreRender", root, Sp)
		setCameraTarget(localPlayer)
		if isTimer(freezTimer) then killTimer(freezTimer) end
		freezTimer = setTimer(function() setElementFrozen(localPlayer, false) end, 2500, 1)
		spc = false
      end
end

ShopMarkersTable = {}	

local ShopTable = {   --------- Ids de cada um na sua loja do mesmo jeito que adicionou la encima bote aqui e mude os preços tambem
	[1] = {ID = {{483, 3000}
		,{542, 7000}
		,{565, 45000}
		,{559, 53000}
		,{560, 67000}
		,{579, 120000}
		,{400, 359000}
		,{506, 650000}
		,{411, 2100000}
		,{415, 3000000}
		,{468, 25000}
		,{586, 35000}		
		}, vPosX = 2134, vPosY = -1170, vPosZ = 28.15, PosX = 2133, PosY = -1149, PosZ = 23.4, CamX = 2134.1, CamY = -1160, CamZ = 35, lookAtX = 2133.3, lookAtY = -1168, lookAtZ = 28},
	[2] = {ID = {{483, 3000}
		,{542, 7000}
		,{565, 45000}
		,{559, 53000}
		,{560, 67000}
		,{579, 120000}
		,{400, 359000}
		,{506, 650000}
		,{411, 2100000}
		,{415, 3000000}
		,{468, 25000}
		,{586, 35000}	
		}, vPosX = 552, vPosY = -1288, vPosZ = 18, PosX = 562, PosY = -1270, PosZ = 16, CamX = 552, CamY = -1275.82, CamZ = 21.61, lookAtX = 552, lookAtY = -1276.77, lookAtZ = 21.29},
	[3] = {ID = {{483, 3000}
		,{542, 7000}
		,{565, 45000}
		,{559, 53000}
		,{560, 67000}
		,{579, 120000}
		,{400, 359000}
		,{506, 650000}
		,{411, 2100000}
		,{415, 3000000}
		,{468, 25000}
		,{586, 35000}
		}, vPosX = 1942.5, vPosY = 2052, vPosZ = 11, PosX = 1946, PosY = 2068, PosZ = 10, CamX = 1930.36, CamY = 2052.78, CamZ = 14.71, lookAtX = 1931.36, lookAtY = 2052.78, lookAtZ = 14.43},
	[4] = {ID = {{483, 3000}
		,{542, 7000}
		,{565, 45000}
		,{559, 53000}
		,{560, 67000}
		,{579, 120000}
		,{400, 359000}
		,{506, 650000}
		,{411, 2100000}
		,{415, 3000000}
		,{468, 25000}
		,{586, 35000}	
		}, vPosX = -1950, vPosY = 266, vPosZ = 36.2, PosX = -1954, PosY = 299, PosZ = 34, CamX = -1960.18, CamY = 266.06, CamZ = 37.94, lookAtX = -1959.2, lookAtY = 266.06, lookAtZ = 37.73},
	[5] = {ID = {{483, 3000}
		,{542, 7000}
		,{565, 45000}
		,{559, 53000}
		,{560, 67000}
		,{579, 120000}
		,{400, 359000}
		,{506, 650000}
		,{411, 2100000}
		,{415, 3000000}
		,{468, 25000}
		,{586, 35000}
		}, vPosX = -1660, vPosY = 1213, vPosZ = 7, PosX = -1634, PosY = 1199, PosZ = 6, CamX = -1648.9, CamY = 1212.27, CamZ = 10.16, lookAtX = -1649.88, lookAtY = 1212.27, lookAtZ = 9.94}
}

VehicleShop_Window = guiCreateWindow(screX-350,screY-450, 343, 436, "Shop de Veiculos", false)
guiSetVisible(VehicleShop_Window, false)
guiWindowSetSizable(VehicleShop_Window , false)
guiSetAlpha(VehicleShop_Window, 0.8)
carGrid = guiCreateGridList(9, 20, 324, 329, false, VehicleShop_Window)
guiGridListSetSelectionMode(carGrid, 0)
carColumn = guiGridListAddColumn(carGrid, "Nome", 0.5)
costColumn = guiGridListAddColumn(carGrid, "Preço", 0.4)


carButton_s = guiCreateStaticImage(14, 355, 86, 56, "images/button_standard.png", false, VehicleShop_Window)
carButton_o = guiCreateStaticImage(14, 355, 86, 56, "images/button_mouse.png", false, VehicleShop_Window)

carButton = guiCreateLabel(14, 355, 86, 56, "Comprar", false, VehicleShop_Window)
guiSetFont(carButton, "default-bold-small")
guiLabelSetColor(carButton, 255, 255, 255)
guiLabelSetVerticalAlign(carButton, "center")
guiLabelSetHorizontalAlign(carButton, "center")




carColorButton_s = guiCreateStaticImage(128, 355, 86, 56, "images/button_standard.png", false, VehicleShop_Window)
carColorButton_o = guiCreateStaticImage(128, 355, 86, 56, "images/button_mouse.png", false, VehicleShop_Window)

carColorButton = guiCreateLabel(128, 355, 86, 56, "Pintar", false, VehicleShop_Window)
guiSetFont(carColorButton, "default-bold-small")
guiLabelSetColor(carColorButton, 255, 255, 255)
guiLabelSetVerticalAlign(carColorButton, "center")
guiLabelSetHorizontalAlign(carColorButton, "center")


closeButton_s = guiCreateStaticImage(237, 355, 86, 56, "images/button_standard.png", false, VehicleShop_Window)
closeButton_o = guiCreateStaticImage(237, 355, 86, 56, "images/button_mouse.png", false, VehicleShop_Window)

closeButton = guiCreateLabel(237, 355, 86, 56, "Sair", false, VehicleShop_Window)
guiSetFont(closeButton, "default-bold-small")
guiLabelSetColor(closeButton, 255, 255, 255)
guiLabelSetVerticalAlign(closeButton, "center")
guiLabelSetHorizontalAlign(closeButton, "center")




guiSetVisible(carButton_o,false)
guiSetVisible(closeButton_o,false)
guiSetVisible(carColorButton_o,false)


addEventHandler( "onClientMouseLeave", root, 
function()
	if source == Button_VS_sn then
		guiSetVisible(Button_VS_sn_s,true)
		guiSetVisible(Button_VS_sn_o,false)
	elseif source == Button_VS_dy then
		guiSetVisible(Button_VS_dy_s,true)
		guiSetVisible(Button_VS_dy_o,false)
	elseif(source == Button_VS_bp) then
		guiSetVisible(Button_VS_bp_o,false)
	elseif source == Button_VS_Warp then
		guiSetVisible(Button_VS_Warp_s,true)
		guiSetVisible(Button_VS_Warp_o,false)
		guiSetVisible(Button_VS_Warp_info,false)
	elseif source == Button_VS_Fix then
		guiSetVisible(Button_VS_Fix_s,true)--Button_VS_Fix_info
		guiSetVisible(Button_VS_Fix_o,false)
		guiSetVisible(Button_VS_Fix_info,false)
	elseif source == Button_VS_lk then
		guiSetVisible(Button_VS_lk_s,true)
		guiSetVisible(Button_VS_lk_o,false)
	elseif source == Button_VS_sl then
		guiSetVisible(Button_VS_sl_s,true)
		guiSetVisible(Button_VS_sl_o,false)
	elseif source == Button_VS_give then
		guiSetVisible(Button_VS_give_s,true)
		guiSetVisible(Button_VS_give_o,false)

	elseif source == carButton then
		guiSetVisible(carButton_s,true)
		guiSetVisible(carButton_o,false)
	elseif source == closeButton then
		guiSetVisible(closeButton_s,true)
		guiSetVisible(closeButton_o,false)
	elseif source == carColorButton then
		guiSetVisible(carColorButton_s,true)
		guiSetVisible(carColorButton_o,false)
	end
end)

addEventHandler( "onClientMouseEnter", root, 
function()
	if source == Button_VS_sn then
		guiSetVisible(Button_VS_sn_s,false)
		guiSetVisible(Button_VS_sn_o,true)
	elseif source == Button_VS_dy then
		guiSetVisible(Button_VS_dy_s,false)
		guiSetVisible(Button_VS_dy_o,true)
	elseif(source == Button_VS_bp) then
	guiSetVisible(Button_VS_bp_o,true)
	elseif source == Button_VS_Warp then
		guiSetVisible(Button_VS_Warp_s,false)
		guiSetVisible(Button_VS_Warp_o,true)
		guiSetVisible(Button_VS_Warp_info,true)
	elseif source == Button_VS_Fix then
		guiSetVisible(Button_VS_Fix_s,false)--Button_VS_Fix_info
		guiSetVisible(Button_VS_Fix_o,true)
		guiSetVisible(Button_VS_Fix_info,true)
	elseif source == Button_VS_lk then
		guiSetVisible(Button_VS_lk_s,false)
		guiSetVisible(Button_VS_lk_o,true)
	elseif source == Button_VS_sl then
		guiSetVisible(Button_VS_sl_s,false)
		guiSetVisible(Button_VS_sl_o,true)
	elseif source == Button_VS_give then
		guiSetVisible(Button_VS_give_s,false)
		guiSetVisible(Button_VS_give_o,true)
	elseif source == Button_VS_give then
		guiSetVisible(Button_VS_give_s,false)
		guiSetVisible(Button_VS_give_o,true)

	elseif source == carButton then
		guiSetVisible(carButton_s,false)
		guiSetVisible(carButton_o,true)
	elseif source == closeButton then
		guiSetVisible(closeButton_s,false)
		guiSetVisible(closeButton_o,true)
	elseif source == carColorButton then
		guiSetVisible(carColorButton_s,false)
		guiSetVisible(carColorButton_o,true)
	end
end)



for i, M in ipairs(ShopTable) do
	ShopMarker = createMarker(M["PosX"], M["PosY"], M["PosZ"], "cylinder", 2, 38, 122, 216)
	ShopMarkerShader = createMarker(M["PosX"], M["PosY"], M["PosZ"], "cylinder", 2, 38, 122, 216)
	ShopMarkersTable[ShopMarker] = true
	setElementData ( ShopMarker, "shopID", i )
	setElementID(ShopMarker, tostring(i))
	createBlipAttachedTo(ShopMarker, 55, 2, 255, 255, 255, 255, 0, 400)
end

function getVehicleModelFromNewName (name)
	for i,v in pairs ( customCarNames ) do
		if v == name then
			return i
		end
	end
	return false
end

addEventHandler("onClientGUIClick", resourceRoot,
function()
	if (source == carGrid) then
		local carName = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 1)
		local carprice = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 2)
		if guiGridListGetSelectedItem(carGrid) ~= -1 then
			guiSetText(CarName, carName)
			guiSetText(CarPrice, "$"..carprice)
			local carID = getVehicleModelFromNewName(carName) or getVehicleModelFromName(carName)
			if isElement(veh) then
				setElementModel(veh, carID)
			return end
			veh = createVehicle(carID, ShopTable[i]["vPosX"], ShopTable[i]["vPosY"], ShopTable[i]["vPosZ"])
			setVehicleDamageProof(veh, true)
			setElementFrozen(veh, true)
			setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
			timer = setTimer(function() local x, y, z = getElementRotation(veh) setElementRotation(veh, x, y, z+3) end, 50, 0)
		else
			guiSetText(CarName, "Noun")
			guiSetText(CarPrice, "Noun")
			r1, g1, b1, r2, g2, b2 = math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
		elseif (source == carColorButton) then
		openColorPicker()
	elseif (source == carButton) then
		if guiGridListGetSelectedItem(carGrid) then
			local carName = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 1)
			local carID = getVehicleModelFromNewName(carName) or getVehicleModelFromName(carName)
			local carCost = guiGridListGetItemText (carGrid, guiGridListGetSelectedItem(carGrid), 2)
			local r1, g1, b1, r2, g2, b2 = getVehicleColor(veh, true)
			triggerServerEvent("onBuyNewVehicle", localPlayer, carID, carCost, r1, g1, b1, r2, g2, b2)
			outputMessage("#c1c1c1Você acabou de comprar um: #00FF66"..carName, 38, 122, 216, true)
			guiSetVisible(VehicleShop_Window, false)
			showCursor(false)
			setElementFrozen(localPlayer, false)
			fadeCamera(false, 1.0)
			setTimer(function() fadeCamera(true, 0.5) setCameraTarget(localPlayer) end, 1000, 1)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
	elseif (source == closeButton) then
		if guiGetVisible(VehicleShop_Window) then 
			guiSetVisible(VehicleShop_Window, false)
			showCursor(false)
			setElementFrozen(localPlayer, false)
			fadeCamera(false, 1.0)
			setElementData ( localPlayer, "atVehShop", false)
			setTimer(function() fadeCamera(true, 0.5) setCameraTarget(localPlayer) end, 1000, 1)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
	end
end)

function openColorPicker()
	if (colorPicker.isSelectOpen) or not isElement(veh) then return end
	colorPicker.openSelect(colors)
end

function closedColorPicker()
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if (veh and isElement(veh)) then
		r1, g1, b1, r2, g2, b2 = getVehicleColor(veh, true)
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2, g2, b2 = r, g, b
		end
		setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
	end
end
addEventHandler("onClientRender", root, updateColor)

--[[addCommandHandler("xx", function()
	local x, y, z, lx, ly, lz = getCameraMatrix()
	setCameraMatrix(x, y, z, lx, ly, lz)
	outputChatBox(x..", "..y..", "..z..", "..lx..", "..ly..", "..z)
end)]]

addEventHandler("onClientMarkerHit", resourceRoot,
function(player)
	if getElementType(player) ~= "player" or player ~= localPlayer or isPedInVehicle(player) then return end
	if ShopMarkersTable[source] then
		i = tonumber(getElementID(source))
		guiGridListClear(carGrid)
		for i, v in ipairs(ShopTable[i]["ID"]) do
			local carName = customCarNames[ v[1] ] or getVehicleNameFromModel(v[1])
			local row = guiGridListAddRow(carGrid)
			guiGridListSetItemText(carGrid, row, 1, carName, false, true)
			guiGridListSetItemText(carGrid, row, 2, tostring(v[2]), false, true)
		end
		setCameraMatrix(ShopTable[i]["CamX"], ShopTable[i]["CamY"], ShopTable[i]["CamZ"], ShopTable[i]["lookAtX"], ShopTable[i]["lookAtY"], ShopTable[i]["lookAtZ"])
		guiSetVisible(VehicleShop_Window, true)
		showCursor(true)
		setElementData ( player, "atVehShop", getElementData ( source, "shopID"))
		guiGridListSetSelectedItem(carGrid, 0, 1)
		setTimer(function()
			setElementFrozen(localPlayer, true)
			local carName = guiGridListGetItemText(carGrid, 0, 1)
			local carID = getVehicleModelFromNewName(carName) or getVehicleModelFromName(carName)
			local x, y, z = ShopTable[i]["vPosX"], ShopTable[i]["vPosY"], ShopTable[i]["vPosZ"]
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
			r1, g1, b1, r2, g2, b2 = math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255)
			veh = createVehicle(carID, x, y, z)
			setVehicleDamageProof(veh, true)
			setElementFrozen(veh, true)
			setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
			timer = setTimer(function() local x, y, z = getElementRotation(veh) setElementRotation(veh, x, y, z+3) end, 50, 0)
		end, 100, 1)
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	local x2, y2, z2 = getElementPosition(localPlayer)
	for index, car in pairs(getElementsByType('vehicle')) do
		if(getElementData(car,'ownercar')) then
			local x, y, z = getElementPosition(car)
			z = z+1
			local sx, sy = getScreenFromWorldPosition(x, y, z)
			if(sx) and (sy) then
				local distance = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
				if(distance < 20) then
					local fontbig = 2-(distance/10)
					local owner = getElementData(car, "ownercar")
					
					if(owner) then
	
					end
				end
			end
		end
	end
	
	for i, v in ipairs ( ShopTable ) do
		local sx, sy = getScreenFromWorldPosition(v.PosX, v.PosY, v.PosZ+1)
		if(sx) and (sy) then
			local distance = getDistanceBetweenPoints3D ( x2, y2, z2,v.PosX, v.PosY, v.PosZ ) 
			if distance < 30 then
				local fontbig = 3-(distance/10)
				--dxDrawBorderedCarText("", sx, sy, sx, sy, tocolor(212, 179, 17, 200), fontbig, "default-bold", "center")	
			end
		end
	end

end)

function dxDrawBorderedCarText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end


function outputMessage (text, r, g, b)
	return exports["scr-Lib"]:outputMessage(text, r, g, b);
end
