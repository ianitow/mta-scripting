local static = {
   
}

local playersInArea = {}


function main()
    static['radar'] = createRadarArea(1990.70996, -1451.22900,WIDTH,HEIGHT,unpack(COLORS))
    local x,y = getElementPosition(static.radar)
    static['colshape'] =    
    createColRectangle(x,y,WIDTH,HEIGHT)

end

main()


function static.onPlayerEnterAreVerde (thePlayer,matchingDimension)
    
    if(matchingDimension) then
        setElementAlpha(thePlayer,120)
        setElementData(thePlayer,IS_PLAYER_PROTECTED,true)
        if(getElementType(thePlayer) == "player") then
            outputChatBox("#0000FF[REVOLUTION]#FFFFFFVocê entrou na área verde!",thePlayer,255,255,255,true)
            table.insert(playersInArea,thePlayer)
            
            toggleControl(thePlayer,"fire",false)
        
            toggleControl(thePlayer,"aim_weapon",false)
            updatePlayersInArea()
            
        end
        triggerClientEvent("activeGhost",thePlayer)
    end
end

addEventHandler ( "onColShapeHit", static.colshape, static.onPlayerEnterAreVerde )


function static.onPlayerLeaveAreaVerde (thePlayer,matchingDimension)
    
    if(matchingDimension) then
        setElementAlpha(thePlayer,255)
        setElementData(thePlayer,IS_PLAYER_PROTECTED,false)
           
        if(getElementType(thePlayer) == "player") then
            outputChatBox("#0000FF[REVOLUTION]#FFFFFFVocê saiu da área verde!",thePlayer,255,255,255,true)
            removeTableByPlayer(thePlayer)
            toggleControl(thePlayer,"fire",true)
           
            toggleControl(thePlayer,"aim_weapon",true)
        
            updatePlayersInArea()
        end
        triggerClientEvent("disableGhost",thePlayer)
    end
end


function removeTableByPlayer(playerElement)
    for i,k in pairs(playersInArea) do
        if(k == playerElement) then
            table.remove(playersInArea,i)
        end
    end
    return playersInArea
end
addEventHandler ( "onColShapeLeave", static.colshape, static.onPlayerLeaveAreaVerde )


function updatePlayersInArea()
    setElementData(getResourceRootElement(),RESOURCE_DATA,playersInArea)
end

function displayVehicleLoss(loss)
    local thePlayer = getVehicleOccupant(source)
    if(thePlayer) then -- Check there is a player in the vehicle
        if(getElementData(source,IS_PLAYER_PROTECTED)) then
            setElementHealth(source,getElementHealth(source)+loss)
        end
    end
end

addEventHandler("onVehicleDamage", root, displayVehicleLoss)