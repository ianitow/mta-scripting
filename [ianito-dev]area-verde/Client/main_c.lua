function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	for oX = (outline * -1), outline do
		for oY = (outline * -1), outline do
			dxDrawText (text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		end
	end
	dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end




function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawBorderedText(2,text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end

function showMessage(element)
  if not getElementData(getResourceRootElement(),RESOURCE_DATA) then print('nada irmao') return nil end
  for i,k in pairs(getElementData(getResourceRootElement(),RESOURCE_DATA) )do 
     dxDrawTextOnElement(k,"[ON] Protegido",1,40,0,255,0,255,1.2)
end

end
addEventHandler("onClientRender",root,showMessage)

function stopDamageWhenArea ( attacker, weapon, bodypart )
    if(source:getData(IS_PLAYER_PROTECTED)) then
        cancelEvent()
    end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopDamageWhenArea )


function activeGhostMode()
    for i, k in pairs(getElementsByType("player")) do
       
            setElementCollidableWith(source,k,false)
        
	end
	
	for i, k in pairs(getElementsByType("vehicle")) do
       
		setElementCollidableWith(source,k,false)
	
end

if(getElementType(source) == "vehicle") then
	for i,k in pairs(getElementsByType("player")) do
		setElementCollidableWith(source,k,false)
	end
	for i,k in pairs(getElementsByType("vehicle")) do
		setElementCollidableWith(source,k,false)
	end
	
	
end
executeCommandHandler("Toggle Driveby")
if(getElementData(localPlayer,"isDriveShootingEnabled")) then
	
end
    return true
end
addEvent("activeGhost",true)
addEventHandler("activeGhost",root,activeGhostMode)

function disableGhostMode()
    for i, k in pairs(getElementsByType("player")) do
      
            setElementCollidableWith(source,k,true)

	end
	for i, k in pairs(getElementsByType("vehicle")) do
       
		setElementCollidableWith(source,k,true)
	
end
if(getElementType(source) == "vehicle") then
	for i,k in pairs(getElementsByType("player")) do
		setElementCollidableWith(source,k,true)
	end
	for i,k in pairs(getElementsByType("vehicle")) do
		setElementCollidableWith(source,k,true)
	end
	
end
return true
end
addEvent("disableGhost",true)
addEventHandler("disableGhost",root,disableGhostMode)


function handleVehicleDamage(attacker, weapon, loss, x, y, z, tire)
	
	if(getElementData(source,IS_PLAYER_PROTECTED)) then
		cancelEvent()
	end
	
end
addEventHandler("onClientVehicleDamage", root, handleVehicleDamage)