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
        
        if(getElementType(thePlayer) == "player") then
            outputChatBox("#0000FF[REVOLUTION]#FFFFFFVocê entrou na área verde!",thePlayer,255,255,255,true)
            table.insert(playersInArea,thePlayer)
            setElementData(thePlayer,IS_PLAYER_PROTECTED,true)
            toggleControl(thePlayer,"fire",false)
        
            toggleControl(thePlayer,"aim_weapon",false)
            updatePlayersInArea()
            triggerClientEvent("activeGhost",thePlayer)
        end
        
    end
end

addEventHandler ( "onColShapeHit", static.colshape, static.onPlayerEnterAreVerde )


function static.onPlayerLeaveAreaVerde (thePlayer,matchingDimension)
    
    if(matchingDimension) then
        setElementAlpha(thePlayer,255)
        if(getElementType(thePlayer) == "player") then
            outputChatBox("#0000FF[REVOLUTION]#FFFFFFVocê saiu da área verde!",thePlayer,255,255,255,true)
            removeTableByPlayer(thePlayer)
            setElementData(thePlayer,IS_PLAYER_PROTECTED,false)
            toggleControl(thePlayer,"fire",true)
            triggerClientEvent("disableGhost",thePlayer)
            toggleControl(thePlayer,"aim_weapon",true)
        
            updatePlayersInArea()
        end
        
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

