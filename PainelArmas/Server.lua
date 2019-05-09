-- #############################
-- ## Weapons Transfer System ##
-- ## By : |Mr|-Talal07-|     ##
-- ## Side : Server           ##
-- #############################

addEvent("SendWeapon",true)
addEventHandler("SendWeapon",root,
	function (player,id,ammo)
		local id = tonumber(id)
		local ammo = tonumber(ammo)
		local x,y,z = getElementPosition(source)
		local x1,y1,z1 = getElementPosition(player)
		if ( getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) > 5) then
			outputChatBox("#0000FF[REVOLUTION]#FFFFFF Você está muito longe do player",source,255,0,0,true)
			
			return false
		else
			if not (getElementData(source,"ianito-dev.timer")) then
				giveWeapon(player,id,ammo)
				takeWeapon(source,id,ammo)
				outputChatBox("##0069c7 Voc� enviou #ff0000" .. getWeaponNameFromID(id) .. "#0069c7Para:#ff0000" .. getPlayerName(player),source,255,0,0,true)
				outputChatBox("# " .. getPlayerName(source) .. " #0069c7Enviou#ff0000" .. getWeaponNameFromID(id) .. " #0069c7Para Voc� Com #ff0000" .. ammo .. " #0069c7Muni��o",player,255,0,0,true)
				setElementData(source,"ianito-dev.timer",true)
				setTimer(function(p)
					setElementData(p,"ianito-dev.timer",nil)
				end,5000,1,source)
				
			else
				outputChatBox("#0000FF[REVOLUTION]#FFFFFF Aguarde alguns segundos.",source,255,0,0,true)
			
				return false
			end
		end
		end
)
