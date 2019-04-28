--[[
	@author: ianito
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
function drawText()
    dxDraw3DText("Digite #FF0000/rebocar#FFFFFF para deixar o carro apreendido.",1535.75098, -2228.82739, 13.9688,1.2,nil,nil,12,true)
    dxDraw3DText("#FF0000[DETRAN]#FFFFFF Skin.",1562.57068, -2219.04224, 13.94688,1.2,nil,nil,12,true)
    dxDraw3DText("#FF0000[DETRAN]#FFFFFF Veículo de reboque.",    1562.57068, -2221.54224, 13.94688,1.2,nil,nil,12,true)
end
addEventHandler("onClientRender", root,drawText)



function showCarProperties()
    for index, car in pairs (getElementsByType("vehicle")) do
        if(getElementData(car,IS_CAR_TOWED))then
            local x,y,z = getElementPosition(car)
            dxDraw3DText("#FFa500[DETRAN]#FFFFFFCARRO APREENDIDO.",x,y,z+1.5,1.2,nil,nil,10,true)
			dxDraw3DText("#FFa500[DETRAN]#FFFFFFPor favor, converse com algum funcionário.",x,y,z+1.3,1.2,nil,nil,10,true)
          
        end
    end
end
addEventHandler("onClientRender", root,showCarProperties)






function dxDraw3DText(text, x, y, z, scale, font, color, maxDistance, colorCoded)
	if not (x and y and z) then
		outputDebugString("dxDraw3DText: One of the world coordinates is missing", 1);
		return false;
	end

	if not (scale) then
		scale = 2;
	end
	
	if not (font) then
		font = "default";
	end
	
	if not (color) then
		color = tocolor(255, 255, 255, 255);
	end
	
	if not (maxDistance) then
		maxDistance = 12;
	end
	
	if not (colorCoded) then
		colorCoded = false;
	end
	
	local pX, pY, pZ = getElementPosition( localPlayer );	
	local distance = getDistanceBetweenPoints3D(pX, pY, pZ, x, y, z);
	
	if (distance <= maxDistance) then
		local x, y = getScreenFromWorldPosition(x, y, z);
		
		if (x and y) then
             dxDrawText( text, x, y, _, _, color, scale, font, "center", "center", false, false, false, colorCoded);
           
             return true;
		end
	end
end






