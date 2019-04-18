local x,y,z = nil

function checkHealthToCallAnim ( attacker, weapon, bodypart )
    local health = source:getHealth()
    if(health <= HEALTH_MAX) then

        if not (localPlayer:getData(DATA_TO_ANIM)) then
            localPlayer:setData(DATA_TO_ANIM,true)  
            triggerServerEvent ("startAnimSamu", resourceRoot,true )
        end
    end
end

addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), checkHealthToCallAnim)






function onMedicStartJob(medic,pacient)
    
    exports['notification']:addNotification("#FF0000[SAMU]#FFFFFF O médico #FF0000 "..getPlayerName(medic).."#FFFFFF está curando o player: #FF0000"..getPlayerName(pacient), "info", 5000, "top")
	
end

addEvent( "onMedicStartJob", true )
addEventHandler( "onMedicStartJob", localPlayer, onMedicStartJob )



function createPNGImage()
    local screenX,screenY = getScreenFromWorldPosition(x,y,z)
    dxDrawImage(screenX,screenY,48,48,'Gfx/heart.png')
end

function HandleTheRendering (x1,y1,z1)
   x,y,z = x1,y1,z1
    setTimer(function () 
      addEventHandler("onClientRender", root, createPNGImage)  -- Keep everything visible with onClientRender.
    end, 300,1)
    
  
end

addEvent( "createPNGHeart", true )
addEventHandler( "createPNGHeart", localPlayer, HandleTheRendering )



function destroyPNGHeart ()
    removeEventHandler("onClientRender", root, createPNGImage)  -- Keep everything visible with onClientRender.
 end
 
 addEvent( "destroyPNGHeart", true )
 addEventHandler( "destroyPNGHeart", localPlayer, destroyPNGHeart )
 




addCommandHandler("clear",function()
    triggerServerEvent ( "startAnimSamu", resourceRoot,false )
    localPlayer:setData(DATA_TO_ANIM,false)  
end)

addCommandHandler("anim",function()
    triggerServerEvent ( "startAnimSamu", resourceRoot,true )
end)


