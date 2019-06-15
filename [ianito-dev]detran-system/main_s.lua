--[[
	@author: ianito
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--




local pickups = {
    ['skinID'] = createObject(1275,pickupsPositions.skin[1],pickupsPositions.skin[2],pickupsPositions.skin[3],0,0,90),    
    ['vehicle'] = createObject(1210,pickupsPositions.vehicle[1],pickupsPositions.vehicle[2],pickupsPositions.vehicle[3],0,0,90)
}

 local pickupsColShape = {
     ['skinID'] =  createColSphere(pickupsPositions.skin[1],pickupsPositions.skin[2],pickupsPositions.skin[3],1),
     ['vehicle'] = createColSphere(pickupsPositions.vehicle[1],pickupsPositions.vehicle[2],pickupsPositions.vehicle[3],1)
 }
 

addEventHandler( "onElementColShapeHit", root,function(theColShape,sameDimension)
    if(sameDimension) then
       if(getElementType(source) == "player") then  
            if(theColShape == pickupsColShape['skinID']) then
              if(hasPlayerIsInACL(source,ACL_DETRAN)) then
                  outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFTrocando sua skin...",source,255,255,255,true)
                  fadeCamera(source,false,1)
                  toggleAllControls(source,false)
                  setTimer(function (p)
                      setElementModel(p,SKIN_DETRAN_PLAYER)
                      toggleAllControls(p,true)
                      fadeCamera(p,true)
                  end,2000,1,source)
                else
                  outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pertence ao DETRAN.",source,255,255,255,true)
                end
            elseif(theColShape == pickupsColShape['vehicle']) then
              if(hasPlayerIsInACL(source,ACL_DETRAN)) then
                  outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFGerando seu veículo de trabalho...",source,255,255,255,true)
                  toggleAllControls(source,false)
                  fadeCamera(source,false)
                  setTimer(function (p)
                      toggleAllControls(p,true)
                      
                      local vehicle = createVehicle(VEHICLE_FOR_USERS,unpack(DEFAULT_POSITION))
                      if(getElementData(p,CAR_DETRAN_ELEMENT)) then
                        destroyElement(getElementData(p,CAR_DETRAN_ELEMENT))
                      end
                      setElementData(vehicle,IS_DETRAN_CAR ,true)
                      setElementData(p,CAR_DETRAN_ELEMENT,vehicle)
                      warpPedIntoVehicle(p,vehicle,0)
                      fadeCamera(p,true)
                  end,2000,1,source)
                else
                  outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pertence ao DETRAN.",source,255,255,255,true)  
               end
              end
            end
        end
    end)


function addCar(detranCar,price)
  if not price then price = DEFAULT_PRICE end;
  if not detranCar then
    return false
  end
  local emptySeat = getParkEmpty()
  if not (emptySeat) then
    return false
  end
  if isElementAttached(getElementData(detranCar,CAR_TOWED_ELEMENT)) then
    detachElements(getElementData(detranCar,CAR_TOWED_ELEMENT))
  end
  emptySeat['vehicleElement'] = getElementData(detranCar,CAR_TOWED_ELEMENT)
 
  local x,y,z = unpack(emptySeat['markerPosition'])
  createMarkerSell(emptySeat,x,y,z)
  setElementFrozen(emptySeat['vehicleElement'],true)
  setElementPosition(emptySeat['vehicleElement'],emptySeat['position'][1],emptySeat['position'][2],emptySeat['position'][3])
  setElementRotation(emptySeat['vehicleElement'],0,0,emptySeat['position'][4])
  setElementData(getElementData(detranCar,CAR_TOWED_ELEMENT),IS_CAR_TOWED,true)
  addEventHandler ( "onVehicleStartEnter", emptySeat['vehicleElement'],function(player)
      if(getElementData(source,IS_CAR_TOWED)) then
        
        outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFCarro trancado, favor, falar com alguém do DETRAN....",player,255,255,255,true)
        cancelEvent()
      end
  end) 

  
  setElementData(detranCar,CAR_TOWED_ELEMENT,nil)
  
  return true;
end

function unlockCar(seat)
  if not seat then return nil end
     if(seat['vehicleElement'] and seat['markerElement']) then
      setElementFrozen(seat['vehicleElement'],false)
      setElementData(seat['vehicleElement'],IS_CAR_TOWED,false)
      destroyElement(seat['markerElement'])
    end
      seat['markerElement'] = nil;
      seat['vehicleElement'] = nil;
      return true;
end


---------------------ATTACH----------------------------------
function attachCars(detranCar,carElement)
  if not detranCar or not carElement then return nil end
  setElementData(detranCar,CAR_TOWED_ELEMENT,carElement)
  
 return  attachElements(carElement,detranCar,0,-2,0.3)
end
function detachCars(detranCar)
  if not detranCar then return nil end
  detachElements(getElementData(detranCar,CAR_TOWED_ELEMENT))
  setElementData(detranCar,CAR_TOWED_ELEMENT,nil)
  return true
end
--------------------MARKER-----------------------------------
function onEnterMarkerSell(hit,sameDimension)
    if(sameDimension) then
      if(getElementType(hit) == "player") then
        outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFDigite "..COLOR_MESSAGE_ORANGE.."/liberarcarro #FFFFFFpara liberar o carro.",hit,255,255,255,true)
        setElementData(hit,MARKER_PLAYER_INSIDE,source)
      end
    end
end

function onLeaveMarkerSell(hit,sameDimension)
  if(sameDimension) then
    if(getElementType(hit) == "player") then
     setElementData(hit,MARKER_PLAYER_INSIDE,nil)
    end
  end
end




function createMarkerSell(seat,x,y,z)
  seat['markerElement'] =  createMarker(x,y,z,"cylinder",1.5,255,255,0)
  addEventHandler("onMarkerHit",seat['markerElement'],onEnterMarkerSell)
  addEventHandler("onMarkerLeave",seat['markerElement'],onLeaveMarkerSell)
end

function getSeatByMarkerElement(markerElement)
  if not markerElement then return nil end
  for index, value in ipairs(parkingLot) do
    if(value['markerElement']) then
      if(value['markerElement'] == markerElement) then 
        return value
      end
    end 
  end
end

---------------UTILS FUNCTION--------------

function getParkEmpty()
  for index, value in pairs(parkingLot) do
      local markerElement = value['markerElement'];
      if(markerElement == nil) then
          return parkingLot[index];
      end
  end
  return false
end
function loadPickupsProperties()
  for index,value in pairs(pickups)do
      setObjectScale(pickups[index],1.5)
      setElementCollisionsEnabled(pickups[index],false)
  end
end

function masterKey(player)
 if(isVehicleLocked(source)) then
 	if(hasPlayerIsInACL(player,ACL_DETRAN)) then
 		outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFVeículo trancado,chave mestra utilizada.",player,255,255,255,true) 
     setVehicleLocked(source,false)
      setElementData(source,"cl_vehicleowner",nil)
      setElementData(source,"cl_vehiclelocked",nil)  
      setElementData(source,"cl_enginestate",nil)
       return true;
   end
  end
end
addEventHandler ( "onVehicleStartEnter", root, masterKey ) --add an event handler for onVehicleStartEnter
--loadCars()
--loadMarkers()
--You are at {1547.48730, -2242.07056, 13.54688}
loadPickupsProperties()



