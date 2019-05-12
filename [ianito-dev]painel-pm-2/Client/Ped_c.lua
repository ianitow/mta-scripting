
local followTo  
local follower 
addEvent("followPlayer", true) 
addEventHandler("followPlayer", root, 
function (thePlayer, value) 
    if (isElement(source) and isElement(thePlayer) ) then 
        if (value) then 
            followTo = thePlayer 
            follower = source 
            removeEventHandler( "onClientRender", root, FollowToPlayer) 
            addEventHandler( "onClientRender", root, FollowToPlayer) 
        else 
            removeEventHandler( "onClientRender", root, FollowToPlayer) 
        end 
    end 
end) 
  


addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), function ()
    if(getElementData(localPlayer,DATA_IS_PLAYER_JAIL)) then
        cancelEvent()
    end
end )



function FollowToPlayer() 
    local ped = follower --Ped who has to follow the player 
    local plr = followTo -- The Player 
    dxDrawTextOnElement(ped,"Capturado por:"..plr.name,1,20,255,255,255,255,1,"diploma")
    if ped then 
        local x, y, z = getElementPosition( plr ); 
        local px, py, pz = getElementPosition( ped ); 
        local distance = getDistanceBetweenPoints3D( x, y, z, px, py, pz ) 
        if distance < 3.5 then 
            setPedControlState( ped, "forwards", false ); 
            if ( isPedDucked( plr ) ~= isPedDucked( ped ) ) then 
                setPedControlState( ped, "crouch", isPedDucked( getLocalPlayer( ) )); 
                return 
            end 
        else 
            setPedControlState( ped, "forwards", true ); 
            if distance < 6.0 then 
                if isPedDucked( plr ) ~= isPedDucked( ped ) then 
                    setPedControlState( ped, "crouch", false ); 
                    setPedControlState( ped, "crouch", true ); 
                    setPedControlState( ped, "walk", false ); 
                    setPedControlState( ped, "sprint", false ); 
                    return 
                else 
                    setPedControlState( ped, "walk", true ); 
                    setPedControlState( ped, "sprint", false ); 
                end 
            elseif distance < 10.0 then 
                setPedControlState( ped, "walk", false ); 
                setPedControlState( ped, "sprint", true ); 
            else 
                setPedControlState( ped, "walk", false ); 
                setPedControlState( ped, "sprint", true ); 
            end 
             
            local X, Y = 0, 0; 
             
            X = math.abs( x - px ); 
            Y = math.abs( y - py ); 
            faceMe = math.deg( math.atan2( Y , X ) ); 
  
             
            if ( x >= px ) and ( y > py ) then      -- north-east 
                faceMe = 90 - faceMe 
            elseif ( x <= px ) and ( y > py ) then  -- north-west 
                faceMe = 270 + faceMe 
            elseif ( x >= px ) and ( y <= py ) then -- south-east 
                faceMe = 90 + faceMe 
            elseif ( x < px ) and ( y <= py ) then  -- south-west 
                faceMe = 270 - faceMe 
            end 
  
            setPedRotation( ped, faceMe ); 
            setPedLookAt( ped, x, y, z + .5 ); 
        end 
    end 
  
end 
  
  
  
_setPedRotation = setPedRotation 
function setPedRotation( ped, rot ) 
    return _setPedRotation( ped, 360 - rot ); 
end 


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

