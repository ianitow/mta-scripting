function replaceModel()
txd = engineLoadTXD('car.txd',585)
engineImportTXD(txd,585)
dff = engineLoadDFF('car.dff',585)
engineReplaceModel(dff,585)
end
addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()), replaceModel)
addCommandHandler ( 'reloadcar', replaceModel )