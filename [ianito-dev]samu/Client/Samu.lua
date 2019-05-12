--[[
	@author: ianito
	@since:1.0
	@website: www.iaandeveloper.com
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("Samu", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end

end).getSuperclass()
function Samu:init()
    super.init(self)
    self:css([[
        button {
            color: #FFFFFF;
            background-color: #990000;
            cursor: pointer;
        }
        button:hover {
            color: #FFFFFF;
            background-color: #770000;
            cursor: pointer;
        }
        button:active{
            color: #FFFFFF;
            background-color: #AA0000;
            cursor: pointer;
        }    
        
          
        ]])

	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))

    self.effectDeath = Panel()
    self.effectDeath:setZOrder(-1)
    self.effectDeath.decorator = true
    self.effectDeath:setBounds(0,0,self.screenX,self.screenY)
    self.effectDeath:setBackground(0,0,0,150)
    self:add(self.effectDeath)


    self.lblImageHeart = Image()
	self.lblImageHeart:setSource("/Gfx/heart.png")
	self.lblImageHeart:setBounds(0,0,self.lblImageHeart:getImageWidth(),self.lblImageHeart:getImageHeight())
	self.lblImageHeart:setColor(tocolor(255,0,0,self.currentAlpha))
	
    self:setVisible(false)
    return self
end



addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(Samu.getInstance())
end)
    
