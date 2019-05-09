function showPanel(thePlayer)
  accountname = getAccountName(getPlayerAccount(thePlayer))
  if isObjectInACLGroup("user." .. accountname, aclGetGroup("Everyone")) then
    triggerClientEvent(thePlayer, "painel_f5", getRootElement())
  end
end
function onRestart()
  for index, player in ipairs(getElementsByType("player")) do
    bindKey(player, "F1", "down", showPanel)
  end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onRestart)
function OnPlayerJoin()
  bindKey(source, "F1", "down", showPanel)
end
addEventHandler("onPlayerJoin", getRootElement(), OnPlayerJoin)
function cleanAll(player)
  for index, player in ipairs(getElementsByType("player")) do
    unbindKey(player, "F4", "down", showPanel)
  end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), cleanAll)

function F5_flip()
	local vehicle = getPedOccupiedVehicle(source)
	if isPedInVehicle(source) then
		local rotX, rotY, rotZ = getElementRotation(vehicle)
		setVehicleRotation(vehicle, 0, 0, (rotX > 90 and rotX < 270) and (rotZ + 180) or rotZ)
	end
end
addEvent("F5_flip", true)
addEventHandler("F5_flip", getRootElement(), F5_flip)


function F5_subir()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		setVehicleHandling ( vehicle, "suspensionLowerLimit", (getVehicleHandling(vehicle)['suspensionLowerLimit'])-0.1 )
end
addEvent("F5_subir", true)
addEventHandler("F5_subir", getRootElement(), F5_subir)


function F5_descer()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		setVehicleHandling ( vehicle, "suspensionLowerLimit", (getVehicleHandling(vehicle)['suspensionLowerLimit'])+0.1 )
end
addEvent("F5_descer", true)
addEventHandler("F5_descer", getRootElement(), F5_descer)

function F5_esquerda1()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		if getVehicleDoorOpenRatio ( vehicle, 2 ) == 0 then
			setVehicleDoorOpenRatio(vehicle, 2, 1, 2500)
		else
			setVehicleDoorOpenRatio(vehicle, 2, 0, 2500)
		end
end
addEvent("F5_esquerda1", true)
addEventHandler("F5_esquerda1", getRootElement(), F5_esquerda1)

function F5_esquerda2()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		if getVehicleDoorOpenRatio ( vehicle, 4 ) == 0 then
			setVehicleDoorOpenRatio(vehicle, 4, 1, 2500)
		else
			setVehicleDoorOpenRatio(vehicle, 4, 0, 2500)
		end
end
addEvent("F5_esquerda2", true)
addEventHandler("F5_esquerda2", getRootElement(), F5_esquerda2)

function F5_direita1()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		if getVehicleDoorOpenRatio ( vehicle, 3 ) == 0 then
			setVehicleDoorOpenRatio(vehicle, 3, 1, 2500)
		else
			setVehicleDoorOpenRatio(vehicle, 3, 0, 2500)
		end

end
addEvent("F5_direita1", true)
addEventHandler("F5_direita1", getRootElement(), F5_direita1)

function F5_direita2()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		if getVehicleDoorOpenRatio ( vehicle, 5 ) == 0 then
			setVehicleDoorOpenRatio(vehicle, 5, 1, 2500)
		else
			setVehicleDoorOpenRatio(vehicle, 5, 0, 2500)
		end
end
addEvent("F5_direita2", true)
addEventHandler("F5_direita2", getRootElement(), F5_direita2)

function F5_cima()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		if getVehicleDoorOpenRatio ( vehicle, 0 ) == 0 then
			setVehicleDoorOpenRatio(vehicle, 0, 1, 2500)
		else
			setVehicleDoorOpenRatio(vehicle, 0, 0, 2500)
		end
end
addEvent("F5_cima", true)
addEventHandler("F5_cima", getRootElement(), F5_cima)

function F5_baixo()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then return end
		if getVehicleDoorOpenRatio ( vehicle, 1 ) == 0 then
			setVehicleDoorOpenRatio(vehicle, 1, 1, 2500)
		else
			setVehicleDoorOpenRatio(vehicle, 1, 0, 2500)
		end
end
addEvent("F5_baixo", true)
addEventHandler("F5_baixo", getRootElement(), F5_baixo)