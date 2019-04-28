




function applyMods() 
    txd = engineLoadTXD ( "models/detran.txd" )
    dff = engineLoadDFF ( "models/detran.dff" )
    
    engineImportTXD ( txd, 578 ) 
    engineReplaceModel ( dff, 578 )
end 
addEventHandler("onClientResourceStart", resourceRoot, applyMods) 