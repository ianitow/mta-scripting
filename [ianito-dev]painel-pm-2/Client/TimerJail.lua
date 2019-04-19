--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("TimerJail", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end

end).getSuperclass()

function TimerJail:init()
	super.init(self)
	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))
 
	
    self.panelExtern = Panel()
    self.panelExtern:setSize(300,50)
    self.panelExtern:setLocation(self.screenX/2 - (300/2),5)
    self.panelExtern:setBackground(50,50,50,255)
	self.panelExtern:setBorder(LineBorder(tocolor(0,0,0),2))

	self:add(self.panelExtern)

    self.panelTitle = Panel()
    self.panelTitle:setBounds(0,0,self.panelExtern:getWidth(),20)
    self.panelTitle:setBackground(0,0,0,200)
    self.panelExtern:add(self.panelTitle)
  

    self.labelTitle = Label("Você está preso.")
    self.labelTitle:setForeground(tocolor(255,255,255,255))
    self.labelTitle:setBackground(tocolor(255,255,255,1))
    self.labelTitle:setScale(1)
    self.labelTitle:setBounds(0,0,self.panelTitle:getWidth(),self.panelTitle:getHeight())
    self.labelTitle:setAlignment(Label.CENTER)
    self.panelTitle:add(self.labelTitle)

    self.labelTimer = Label("Tempo até ser solto: #ACACAC2:32 minutos")
    self.labelTimer:setForeground(tocolor(255,255,255,255))
    self.labelTimer:setBackground(tocolor(255,255,255,1))
    self.labelTimer:setScale(1)
    self.labelTimer:setBounds(5,self.panelTitle:getHeight()+self.panelTitle:getY(),self.panelTitle:getWidth(),30)
    self.labelTimer:setAlignment(Label.CENTER)
    self.panelTitle:add(self.labelTimer)
    self:setVisible(false)
  
    return self
end

function TimerJail:updateTime()
   
    if(getElementData(localPlayer,DATA_IS_PLAYER_JAIL)) then
       local timer = getElementData(localPlayer,DATA_TIMER_LEFT)
      self:setVisible(true)
      self.labelTimer:setText("Tempo até ser solto: #ACACAC"..tostring(formatMilliExtens(tonumber(timer))))
    else
      self:setVisible(false)
    end
end

addEventHandler("onClientRender",root,function ()
    TimerJail.getInstance():updateTime()
end)

function formatMilliExtens(milli)
	local minute = math.floor(milli / 60000)
	local seconds =   math.floor(milli / 1000)
	if(minute < 1) then
		return (seconds < 10 and "0"..seconds or seconds) .." segundos."
	else
		seconds = math.floor(milli/1000) - (minute * 60) 
		return minute .." minutos e ".. (seconds < 10 and "0"..seconds or seconds).." segundos."
	end
end





addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(TimerJail.getInstance())
end)


