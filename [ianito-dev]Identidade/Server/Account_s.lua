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
	static.configs = 
	{
		['nome'] = nil,
		['idade'] = nil,
		['email'] = nil,
		['sexo'] = nil,
		['nacionalidade'] = nil,
		['armas_liberadas'] = nil
	}

end).getSuperclass()

--[[
	function Account:init()
	return:void
	description:Default Constructor
]]--
function Account:init()
	super.init(self)
	self.database =  Connection("sqlite","accounts_identidade.db")
	if self.database then 
		outputDebugString( "Identidade - DB created")
	end
return self
end
