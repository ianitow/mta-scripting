local LIMIT = 260

function playSoundRepair()
    local x,y,z = getElementPosition(source)
    playSound3D ( "gfx/repair.mp3",x,y,z)
end
addEvent("playSoundRepair",true)
addEventHandler("playSoundRepair",root,playSoundRepair)

function checkCars()
    for i,k in pairs(getElementsByType("vehicle")) do
        if not (getElementData(k,"REPAIR:isAttachedEvent")) then
          
            addEventHandler("onClientVehicleDamage", k,function(attacker,weapon,loss)
                local total = tonumber(getElementHealth(source) - loss) 
                if((total - loss ) <= LIMIT) then
                    setElementHealth(source,LIMIT)
                    local ped = getVehicleOccupant(source)
                    if(ped) then
                        if not getElementData(localPlayer,"timer.message") then
                            triggerServerEvent("outputChatBoxServer",root,"#FF0000[REPARO]:#FFFFFFVeículo estragado, por favor, chame um mecânico.",ped)
                            setElementData(localPlayer,"timer.message",true)
                            setTimer(function()
                                setElementData(localPlayer,"timer.message",false)
                            end,2000,1)
                        end
                        toggleControl("accelerate",false)
                        toggleControl("brake_reverse",false)
                    end
                    setVehicleEngineState ( source, false )
                    
                    cancelEvent()
                end
            end)
          
            setElementData(k,"REPAIR:isAttachedEvent",true)
        end  
    end
end


setTimer(checkCars,1000,0)
