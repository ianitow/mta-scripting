customCarNames = -- новые названия
{
	
}

local ianitoVar = "ianit-dev.unbug"

shopsVehSpawns = {
	[1] = { 2131, -1133, 25.6, 0,0,359 },
	[2] = { 555, -1278, 18, 0,0,100 },
	[3] = { 1941, 2097, 10.8, 0,0,350 },
	[4] = { -1988, 272, 36, 0,0,259 },
	[5] = { -1642, 1213, 7.17, 0,0, 227 },
}

function getFreeID()
	local result = dbPoll(dbQuery(db, "SELECT ID FROM VehicleList ORDER BY ID ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["ID"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function getVehicleByID(id)
	v = false
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "ID") == id then
			v = veh
			break
		end
	end
	return v
end

function updateVehicleInfo(player)
	if isElement(player) then
		local result = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(player))), -1)
		if type(result) == "table" then
			setElementData(player, "VehicleInfo", result)
		end
	end
end

addEventHandler("onResourceStart", resourceRoot,
function()
	db = dbConnect("sqlite", "database.db")
	dbExec(db, "CREATE TABLE IF NOT EXISTS VehicleList (ID, Account, Model, X, Y, Z, RotZ, Colors, Upgrades, Paintjob, Cost, HP, new_hydr)")
	for i, player in ipairs(getElementsByType("player")) do
		updateVehicleInfo(player)
	end
end)

addEvent("onOpenGui", true)
addEventHandler("onOpenGui", root,
function()
	updateVehicleInfo(source)
end)



addEvent("onBuyNewVehicle", true)
addEventHandler("onBuyNewVehicle", root, 
function(Model, cost, r1, g1, b1, r2, g2, b2)
	abc = false
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(source))), -1)
	for i, data in ipairs (data) do
		if data["Model"] == Model then
			abc = true
			break
		end
	end
	if #data >= 20 then outputMessage("#838B83[#FFFF00Revolution#838B83]#FFFF00 Voce Pode Comprar Apenas 20 Veiculos.", source, 38, 122, 216, true) return end
	if abc then outputMessage("#c1c1c1Você já tem este veiculo.", source, 38, 122, 216, true) return end
	if getPlayerMoney(source) >= tonumber(cost) then
		takePlayerMoney ( source, cost )
		local x, y, z = getElementPosition(source)
		local _, _, rz = getElementRotation(source)
		local shopID = getElementData ( source, "atVehShop")
		local color = r1..","..g1..","..b1..","..r2..","..g2..","..b2
		if shopID and shopsVehSpawns[shopID] then
			vehicle = createVehicle(Model, shopsVehSpawns[shopID][1], shopsVehSpawns[shopID][2], shopsVehSpawns[shopID][3], shopsVehSpawns[shopID][4], shopsVehSpawns[shopID][5], shopsVehSpawns[shopID][6])
		else
			vehicle = createVehicle(Model, x-5, y+5, z, 0, 0, rz)
		end
		setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
		setElementData(vehicle, "Owner", source)
		local NewID = getFreeID()
		setElementData(vehicle, "ID", NewID)
		dbExec(db, "INSERT INTO VehicleList VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", NewID, getAccountName(getPlayerAccount(source)), Model, x-5, y+5, z, rz, color, "", 3, cost, 1000, 0)
		outputMessage("#c1c1c1Por: #00FF66$"..cost, source, 38, 122, 216, true)
		updateVehicleInfo(source)
		setElementData(vehicle, "ownercar", getAccountName(getPlayerAccount(source)))
		warpPedIntoVehicle ( source, vehicle )
		vv[vehicle] = setTimer(function(source)
			if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
			if isElement(source) and getElementHealth(source) <= 255 then
				setElementHealth(source, 255.5)
				setVehicleDamageProof(source, true)
				setVehicleEngineState(source, false)
			end
		end, 150, 0, vehicle)
		addEventHandler("onVehicleDamage", vehicle,
		function(loss)
			local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
			setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
		end)
		addEventHandler("onVehicleEnter", vehicle,
		function(player)
			if getElementHealth(source) <= 255.5 then 
				setVehicleEngineState(source, false)
			else
				if isVehicleDamageProof(source) then
					setVehicleDamageProof(source, false)
				end
			end
		end)
	else
		outputMessage("#838B83[#FFFF00Revolution#838B83]#FFFF00 Voce Não Tem Dinheiro Pra Comprar Esse Veiculo", source, 38, 122, 216, true)
	end
end)

vv = {}

addEvent("SpawnMyVehicle", true)
addEventHandler("SpawnMyVehicle", root, 
function(id)
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
	if type(data) == "table" and #data ~= 0 then
		if getVehicleByID(id) then
			outputMessage("#c1c1c1O seu veiculo #00FF66"..(customCarNames[data[1]["Model"]] or getVehicleNameFromModel(data[1]["Model"])).." #c1c1c1já está spawnado.", source, 38, 122, 216, true)
		else
			local color = split(data[1]["Colors"], ',')
			r1 = color[1] or 255
			g1 = color[2] or 255
			b1 = color[3] or 255
			r2 = color[4] or 255
			g2 = color[5] or 255
			b2 = color[6] or 255
			vehicle = createVehicle(data[1]["Model"], data[1]["X"], data[1]["Y"], data[1]["Z"], 0, 0, data[1]["RotZ"])
			setElementData(vehicle, "ID", id)
			local upd = split(tostring(data[1]["Upgrades"]), ',')
			for i, upgrade in ipairs(upd) do
				addVehicleUpgrade(vehicle, upgrade)
			end
			local Paintjob = data[1]["Paintjob"] or 3
			setVehiclePaintjob(vehicle, Paintjob) 
			setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
			if tonumber(data[1]["HP"]) <= 255.5 then data[1]["HP"] = 255 end
			if data[1]["new_hydr"] and data[1]["new_hydr"] == 1 then
				setElementData(vehicle, "NewHydr", true)
			else
				setElementData(vehicle, "NewHydr", false)
			end
			setElementData(vehicle, "ownercar", getAccountName(getPlayerAccount(source)))
			setElementHealth(vehicle, data[1]["HP"])
			setElementData(vehicle, "Owner", source)
			vv[vehicle] = setTimer(function(source)
				if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
				if isElement(source) and getElementHealth(source) <= 255 then
					setElementHealth(source, 255.5)
					setVehicleDamageProof(source, true)
					setVehicleEngineState(source, false)
				end
			end, 50, 0, vehicle)
			addEventHandler("onVehicleDamage", vehicle,
			function(loss)
				local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
				setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
			end)
			addEventHandler("onVehicleEnter", vehicle,
			function(player)
				if getElementHealth(source) <= 255.5 then 
					setVehicleEngineState(source, false)
				else
					if isVehicleDamageProof(source) then
						setVehicleDamageProof(source, false)
					end
				end
			end)
			outputMessage("#c1c1c1O seu veiculo #00FF66"..(customCarNames[data[1]["Model"]] or getVehicleNameFromModel(data[1]["Model"])).." #c1c1c1foi spawnado.", source, 38, 122, 216, true)
		end
	else
		outputMessage("#c1c1c1Há um problema com o veiculo, notifique o administrador.", source, 38, 122, 216, true)
	end
end)

addEvent("DestroyMyVehicle", true)
addEventHandler("DestroyMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
		if type(data) == "table" and #data ~= 0 then
			destroyElement(vehicle)
			outputMessage ("#c1c1c1O seu veiculo #00FF66"..(customCarNames[data[1]["Model"]] or getVehicleNameFromModel(data[1]["Model"])).." #c1c1c1foi removido.", source, 38, 122, 216, true)
		else
			outputMessage("#c1c1c1Selecione um veiculo.", source, 38, 122, 216, true)
		end
	else
		outputMessage("#c1c1c1O seu veiculo não foi spawnado.", source, 38, 122, 216, true)
	end
end)

addEvent("LightsMyVehicle", true)
addEventHandler("LightsMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local Vehicle = getPedOccupiedVehicle(source)
		if Vehicle == vehicle then
			if getVehicleOverrideLights(vehicle) ~= 2 then
				setVehicleOverrideLights(vehicle, 2)
				outputMessage("#c1c1c1Seu veiculo #00FF66"..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." #c1c1c1teve as luzes acesas.", source, 38, 122, 216, true)
			elseif getVehicleOverrideLights(vehicle) ~= 1 then
				setVehicleOverrideLights(vehicle, 1)
				outputMessage("#c1c1c1Seu veiculo #00FF66"..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." #c1c1c1teve as luzes apagadas.", source, 38, 122, 216, true)
			end
		else
			outputMessage("#838B83[#FFFF00Revolution#838B83]#FFFF00 Voce Não Está no Veiculo!", source, 38, 122, 216, true)
		end
	else
		outputMessage("#838B83[#FFFF00Revolution#838B83]#FFFF00 Seu Veiculo Não Está Spawnado", source, 38, 122, 216, true)
	end
end)

addEvent("LockMyVehicle", true)
addEventHandler("LockMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, true)
			setVehicleDoorsUndamageable(vehicle, true)
			setVehicleDoorState(vehicle, 0, 0)
			setVehicleDoorState(vehicle, 1, 0)
			setVehicleDoorState(vehicle, 2, 0)
			setVehicleDoorState(vehicle, 3, 0) 
			outputMessage("#c1c1c1O seu transporte #00FF66"..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." #c1c1c1foi #00FF66fechado.", source, 38, 122, 216, true)
		elseif isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, false)
			setVehicleDoorsUndamageable(vehicle, false)
			outputMessage("#c1c1c1O seu transporte #00FF66"..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." #c1c1c1foi #00FF66aberto.", source, 38, 122, 216, true)
		end
	else
		outputMessage("#838B83[#FFFF00Revolution#838B83]#FFFF00 Seu Veiculo Não Foi Spawnado", source, 38, 122, 216, true)
	end
end)

addEvent("BlipMyVehicle", true)
addEventHandler("BlipMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not getElementData(vehicle, "ABlip") then
			setElementData(vehicle, "ABlip", true)
			createBlipAttachedTo(vehicle, 41, 2, 255, 0, 0, 255, 0, 65535, source)
			outputChatBox("#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Seu veículo Foi Marcado no Mapa, Aperte F11 Pra Encontra-lo.", source, 38, 122, 216, true)
		else
			local attached = getAttachedElements(vehicle)
			if (attached) then
				for k,element in ipairs(attached) do
					if getElementType(element) == "blip" then
						destroyElement(element)
					end
				end
			end
			setElementData(vehicle, "ABlip", false)
			outputChatBox("#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Seu veículo Foi Desmarcado do Mapa.", source, 38, 122, 216, true)
		end
	else
		outputChatBox("#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Seu Veiculo Não foi Spawnado.", source, 38, 122, 216, true)
	end
end)

addEvent("FixMyVehicle", true)
addEventHandler("FixMyVehicle", root, 
function(id)
	if getPlayerMoney(source) >= tonumber(500) then
		takePlayerMoney ( source, 500 )
		local vehicle = getVehicleByID(id)
		if isElement(vehicle) then
			fixVehicle(vehicle)
			setVehicleEngineState(vehicle, true)
			if isVehicleDamageProof(vehicle) then
				setVehicleDamageProof(vehicle, false)
			end
		end
		dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND ID = ?", 1000, getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		outputMessage ("#c1c1c1O seu transporte foi reparado.", source, 38, 122, 216, true)
	else
		outputMessage("#c1c1c1Você não tem dinheiro suficiente para reparar.", source, 38, 122, 216, true)
		outputMessage("#c1c1c1Preço: #00FF66R$500.", source, 38, 122, 216, true)
	end
end)

addEvent("WarpMyVehicle", true)
addEventHandler("WarpMyVehicle", root, 
function(id)
    if not isPedInVehicle (source) then
	if getElementInterior(source) == 0 then
		if getPlayerMoney(source) >= tonumber(500) then
			local vehicle = getVehicleByID(id)
			if isElement(vehicle) then
				takePlayerMoney ( source, 500 )
				local x, y, z = getElementPosition(source)
				setElementPosition(vehicle, x, y, z)
				warpPedIntoVehicle ( source, vehicle )
				outputMessage ("#c1c1c1O seu veiculo #00FF66"..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." #c1c1c1foi entregue a você.", source, 38, 122, 216, true)
			else
				outputMessage("#838B83[#FFFF00Revolution#838B83]#FFFF00 Seu Veiculo Não Está Spawnado.", source, 38, 122, 216, true)
			end
		else
			outputMessage("#c1c1c1Você não tem os meios de se teletransportar para o veiculo.", source, 38, 122, 216, true)
		end
	else
		outputMessage("#c1c1c1Você só poderá mudar de veiculo se sair do atual.", source, 38, 122, 216, true)
	end
     else
outputMessage("#838B83[#FFFF00Revolution#838B83]#FFFF00 Nós não podemos dirigir seu veiculo. Por favor, sair do outro veiculo.", source, 38, 122, 216, true)
    end
end)
	
addEvent("SellMyVehicle", true)
addEventHandler("SellMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
	if type(data) == "table" and #data ~= 0 then
		local Money = math.ceil((data[1]["Cost"]*.9)*math.floor(data[1]["HP"])/100/10)
		givePlayerMoney (source, Money)
		if isElement(vehicle) then destroyElement(vehicle) end
		dbExec(db, "DELETE FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		outputMessage("#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Voce Vendeu Seu Veiculo por R$:"..Money, source, 38, 122, 216, true)
	end
end)

function getDataOnLogin(_, account)
	for i,k in pairs(getElementsByType("vehicle")) do
		local nomeAccount = getElementData(k,"ownercar")
		if(getAccountName(account) == nomeAccount) then
			setNewOwner(source,k)
		end
	end
end
addEventHandler("onPlayerLogin", root, getDataOnLogin)

function SaveVehicleDataOnQuit()
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "Owner") == source then
			destroyElement(veh)
		end
	end
end
addEventHandler("onPlayerQuit", root,SaveVehicleDataOnQuit)


addEvent("inviteToBuyCarSended", true)
addEventHandler("inviteToBuyCarSended", root, 
function(player, price, veh_name, veh_id)
	if player and price and veh_name and veh_id then
		local pl = getPlayerFromName ( player )
		if pl then
			triggerClientEvent ( pl, "recieveInviteToBuyCar", pl, getPlayerName (source), getAccountName(getPlayerAccount(source)), price, veh_name, veh_id )
		else
			outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Jogador Não Encontrado", source, 250, 10, 10, true)
			triggerClientEvent ( source, "cleanCarInvitations", source )
		end
	end
end)


addEvent("invitationBuyCarNotAccepted", true)
addEventHandler("invitationBuyCarNotAccepted", root, 
function(player, acc, price, veh_name, veh_id)
	local pl = getPlayerFromName ( player )
	if pl then
		triggerClientEvent ( pl, "cleanCarInvitations", pl )
		outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 o Jogador Recusou a Oferta", pl, 250, 10, 10,true)
	end 
end)

addEvent("invitationBuyCarAccepted", true)
addEventHandler("invitationBuyCarAccepted", root, 
function(player, acc, price, veh_name, veh_id)
	local pl = getPlayerFromName ( player )
	local avail = false
	if pl and getAccountName ( getPlayerAccount (pl)) == acc then
		avail = true
		triggerClientEvent ( pl, "cleanCarInvitations", pl )
		--outputMessage ( "Игрок отказался покупать ваше авто", pl, 250, 10, 10)
	else
		for i, v in ipairs( getElementsByType ( 'player' ) ) do
			if getAccountName(getPlayerAccount ( v )) == acc then
				avail = true
				pl = v
				break
			end
		end
	end
	price = tonumber(price) or 0
	if avail then
		if isGuestAccount ( getPlayerAccount ( source ) ) then
			triggerClientEvent ( pl, "cleanCarInvitations", pl )
			outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Voce Não Está Logado em Sua Conta", source, 250, 10, 10,true )
			outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 o Jogador Não Está Logado", pl, 250, 10, 10,true )
			return true
		end
		if getPlayerMoney ( source ) >= price then
			local vehicle = getVehicleByID(tonumber(veh_id))
			local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(pl)), veh_id), -1)
			if type(data) == "table" and #data ~= 0 and isElement ( vehicle ) then
				givePlayerMoney ( pl, price )
				takePlayerMoney ( source, price )		
				dbExec(db, "UPDATE VehicleList SET Account = ? WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), getAccountName(getPlayerAccount(pl)), veh_id)
				updateVehicleInfo(source)
				updateVehicleInfo(pl)
				setElementData(vehicle, "Owner", source)
				setElementData(vehicle, "ownercar", getAccountName(getPlayerAccount(source)))
				outputMessage("#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Voce Vendeu Seu Veiculo Por R$:"..price, pl, 38, 122, 216, true)
				outputMessage("#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Comprou Um Veiculo Por R$:"..price, source, 38, 122, 216, true)
				triggerClientEvent ( pl, "cleanCarInvitations", pl )
			else
				outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 o Veiculo Não Está Spawnado", source, 250, 10, 10,true )
				outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 o Veiculo Não Está Spawnado", pl, 250, 10, 10,true )
				triggerClientEvent ( pl, "cleanCarInvitations", pl )
			end
		else
			outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Voce Não Tem Dinheiro Suficiente", source, 250, 10, 10,true )
		end
	else
		outputMessage ( "#838B83[#FFFF00Revolution#838B83 ]#FFFF00 Jogador Não Encontrado", source, 250, 10, 10,true)
	end
end)


function setNewOwner(player,car)
	if not player then return nil end
	if not car then return nil end

	local account = getPlayerAccount(player)
	local accountName = getAccountName(account)
	setElementData(car, "Owner", player)
	setElementData(car, "ownercar", accountName)

	return true;
end




function outputMessage (text, player, r, g, b)
	return exports["scr-Lib"]:outputMessage(player, text, r, g, b);
end