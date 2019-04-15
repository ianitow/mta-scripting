function start()
	setTimer(function ()
		for i,k in pairs (getElementsByType("player")) do
			local playeraccount = getPlayerAccount ( k )
			if ( playeraccount ) and not isGuestAccount ( playeraccount ) then 
				local lastTime = getElementData(k,TIMER_VARIABLE)
				lastTime = (lastTime and lastTime or 0)
				setAccountData ( playeraccount, TIMER_VARIABLE, lastTime+1 ) 
		  end
        end
    end,1000,0)
end
addEventHandler ( "onResourceStart", resourceRoot, start )

function getMeTimeOnline(player)
	local playeraccount = getPlayerAccount ( player)
	if ( playeraccount ) and not isGuestAccount ( playeraccount ) then 
		local lastTime = getAccountData(playeraccount,TIMER_VARIABLE)
		lastTime = (lastTime and lastTime or 0)
		setAccountData ( playeraccount, TIMER_VARIABLE, lastTime+1 ) 
		triggerClientEvent ( player, "sendToClientTimeOnline", player,lastTime+1 )
		return true;
  end

end

addEvent( "getMeTimeOnline", true )
addEventHandler( "getMeTimeOnline", resourceRoot, getMeTimeOnline )