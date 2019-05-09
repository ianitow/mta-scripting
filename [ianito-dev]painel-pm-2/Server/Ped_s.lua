MARKER = createMarker(1579.65210, -1635.42102, 12.56098,"cylinder",2.0,255,0,0)


function algemarPlayer(player,state)
    if state then
        setElementFrozen(player,true)
        toggleAllControls(player,false,true,false)
        setPedAnimation(player,"kissing","gift_give",-1,true,false,false,true)
     
        setTimer(function(ped) 
        setPedAnimationProgress(ped,"gift_give",0.1)
        end, 50, 0,player)
    else
        setElementFrozen(player,false)
        toggleAllControls(player,true,true,true)
        setPedAnimation(player,nil)
    end
end


    

















function handcuffPlayer(victim,owner)
    if not victim or not owner then return end
    if(getElementData(owner,DATA_PLAYERS_JAILED)) then
        local tbl = getElementData(owner,DATA_PLAYERS_JAILED)
        if(#tbl >0) then
            outputChatBox("#FF0000[POLICE]:#FFFFFFVocê já tem um player preso, leve-o até a cadeia.",owner,255,255,255,true)
            return
        end
        table.insert(tbl,victim)
        setElementData(owner,DATA_PLAYERS_JAILED,tbl)
     else
        local tbl = {}
        table.insert(tbl,victim)
        setElementData(owner,DATA_PLAYERS_JAILED,tbl)
    end
    local x,y,z = getElementPosition(victim)
    rotation = 0
    model = getElementModel(victim)
    setElementAlpha(victim,0)
    setElementCollisionsEnabled(victim,false)
    local pedCopy = createPed(model,x,y,z)
    triggerClientEvent ( "followPlayer", pedCopy, owner, true ) 
    addEventHandler("onPedWasted",pedCopy,function()
         --CANCELA EVENTO
         triggerClientEvent ( "followPlayer", source, false, false ) 
         destroyElement(source)
     
    end)
    attachElements(victim,pedCopy)
    setElementData(victim,DATA_PED_ELEMENT,pedCopy)
    toggleAllControls(victim,false,true,false)

    --SET DATA
    

end





function onPoliceEnterMarker(hitElement,matchingDimension)
    if matchingDimension then
        if isGuestAccount(getPlayerAccount(hitElement)) then 
            outputChatBox(MESSAGE_ERROR_NOT_POLICE,hitElement,255,255,255,true)    
            return 
        end 
        if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(hitElement)),aclGetGroup(ACL_NAME)) then
         outputChatBox(MESSAGE_ERROR_NOT_POLICE,hitElement,255,255,255,true)    
            return
        end
    end
end

addEventHandler( "onMarkerHit", MARKER, onPoliceEnterMarker )







function jailPlayer(thePlayer,marker)
    if isGuestAccount(getPlayerAccount(thePlayer)) then 
        outputChatBox(MESSAGE_ERROR_NOT_POLICE,thePlayer,255,255,255,true)    
        return 
    end 
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)),aclGetGroup(ACL_NAME)) then
        outputChatBox(MESSAGE_ERROR_NOT_POLICE,thePlayer,255,255,255,true)    
        return
    end
    if(isElementWithinMarker(thePlayer,MARKER)) then
        local players = getElementData(thePlayer,DATA_PLAYERS_JAILED)
        if not players or #players == 0 then
            outputChatBox(MESSAGE_NOT_PLAYERS_JAILED,thePlayer,255,255,255,true)
            return
        else
            for i,k in pairs(players)do
                local ped = getElementData(k,DATA_PED_ELEMENT)
              
                outputChatBox("#FF0000[POLICE]:#FFFFFFVocê foi preso pelo "..getPlayerName(thePlayer),k,255,255,255,true)
                outputChatBox("#FF0000[POLICE]:#FFFFFFVocê prendeu:  "..getPlayerName(k),thePlayer,255,255,255,true)
    
                --CANCELA EVENTO
                triggerClientEvent ( "followPlayer", ped, k, false )
                detachElements(k,ped) 
                destroyElement(ped)
                --DATAS
                setElementData(k,DATA_PED_ELEMENT,nil)
                setElementData(k,DATA_IS_PLAYER_JAIL,true)
                setElementData(k,DATA_TIMER_LEFT,tonumber(getPlayerWantedLevel(k) * 60000))
                --OTHERS
                toggleAllControls(k,true,true,true)
                setCameraTarget(k,nil)
                setTimer(letPlayerExitJail,(getPlayerWantedLevel(k) * 60000),1,k)
                  --ENVIA PRA CADEIRA
                
                  setElementCollisionsEnabled(k,true)
                  setElementPosition(k,JAIL_X,JAIL_Y,JAIL_Z)
                  setElementInterior(k,6)
                  setElementAlpha(k,255)
            end
            setElementData(thePlayer,DATA_PLAYERS_JAILED,nil)
        end
    else
        outputChatBox(MESSAGE_NOT_INSIDE_MARKER,thePlayer,255,255,255,true)    
    end
end
addCommandHandler(COMMAND,jailPlayer)



--EVENTS
function onPoliceAttack ( attacker, weapon, bodypart, loss ) --when a player is damaged
    if isGuestAccount(getPlayerAccount(attacker)) then return end 
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(attacker)),aclGetGroup(ACL_NAME)) then
        return
    end
    if(weapon == 3 ) then
        if(getPlayerWantedLevel(source) > 0) then
            handcuffPlayer(source,attacker)
        else
            outputChatBox(MESSAGE_ERROR_NOT_WANTED,attacker,255,255,255,true)     
        end
    end
end
addEventHandler ( "onPlayerDamage", getRootElement (), onPoliceAttack )



function letPlayerExitJail(player)
    setElementData(player,DATA_IS_PLAYER_JAIL,false)
    toggleAllControls(player,true,true,true)
    setElementPosition(player,JAIL_OUT_X,JAIL_OUT_Y,JAIL_OUT_Z)
    setElementInterior(player,0)
    outputChatBox(MESSAGE_LET_JAIL,player,255,255,255,true)
    setPlayerWantedLevel(player,0)
end


function mainTimer()

    setTimer(function ()
        for index, player in pairs(getElementsByType("player")) do
            if not getElementData(player,DATA_IS_PLAYER_JAIL) then
                setElementData(player,DATA_TIMER_LEFT,nil)
            else
                local timer = tonumber(getElementData(player,DATA_TIMER_LEFT))
                setElementData(player,DATA_TIMER_LEFT,tonumber(timer-1000))
            end
           
        end
    end,1000,0)
end
mainTimer()

-- addCommandHandler("clear",function (thePlayer,cmd)
--     setElementAlpha(thePlayer,255)
--     setElementCollisionsEnabled(thePlayer,true)
--     detachElements(thePlayer)
--     destroyElement(getElementData(thePlayer,DATA_PED_ELEMENT))
--     toggleAllControls(thePlayer,true,true,true)
--     setElementData(thePlayer,DATA_IS_PLAYER_JAIL,false)
--     setElementData(thePlayer,DATA_TIMER_LEFT,nil)
--     setElementData(thePlayer,DATA_PLAYERS_JAIL,nil)
-- end)


addEventHandler("onPlayerQuit",resourceRoot,function()

        setElementAlpha(source,255)
        setElementCollisionsEnabled(source,true)
        detachElements(source)
        destroyElement(getElementData(source,DATA_PED_ELEMENT))
        toggleAllControls(source,true,true,true)
        setElementData(source,DATA_IS_PLAYER_JAIL,false)
        setElementData(source,DATA_TIMER_LEFT,nil)
        setElementData(source,DATA_PLAYERS_JAIL,nil)
    
end)



addEventHandler("onResourceStop",resourceRoot,function()
    for i,thePlayer in pairs(getElementsByType("player"))do
        setElementAlpha(thePlayer,255)
        setElementCollisionsEnabled(thePlayer,true)
        detachElements(thePlayer)
        if(getElementData(thePlayer,DATA_PED_ELEMENT)) then
            
        destroyElement(getElementData(thePlayer,DATA_PED_ELEMENT))
        end
        toggleAllControls(thePlayer,true,true,true)




        setElementData(thePlayer,DATA_IS_PLAYER_JAIL,nil)
        setElementData(thePlayer,DATA_PLAYERS_JAILED,nil)
        setElementData(thePlayer,DATA_PED_ELEMENT,nil)

        setElementData(thePlayer,DATA_IS_PLAYER_JAIL,nil)
        setElementData(thePlayer,DATA_PLAYERS_JAILED,nil)
        setElementData(thePlayer,DATA_PED_ELEMENT,nil)

        setElementData(thePlayer,DATA_TIMER_LEFT,nil)
        setElementData(thePlayer,DATA_COL_TO_SHOW,nil)
        setElementData(thePlayer,DATA_IS_COL_SHOW,nil)

        setElementData(thePlayer,DATA_PLAYER_SELECTED ,nil)

        setElementData(thePlayer,DATA_IS_PLAYER_HANDCUFF,nil)
    end
end)
 
 
 


 


---EVENTS

addEventHandler("onPlayerQuit",root,function()
    local ped = getElementData(source,DATA_PED_ELEMENT)
    if(ped) then
      --CANCELA EVENTO
      triggerClientEvent ( "followPlayer", ped, source, false )
      detachElements(source,ped) 
      destroyElement(ped)
      --DATAS
      setElementData(source,DATA_PED_ELEMENT,nil)
    end
end)

function isPedContainWeapon(thePed)
    local weapons = 0
    for slot=1, 12 do
        local weapon = getPedWeapon(thePed, slot)
        local ammo = getPedTotalAmmo(thePed, slot)
        if (weapon > 0) and (ammo > 0) then
          
            weapons = 1
        end
    end
    return weapons
end

function getAllPedWeapon(thePed)
    local weapons = { }
    for slot=1, 12 do
        local weapon = getPedWeapon(thePed, slot)
        local ammo = getPedTotalAmmo(thePed, slot)
        if (weapon > 0) and (ammo > 0) then
            weapons[weapon] = ammo
        end
    end
    return weapons
end

function tryJailPlayer (player,state)
 algemarPlayer(player,state)
 if(state) then
    setElementData(player,DATA_IS_PLAYER_HANDCUFF,true)
    triggerClientEvent(player,"showNotificationOnTop",player,MESSAGE_JAILED_PLAYER)

 else
    setElementData(player,DATA_IS_PLAYER_HANDCUFF,false)
    triggerClientEvent(player,"showNotificationOnTop",player,MESSAGE_UNJAILED_PLAYER)

 end
end
addEvent( "tryJailPlayer", true )
addEventHandler( "tryJailPlayer", resourceRoot, tryJailPlayer )




function tryTakeAllWeapons (player)
   if(player) then
    if(isPedContainWeapon(player) > 0) then
        triggerClientEvent(player,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFFVocê teve as armas confiscadas pelo: #FF0000"..client.name)
        triggerClientEvent(client,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFFVocê retirou todas as armas do player: #FF0000"..player.name)
        takeAllWeapons(player)
    else
            triggerClientEvent(player,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFF: #FF0000"..client.name.."#FFFFFF te revistou, mas você não tem nada!")
            triggerClientEvent(client,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFFNada encontrado com o player: #FF0000"..player.name)        
    end
        
    end
   end
   addEvent( "tryTakeAllWeapons", true )
   addEventHandler( "tryTakeAllWeapons", resourceRoot, tryTakeAllWeapons )


   function trySetNivel (player,nivel)
    if(player) then
   
         triggerClientEvent(player,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFFVocê está sendo procurado, nivel: #FF0000"..tostring(nivel),player)
         triggerClientEvent(client,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFFVocê colocou o player: #FF0000"..player.name.. "#FFFFFF sob procura.",client)
        setPlayerWantedLevel(player,tonumber(nivel))
    end
end
addEvent( "trySetNivel", true )
addEventHandler( "trySetNivel", resourceRoot, trySetNivel )

 
   
function tryRevistarPlayer (extern)
    setPedAnimation(client,"police","plc_drgbst_01",3000,false,false,false,false,1000)
    setTimer(function (player,police) 
        if(isPedContainWeapon(player) > 0) then
            triggerClientEvent(police,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFFForam encontradas as seguintes armas:")
            for i,k in pairs(getAllPedWeapon(player)) do
                triggerClientEvent(police,"showNotificationOnTop",player,"#FFFFFF"..tostring(getWeaponNameFromID(i)))
            end
    else
        triggerClientEvent(police,"showNotificationOnTop",player,"#FF0000[POLICE]:#FFFFFFNão foram encontradas armas com o player:#FF0000 "..player.name)
           
    end
    end,3000,1,extern,client)
    
  
end
   addEvent( "tryRevistarPlayer", true )
   addEventHandler( "tryRevistarPlayer", resourceRoot, tryRevistarPlayer) 