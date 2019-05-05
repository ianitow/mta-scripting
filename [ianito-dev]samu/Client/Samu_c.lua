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



function showPaciente(paciente)
    
    exports['notification']:addNotification("#FF0000[SAMU]#FFFFFF O player #FF0000"..paciente.name.."#FFFFFF necessita de ajuda!", "info", 5000, "top")
	
end

addEvent( "showPaciente", true )
addEventHandler( "showPaciente", localPlayer, showPaciente )


function onMedicStartJob(medic,pacient)
    
    exports['notification']:addNotification("#FF0000[SAMU]#FFFFFFVocê está curando o player: #FF0000"..getPlayerName(pacient), "info", 5000, "top")
	
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
 