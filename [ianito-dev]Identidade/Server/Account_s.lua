--[[
	@author: ianito
	@since: 1.0
	@website: www.iaandeveloper.com
	@description: Account System
]]--


local super = Class("Account",LuaObject,function ()	
	static.getInstance = function()
        return LuaObject.getSingleton(static)
	end
	static.database = nil;
 	
end).getSuperclass()

--[[
	function Account:init()
	return:void
	description:Default Constructor
]]--
function Account:init()
	super.init(self)
	if not Account.database then
		Account.database = Connection("sqlite","accounts_identidade.db")
		outputDebugString( "Identidade - DB created")
	else
		outputDebugString( "Identidade - DB loaded")

	else
	end


	
	 addEventHandler("onResourceStop", resourceRoot,
	function ()
		self:onResourceStop()
	end)

    addEventHandler("onPlayerQuit", root,
	function ()
		self: onPlayerQuit(source)
	end)	
	return self	
end


--[[
	function Account:onPlayerQuit(player)
	return:void
	description:When player quit, save data in database.
]]--
function Account:onPlayerQuit(player)
	outputDebugString("login: onPlayerQuit")
	self: saveData(player)
	return true
end

--[[
	function Account:onResourceStop()
	return:void
	description:When resources stop, save all data in database.
]]--
function Account:onResourceStop() 
	for index,player in pairs (getElementsByType('player')) do
		self:saveData(player)
	end	
	outputDebugString("login: onResourceStop")
end

--[[
	function Account:onResourceStart()
	return:void
	description:Initialize the instance.
]]--
addEventHandler('onResourceStart',resourceRoot,
function ()
   	Account()
  end)

  