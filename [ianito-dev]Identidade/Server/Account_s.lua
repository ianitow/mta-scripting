function Account_load()
	for i,k in pairs(getElementsByType("player")) do
		local playeraccount = getPlayerAccount (k)
		if ( playeraccount ) and not isGuestAccount ( playeraccount ) then -- if the player is logged in
			setTimer(function (player) 
				if not (getAccountData(playeraccount,FIRST_LOGIN)) then
					triggerClientEvent ( player, "showLoginFirst", player, true )
				end
			end,1000,1,k)	 	
			  outputDebugString("[ianito-dev]Identidade - Players Loaded account")
		end
	end
	
end
addEventHandler ( "onResourceStart", resourceRoot, Account_load )


addEventHandler("onPlayerLogin", root,
  function(previous,current)
    setTimer(function (player) 
		if not ( getAccountData(current,FIRST_LOGIN)) then
			triggerClientEvent ( player, "showLoginFirst", player, true )
		end
	end,200,1,source)	
  end
)



function trySetData(player,table)
	local playerAccount = getPlayerAccount ( player)
	if ( playerAccount ) and not isGuestAccount ( playerAccount ) then 
		setAccountData(playerAccount,FIRST_LOGIN,true)
		setAccountData(playerAccount,NAME_FULL,table['nameFull'])
		setAccountData(playerAccount,AGE,table['age'])
		setAccountData(playerAccount,EMAIL,table['email'])
		setAccountData(playerAccount,SEXO,table['sexo'])
		setAccountData(playerAccount,COUNTRY,table['country'])
		triggerClientEvent ( player, "sendDataToClient", player, "OK" )
		outputChatBox("#FF0000■▼#FFFFFFIdentidade#FF0000■▼  ",player,255,255,255,true)
		outputChatBox("#FFFFFFNome:#FF0000 "..tostring(table['nameFull']),player,255,255,255,true)
		outputChatBox("#FFFFFFIdade:#FF0000 "..tostring(table['age']),player,255,255,255,true)
		outputChatBox("#FFFFFFEmail:#FF0000 "..tostring(table['email']),player,255,255,255,true)
		outputChatBox("#FFFFFFSexo:#FF0000 "..tostring(table['sexo']),player,255,255,255,true)
		outputChatBox("#FFFFFFPaís:#FF0000 "..tostring(table['country']),player,255,255,255,true)
		outputChatBox("#FFFFFF------------------------- ",player,255,255,255,true)
		return true
	end
	triggerClientEvent ( player, "sendDataToClient", player, "ERROR","#FF0000[SERVER]:#FFFFFErro inesperado." )
end



addEvent( "trySetData", true )
addEventHandler( "trySetData", resourceRoot, trySetData) 
