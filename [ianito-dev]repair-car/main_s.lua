local LIMIT = 260
function getNearestVehicle(player,distance)
	local tempTable = {}
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)

	for _,v in pairs(getElementsByType("vehicle")) do
		local vint,vdim = getElementInterior(v),getElementDimension(v)
		if vint == pint and vdim == pdim then
			local vx,vy,vz = getElementPosition(v)
			local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end

addCommandHandler("reparar",function(player,cmd)
	if(hasPlayerIsInACL(player,ACL_NAME)) then
		local car = getNearestVehicle(player,5)
		if(car) then
			repairCarAnim(player,car)
		else
			outputChatBox("#FF0000[REPARO]:#FFFFFFVocê não está proximo de um veículo.",player,255,255,255,true)
		end
	else
		outputChatBox("#FF0000[REPARO]:#FFFFFFVocê não pertence aos mecânicos.",player,255,255,255,true)
	end
	
end)

addEventHandler("onResourceStop",resourceRoot,function()
	for i,k in pairs(getElementsByType("vehicle"))do
		setElementData(k,"REPAIR:isAttachedEvent",false)
		setElementData(k,"REPAIR:attachServer",false)
		print("[REPAIR-CAR] Events Removed")
	end
	
end)


addEventHandler("onVehicleEnter",root,function(thePlayer,seat)
	if(getElementHealth(source) <= LIMIT) then
		local ped = getVehicleOccupant(source)
		if(ped) then
			outputChatBox("#FF0000[REPARO]:#FFFFFFVeículo estragado, por favor, chame um mecânico.",thePlayer,255,255,255,true)
			toggleControl(thePlayer,"accelerate",false)
			toggleControl(thePlayer,"brake_reverse",false)
		end
		setVehicleEngineState ( source, false )
	end
end)
addEventHandler("onVehicleExit",root,function(thePlayer,seat)
	toggleControl(thePlayer,"accelerate",true)
	toggleControl(thePlayer,"brake_reverse",true)
end)



function repairCarAnim(ped,vehicle)
	local block = "cop_ambient"
	toggleAllControls(ped,false,true,false)
	local anims = {"copbrowse_in","copbrowse_loop","copbrowse_out"}
	
	setPedAnimation ( ped,block,anims[1],-1,false,false,false,false,250)
	setTimer(function()
		triggerClientEvent(root,"playSoundRepair",vehicle)
		setPedAnimation ( ped,block,anims[2],-1,true,false,false,false,250)
		setTimer(function() 
			toggleAllControls(ped,true)
			local occupants = getVehicleOccupant(vehicle)
			if(occupants) then
				toggleControl(ped,"accelerate",true)
				toggleControl(ped,"brake_reverse",true)
				setVehicleEngineState ( vehicle, true )
			end
			fixVehicle(vehicle)
			outputChatBox("#FF0000[REPARO]:#FFFFFFVeículo reparado com sucesso.",ped,255,255,255,true)
			setPedAnimation ( ped,block,anims[3],-1,false,false,false,false,250)
		end,8000,1)
	end,1000,1,ped)
end

function outputChatBoxServer(message,element)
	outputChatBox(message,element,255,255,255,true)
end
addEvent("outputChatBoxServer",true)
addEventHandler("outputChatBoxServer",root,outputChatBoxServer)

