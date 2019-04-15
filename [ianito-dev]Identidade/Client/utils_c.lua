function s()
    --triggerServerEvent ( "getMeTimeOnline", resourceRoot, localPlayer )
end
s()




addEvent( "sendToClientTimeOnline", true )
addEventHandler( "sendToClientTimeOnline", localPlayer, function(tempo)
    outputChatBox("Tempo_Cliente: "..tostring(tempo))
end )