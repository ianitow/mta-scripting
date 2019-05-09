local screenW2,screenH2 = guiGetScreenSize()
local resW2, resH2 = 1366,768
local x, y =  (screenW2/resW2), (screenH2/resH2)

color = {}

painelF5 = false
function painelF5Dx()

	color[1] = tocolor(255,255,255,100)
	color[2] = tocolor(255,255,255,100)
	color[3] = tocolor(255,255,255,100)
	color[4] = tocolor(255,255,255,100)
	color[5] = tocolor(255,255,255,100)
	color[6] = tocolor(255,255,255,100)
	color[7] = tocolor(255,255,255,100)
	color[8] = tocolor(255,255,255,100)
	color[9] = tocolor(255,255,255,100)
	color[10] = tocolor(255,255,255,100)
	color[11] = tocolor(255,255,255,100)

	if cursorPosition(x*410, y*340, x*37, y*36) then color[1] = tocolor(245, 245, 220) end
	if cursorPosition(x*560, y*338, x*37, y*36) then color[2] = tocolor(245, 245, 220) end
	if cursorPosition(x*410, y*485, x*53, y*37) then color[3] = tocolor(245, 245, 220) end
	if cursorPosition(x*475, y*473, x*45, y*48) then color[4] = tocolor(245, 245, 220) end
	if cursorPosition(x*752, y*387, x*37, y*36) then color[5] = tocolor(245, 245, 220) end
	if cursorPosition(x*752, y*424, x*37, y*36) then color[6] = tocolor(245, 245, 220) end
	if cursorPosition(x*908, y*387, x*37, y*36) then color[7] = tocolor(245, 245, 220) end
	if cursorPosition(x*908, y*424, x*37, y*36) then color[8] = tocolor(245, 245, 220) end
	if cursorPosition(x*830, y*288, x*37, y*36) then color[9] = tocolor(245, 245, 220) end
	if cursorPosition(x*833, y*495, x*37, y*36) then color[10] = tocolor(245, 245, 220) end
	if cursorPosition(x*528, y*485, x*37, y*36) then color[11] = tocolor(245, 245, 220) end
	if isPedInVehicle( localPlayer ) then 

		dxDrawImage(x*0, y*0, x*1366, y*768, "gfx/bgPanel.png", 0, 0, 0, tocolor(28, 28, 28))
		dxDrawText("Revolution - Painel de Veículo", x*0, y*215, x*1366, y*0, tocolor(255,255,255,255), x*1.6, "default-bold", "center", "top", false, false, false, true, false)
	
		dxDrawText("SUSPENSÃO", x*415, y*310, x*0, y*0, tocolor(255,255,255,255), 1.0, "default-bold", "left", "top", false, false, false, true, false)
		dxDrawImage(x*410, y*340, x*37, y*36, "gfx/down.png", 0,0,0, color[1])
		dxDrawImage(x*560, y*338, x*37, y*36, "gfx/up.png", 0,0,0, color[2])
		
		dxDrawText("", x*415, y*450, x*0, y*0, tocolor(255,255,255,255), 1.0, "default-bold", "left", "top", false, false, false, true, false)
		dxDrawImage(x*410, y*485, x*53, y*37, "gfx/iconMotor.png", 0,0,0, color[3])

	
		local veh = getPedOccupiedVehicle( localPlayer ) 
		if veh then 
			dxDrawImage(x*475, y*473, x*45, y*48, "gfx/iconFlip.png", 0,0,0, color[4])
			dxDrawImage(x*528, y*485, x*53, y*37, "gfx/freio.png", 0,0,0, color[11])
		else
			dxDrawText("", x*415, y*450, x*0, y*0, tocolor(255,255,255,255), 1.0, "default-bold", "left", "top", false, false, false, true, false)
			

		end
	
		dxDrawText("PORTAS", x*760, y*310, x*0, y*0, tocolor(255,255,255,255), 1.0, "default-bold", "left", "top", false, false, false, true, false)
		dxDrawImage(x*752, y*387, x*37, y*36, "gfx/left.png", 0,0,0, color[5])
		dxDrawImage(x*752, y*424, x*37, y*36, "gfx/left.png", 0,0,0, color[6])
		dxDrawImage(x*908, y*387, x*37, y*36, "gfx/right.png", 0,0,0, color[7])
		dxDrawImage(x*908, y*424, x*37, y*36, "gfx/right.png", 0,0,0, color[8])
		dxDrawImage(x*830, y*293, x*37, y*36, "gfx/up.png", 360,0,0, color[9])
		dxDrawImage(x*833, y*495, x*37, y*36, "gfx/down.png", 360,0,0, color[10])

		dxDrawText("", x*0, y*0, x*1366, y*1123, tocolor(255,255,255,255), 1.0, "default-bold", "center", "center", false, false, false, true, false)
	else
		dxDrawRectangle(x*483, y*364, x* 400, y*40, tocolor(28, 28, 28))
		dxDrawRectangle(x*483, y*362, x* 400, y*2, tocolor(255,255,255,255))
		dxDrawText("PEGUE UM VEICULO PARA USA O F1", x*0, y*0, x*1366, y*768, tocolor(255,255,255,255), x*1.6, "default-bold", "center", "center", false, false, false, true, false)
	end
end

function open (_,state)
	if painelF5 == false then
		showCursor(true)
		addEventHandler("onClientRender", root, painelF5Dx)
		painelF5 = true
		playSoundFrontEnd(1)
		setElementData(localPlayer, "_gps", false)
		setElementData(localPlayer, "_hud", false)
		setElementData(localPlayer, "_level", false)
		setTimer(function() showChat(false) end, 500, 1)
		showChat(false)
		showCursor(true)
	else
		playSoundFrontEnd(2)
		showCursor(false)
		removeEventHandler("onClientRender", root, painelF5Dx)
		painelF5 = false
		setTimer(function() showChat(true) end, 500, 1)
		showChat(true)
		showCursor(false)
		setElementData(localPlayer, "_gps", true)
		setElementData(localPlayer, "_hud", true)
		setElementData(localPlayer, "_level", true)
	end
end
addEvent("painel_f5", true)
addEventHandler("painel_f5", root , open)

function click_F5(button, state)
	if painelF5 and button == "left" and state == "down" then
		if cursorPosition(x*410, y*485, x*53, y*37) then
			local veh = getPedOccupiedVehicle(localPlayer)
			if(getVehicleEngineState(veh) == true) then
				setVehicleEngineState(veh,false)
			else
				setVehicleEngineState(veh,true)
			end
			-- triggerServerEvent("F5_repair", getLocalPlayer())
			-- playSoundFrontEnd(46)
		elseif cursorPosition(x*475, y*473, x*45, y*48) then
			triggerServerEvent("F5_flip", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*410, y*340, x*37, y*36) then
			triggerServerEvent("F5_descer", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*560, y*338, x*37, y*36) then
			triggerServerEvent("F5_subir", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*752, y*387, x*37, y*36) then
			triggerServerEvent("F5_esquerda1", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*752, y*424, x*37, y*36) then
			triggerServerEvent("F5_esquerda2", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*908, y*387, x*37, y*36) then
			triggerServerEvent("F5_direita1", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*908, y*424, x*37, y*36) then
			triggerServerEvent("F5_direita2", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*830, y*293, x*37, y*36) then
			triggerServerEvent("F5_cima", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*833, y*495, x*37, y*36) then
			triggerServerEvent("F5_baixo", getLocalPlayer())
			playSoundFrontEnd(20)
		elseif cursorPosition(x*528, y*485, x*37, y*36) then
			if(isElementFrozen(getPedOccupiedVehicle(localPlayer)) == true ) then
				
				setControlState(localPlayer,"handbrake",false)
				setElementFrozen(getPedOccupiedVehicle(localPlayer),false)
			else
				
				setControlState(localPlayer,"handbrake",true)
				setElementFrozen(getPedOccupiedVehicle(localPlayer),true)
			end
	
			playSoundFrontEnd(20)
	
		end
	end
end
addEventHandler("onClientClick", getRootElement(), click_F5)

function cursorPosition(x, y, width, height)
	if (not isCursorShowing()) then
		return false
	end
	local sx, sy = guiGetScreenSize()
	local cx, cy = getCursorPosition()
	local cx, cy = (cx*sx), (cy*sy)
	if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
		return true
	else
		return false
	end
end