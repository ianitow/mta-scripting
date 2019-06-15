--[[
	@author: ianito
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local commands = 
{
    ['rebocar'] = function (player) 

        if(hasPlayerIsInACL(player,ACL_DETRAN)) then
            local elementsInsideMarker = getElementsWithinMarker(LET_VEHICLE_MARKER)
            
            local x,y,z = getElementPosition(player)
            local distance = getDistanceBetweenPoints3D(x,y,z,getElementPosition(LET_VEHICLE_MARKER));
            local vehicleDetran = getElementData(player,CAR_DETRAN_ELEMENT)
            local pedVehicle = getPedOccupiedVehicle(player)
            if(distance > 10) then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você está longe do marker de reboque.",player,255,255,255,true)
                return false
            end
            if not vehicleDetran then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pegou seu veículo no DETRAN.",player,255,255,255,true)
                return false
            end
            if not pedVehicle then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não está dentro de um veículo.",player,255,255,255,true)
                return false
            end

            local isDetranCar = getElementData(pedVehicle,IS_DETRAN_CAR)
            if(isDetranCar) then
                local towedElement = getElementData(vehicleDetran,CAR_TOWED_ELEMENT)
                if not towedElement then
                    outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não possui nenhum veículo na caçamba..",player,255,255,255,true)
                    return false;
                end
                if(isCarAllowed(getVehicleType(towedElement))) then
                    local park = getParkEmpty()
                    if not park then
                        outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Patio cheio, por favor, aguarde.",player,255,255,255,true)
                        return false;
                    end
                    local vehicleDetran = getElementData(player,CAR_DETRAN_ELEMENT)
                    if(addCar(vehicleDetran,preco)) then
                        playSoundFrontEnd(player,12)
                        setElementData(vehicleDetran,CAR_TOWED_ELEMENT,nil)
                        outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFCarro adicionado ao pátio.",player,255,255,255,true)
                        return true
                    else
                        outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFPatio lotado, por favor, libere espaço.",player,255,255,255,true)
                    end
                else
                    outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Este tipo de carro não é permitido o reboque.",player,255,255,255,true)
                end
            else
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não está dentro de um veículo do detran..",player,255,255,255,true)
                return false;
            end
        else
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pertence ao DETRAN.",player,255,255,255,true)

        end
    end;
    ['liberar'] = function (player) 
        if(hasPlayerIsInACL(player,ACL_DETRAN)) then
            if(getElementData(player,MARKER_PLAYER_INSIDE) ~= nil) then
                local seatTable = getSeatByMarkerElement(getElementData(player,MARKER_PLAYER_INSIDE))
                if(seatTable) then
                   if(unlockCar(seatTable)) then
                    outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFCarro liberado!!",player,255,255,255,true)
                    playSoundFrontEnd(player,5)
                   end
                end
            else
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não está dentro de um marker.",player,255,255,255,true)
            end
        else
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pertence ao DETRAN.",player,255,255,255,true)
        end
    end;
    ['guinchar'] = function (player)
        if(hasPlayerIsInACL(player,ACL_DETRAN)) then
            local pedVehicle = getPedOccupiedVehicle(player)
            local vehicleDetran = getElementData(player,CAR_DETRAN_ELEMENT)
            local isDetranCar = getElementData(pedVehicle,IS_DETRAN_CAR)
            if(isDetranCar) then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pode guinchar um veículo do detran.",player,255,255,255,true)
                
                return false
            end

            if not pedVehicle then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não está dentro de um veículo.",player,255,255,255,true)
                return false
            end
            if not vehicleDetran then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pegou seu veículo no DETRAN.",player,255,255,255,true)
                return false
            end
            local xPed,yPed,zPed = getElementPosition(pedVehicle)
            local distanceBetweenCars = getDistanceBetweenPoints3D(xPed,yPed,zPed,getElementPosition(vehicleDetran))
            if(distanceBetweenCars >3) then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Muito longe, por favor, chegue mais perto.",player,255,255,255,true)
                return false;
            end
            if getElementData(vehicleDetran,CAR_TOWED_ELEMENT) then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Já existe um veículo no carro, por favor, leve ao pátio do DETRAN.",player,255,255,255,true)
                return false
            end
            attachCars(vehicleDetran,pedVehicle)
            playSoundFrontEnd(player,46)
        else
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pertence ao DETRAN.",player,255,255,255,true)
        end
    end;
    ['soltar'] = function (player)
        if(hasPlayerIsInACL(player,ACL_DETRAN)) then
            local vehicleDetran = getElementData(player,CAR_DETRAN_ELEMENT)
            if not vehicleDetran then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pegou seu veículo no DETRAN.",player,255,255,255,true)
                return false
            end
            if not getElementData(vehicleDetran,CAR_TOWED_ELEMENT) then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Não existe nenhum carro na caçamba.",player,255,255,255,true)
                return false
            end
            if(detachCars(vehicleDetran)) then
                outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFCarro liberado com sucesso.",player,255,255,255,true)
                playSoundFrontEnd(player,46)
            end
        else
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000Você não pertence ao DETRAN.",player,255,255,255,true)
        end
    end;
    ['multar'] = function(player,targetPlayer,price)
        if(hasPlayerIsInACL(player,ACL_DETRAN)) then
        local playerElement = getPlayerFromName(targetPlayer)
        if not price then 
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFF Preço não informado.",player,255,255,255,true)
              return 
            end
        if not playerElement then
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFF Player não encontrado.",player,255,255,255,true)
            return 
        end
        if player == playerElement then
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFF Não é possível se multar.",player,255,255,255,true)
            return
        end
        if(tonumber(price) > tonumber(DEFAULT_PRICE_LIMIT)) then
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFLimite máximo de "..COLOR_MESSAGE_ORANGE.." RS"..tostring(DEFAULT_PRICE_LIMIT),player,255,255,255,true)
            return
        end
        local x,y,z = getElementPosition(player)
        local x1,y2,z2 = getElementPosition(playerElement)
        if(getDistanceBetweenPoints3D(x,y,z,x1,y2,z2) <= 10) then
            takePlayerMoney(playerElement,price)
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFVocê foi multado pelo "..COLOR_MESSAGE_ORANGE..getPlayerName(player).. "#FFFFFF em "..COLOR_MESSAGE_ORANGE..tostring(price),playerElement,255,255,255,true)
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FF0000A multa foi atríbuída com sucesso.",player,255,255,255,true)
        else
            outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFVocê está muito longe do player.",player,255,255,255,true)
        end
    else
        outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFVocê não pertence ao DETRAN.",player,255,255,255,true)
    end
    end
}
addCommandHandler("multar",function (player,cmd,targetPlayer,price)
    return commands['multar'](player,targetPlayer,price)
end)
addCommandHandler("guinchar",function (player,cmd)
    return commands['guinchar'](player)
end)

addCommandHandler("soltarveiculo",function (player,cmd)
    return commands['soltgar'](player)
end)

addCommandHandler("liberarcarro",function (player,cmd)
    return commands['liberar'](player)
end)

addCommandHandler("rebocar",function (player,cmd)
    return commands['rebocar'](player)
end)


addCommandHandler("detran",function(player,cmd,type,...)
    
        outputChatBox(COLOR_MESSAGE_ORANGE.."[DETRAN]:#FFFFFFComandos do Detran:",player,255,255,255,true)
        outputChatBox(COLOR_MESSAGE_ORANGE.."/guinchar - #FFFFFFPara adicionar o carro na caçamba.",player,255,255,255,true)
        outputChatBox(COLOR_MESSAGE_ORANGE.."/rebocar - #FFFFFFPara deixar um carro rebocado no pátio.",player,255,255,255,true)
        outputChatBox(COLOR_MESSAGE_ORANGE.."/liberarcarro - #FFFFFFPara destravar um carro. ",player,255,255,255,true)
        outputChatBox(COLOR_MESSAGE_ORANGE.."/soltarveiculo - #FFFFFFPara soltar um carro da caçamba. ",player,255,255,255,true)
        outputChatBox(COLOR_MESSAGE_ORANGE.."/multar (nick) (preço) - #FFFFFFPara multar um player. ",player,255,255,255,true)
       
    
end)