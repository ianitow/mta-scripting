--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("DadosPlayer", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end

end).getSuperclass()
function DadosPlayer:init()
	super.init(self)
	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))
 
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

    self.panelExtern = Panel()
    self.panelExtern:setBounds(Graphics.getInsets(0,0,self.screenX/6.8,0))
    self.panelExtern:setSize(self.panelExtern:getWidth(),430)
    self.panelExtern:setLocation(self.screenX/1.9,self.screenY/4.5)
    self.panelExtern:setBackground(0,0,0,150)
	self.panelExtern:setBorder(LineBorder(tocolor(255,255,255),2))

	self:add(self.panelExtern)

    self.panelTitle = Panel()
    self.panelTitle:setBounds(0,0,self.panelExtern:getWidth(),55)
    self.panelTitle:setBackground(255,255,255,200)
    self.panelExtern:add(self.panelTitle)
    self:setVisible(true)

    self.labelTitle = Label("DADOS POLICIA")
    self.labelTitle:setForeground(tocolor(0,0,0,255))
    self.labelTitle:setBackground(tocolor(255,255,255,1))
    self.labelTitle:setScale(1.2)
    self.labelTitle:setBounds(0,0,self.panelTitle:getWidth(),self.panelTitle:getHeight())
    self.labelTitle:setAlignment(Label.CENTER)
    self.panelTitle:add(self.labelTitle)

   
    self.panelNivel = Panel()
    self.panelNivel:setBounds(Graphics.getInsets(0,0,140,0))
    self.panelNivel:setSize(self.panelNivel:getWidth(),50)
    self.panelNivel:setLocation((self.panelExtern:getWidth()-self.panelNivel:getWidth())/2,self.panelTitle:getY()+self.panelTitle:getHeight()+20)
    self.panelNivel:setBorder(LineBorder(tocolor(255,255,255,50),2))
    self.panelNivel:setBackground(tocolor(0,0,0,120))
    self.panelExtern:add(self.panelNivel)

    self.labelNivel = Label("Nível: 6")
    self.labelNivel:setForeground(tocolor(255,255,255,255))
    self.labelNivel:setBackground(tocolor(0,0,0))
    self.labelNivel:setScale(2.2)
    self.labelNivel:setBounds(0,0,self.panelNivel:getWidth(),self.panelNivel:getHeight())
    self.labelNivel:setAlignment(Label.CENTER)
    self.panelNivel:add(self.labelNivel)


    self.panelStar = Panel()
    self.panelStar:setBounds(Graphics.getInsets(0,0,100,0))
    self.panelStar:setSize(self.panelStar:getWidth(),230)
    self.panelStar:setLocation(20,self.panelNivel:getY()+self.panelNivel:getHeight()+20)
    self.panelStar:setBorder(LineBorder(tocolor(255,255,255,50),2))
    self.panelStar:setBackground(tocolor(0,0,0,120))
    self.panelExtern:add(self.panelStar)










    self.panelTitleStar = Panel()
    self.panelTitleStar:setBounds(self.panelStar:getX(),self.panelStar:getY(),self.panelStar:getWidth(),35)
    self.panelTitleStar:setZOrder(99)
    self.panelTitleStar:setBorder(LineBorder(tocolor(0,0,0),1))
    self.panelTitleStar:setBackground(255,255,255,200)
    self.panelExtern:add(self.panelTitleStar)
    self:setVisible(true)

    self.labelTitleStar = Label("ADICIONAR ESTRELA")
    self.labelTitleStar:setForeground(tocolor(255,255,255,255))
    self.labelTitleStar:setBackground(tocolor(0,0,0))
    self.labelTitleStar:setScale(1.2)
    self.labelTitleStar:setBounds(0,0,self.panelTitleStar:getWidth(),self.panelTitleStar:getHeight())
    self.labelTitleStar:setAlignment(Label.CENTER)
    self.panelTitleStar:add(self.labelTitleStar)

    local colorStar = tocolor(120,120,120,120)
    --STAR 1
        self.starOne = Panel()
        self.starOne:setSize(self.panelStar:getWidth()-5,30)
        self.starOne:setLocation(2,self.panelTitleStar:getHeight())
        self.starOne:setBorder(LineBorder(tocolor(255,255,255,255),1))
        self.starOne:setBackground(colorStar)
        self.panelStar:add(self.starOne)

        self.labelStarOne = Label("1 - Estrelas")
        self.labelStarOne:setForeground(tocolor(255,255,255,255))
        self.labelStarOne:setBackground(tocolor(0,0,0))
        self.labelStarOne:setScale(1.2)
        self.labelStarOne:setBounds(0,0,self.starOne:getWidth(),self.starOne:getHeight())
        self.labelStarOne:setAlignment(Label.CENTER)
        self.starOne:add(self.labelStarOne)

    --START 2
        self.starTwo = Panel()
        self.starTwo:setSize(self.panelStar:getWidth()-5,30)
        self.starTwo:setLocation(2,self.starOne:getHeight()+self.starOne:getY()+2)
        self.starTwo:setBorder(LineBorder(tocolor(255,255,255,255),1))
        self.starTwo:setBackground(colorStar)
        self.panelStar:add(self.starTwo)

        self.labelStarTwo = Label("2 - Estrelas")
        self.labelStarTwo:setForeground(tocolor(255,255,255,255))
        self.labelStarTwo:setBackground(tocolor(0,0,0))
        self.labelStarTwo:setScale(1.2)
        self.labelStarTwo:setBounds(0,0,self.starTwo:getWidth(),self.starTwo:getHeight())
        self.labelStarTwo:setAlignment(Label.CENTER)
        self.starTwo:add(self.labelStarTwo)

    --START 3
        self.starThree = Panel()
        self.starThree:setSize(self.panelStar:getWidth()-5,30)
        self.starThree:setLocation(2,self.starTwo:getHeight()+self.starTwo:getY()+2)
        self.starThree:setBorder(LineBorder(tocolor(255,255,255,255),1))
        self.starThree:setBackground(colorStar)
        self.panelStar:add(self.starThree)

        self.labelStarThree = Label("3 - Estrelas")
        self.labelStarThree:setForeground(tocolor(255,255,255,255))
        self.labelStarThree:setBackground(tocolor(0,0,0))
        self.labelStarThree:setScale(1.2)
        self.labelStarThree:setBounds(0,0,self.starThree:getWidth(),self.starThree:getHeight())
        self.labelStarThree:setAlignment(Label.CENTER)
        self.starThree:add(self.labelStarThree)

    --START 4
        self.starFour = Panel()
        self.starFour:setSize(self.panelStar:getWidth()-5,30)
        self.starFour:setLocation(2,self.starThree:getHeight()+self.starThree:getY()+2)
        self.starFour:setBorder(LineBorder(tocolor(255,255,255,255),1))
        self.starFour:setBackground(colorStar)
        self.panelStar:add(self.starFour)

        self.labelStarFour = Label("4 - Estrelas")
        self.labelStarFour:setForeground(tocolor(255,255,255,255))
        self.labelStarFour:setBackground(tocolor(0,0,0))
        self.labelStarFour:setScale(1.2)
        self.labelStarFour:setBounds(0,0,self.starFour:getWidth(),self.starFour:getHeight())
        self.labelStarFour:setAlignment(Label.CENTER)
        self.starFour:add(self.labelStarFour)
    --START 5
        self.startFive = Panel()
        self.startFive:setSize(self.panelStar:getWidth()-5,30)
        self.startFive:setLocation(2,self.starFour:getHeight()+self.starFour:getY()+2)
        self.startFive:setBorder(LineBorder(tocolor(255,255,255,255),1))
        self.startFive:setBackground(colorStar)
        self.panelStar:add(self.startFive)

        self.labelStarFive = Label("5 - Estrelas")
        self.labelStarFive:setForeground(tocolor(255,255,255,255))
        self.labelStarFive:setBackground(tocolor(0,0,0))
        self.labelStarFive:setScale(1.2)
        self.labelStarFive:setBounds(0,0,self.startFive:getWidth(),self.startFive:getHeight())
        self.labelStarFive:setAlignment(Label.CENTER)
        self.startFive:add(self.labelStarFive)
    --START 36
        self.starSix = Panel()
        self.starSix:setSize(self.panelStar:getWidth()-5,30)
        self.starSix:setLocation(2,self.startFive:getHeight()+self.startFive:getY()+2)
        self.starSix:setBorder(LineBorder(tocolor(255,255,255,255),1))
        self.starSix:setBackground(colorStar)
        self.panelStar:add(self.starSix)

        self.labelStarSix = Label("6 - Estrelas")
        self.labelStarSix:setForeground(tocolor(255,255,255,255))
        self.labelStarSix:setBackground(tocolor(0,0,0))
        self.labelStarSix:setScale(1.2)
        self.labelStarSix:setBounds(0,0,self.starSix:getWidth(),self.starSix:getHeight())
        self.labelStarSix:setAlignment(Label.CENTER)
        self.starSix:add(self.labelStarSix)


    
    self.panelPena = Panel()
    self.panelPena:setBounds(Graphics.getInsets(0,0,100,0))
    self.panelPena:setSize(self.panelPena:getWidth(),230)
    self.panelPena:setLocation(self.panelStar:getX()+self.panelStar:getWidth()+20,self.panelNivel:getY()+self.panelNivel:getHeight()+20)
    self.panelPena:setBorder(LineBorder(tocolor(255,255,255,50),2))
    self.panelPena:setBackground(tocolor(0,0,0,120))
    self.panelExtern:add(self.panelPena)


    


    self.panelTitlePena = Panel()
    self.panelTitlePena:setBounds(self.panelPena:getX(),self.panelPena:getY(),self.panelPena:getWidth(),35)
    self.panelTitlePena:setZOrder(99)
    self.panelTitlePena:setBorder(LineBorder(tocolor(0,0,0),1))
    self.panelTitlePena:setBackground(255,255,255,200)
    self.panelExtern:add(self.panelTitlePena)
    self:setVisible(true)

    self.labelTitlePena = Label("PENA MÁXIMA")
    self.labelTitlePena:setForeground(tocolor(255,255,255,255))
    self.labelTitlePena:setBackground(tocolor(0,0,0))
    self.labelTitlePena:setScale(1.2)
    self.labelTitlePena:setBounds(0,0,self.panelTitleStar:getWidth(),self.panelTitleStar:getHeight())
    self.labelTitlePena:setAlignment(Label.CENTER)
    self.panelTitlePena:add(self.labelTitlePena)

--TEMPOS

    --STAR 1
    self.timeOne = Panel()
    self.timeOne:setSize(self.panelStar:getWidth()-5,30)
    self.timeOne:setLocation(2,self.panelTitlePena:getHeight())
    self.timeOne:setBorder(LineBorder(tocolor(255,255,255,255),1))
    self.timeOne:setBackground(colorStar)
    self.panelPena:add(self.timeOne)

    self.labelStarOne = Label("10 - Minutos")
    self.labelStarOne:setForeground(tocolor(255,255,255,255))
    self.labelStarOne:setBackground(tocolor(0,0,0))
    self.labelStarOne:setScale(1.2)
    self.labelStarOne:setBounds(0,0,self.starOne:getWidth(),self.starOne:getHeight())
    self.labelStarOne:setAlignment(Label.CENTER)
    self.timeOne:add(self.labelStarOne)

--START 2
    self.timeTwo = Panel()
    self.timeTwo:setSize(self.panelStar:getWidth()-5,30)
    self.timeTwo:setLocation(2,self.starOne:getHeight()+self.starOne:getY()+2)
    self.timeTwo:setBorder(LineBorder(tocolor(255,255,255,255),1))
    self.timeTwo:setBackground(colorStar)
    self.panelPena:add(self.timeTwo)

    self.labelTimeTwo = Label("20 - Minutos")
    self.labelTimeTwo:setForeground(tocolor(255,255,255,255))
    self.labelTimeTwo:setBackground(tocolor(0,0,0))
    self.labelTimeTwo:setScale(1.2)
    self.labelTimeTwo:setBounds(0,0,self.timeTwo:getWidth(),self.timeTwo:getHeight())
    self.labelTimeTwo:setAlignment(Label.CENTER)
    self.timeTwo:add(self.labelTimeTwo)

--START 3
    self.timeThree = Panel()
    self.timeThree:setSize(self.panelStar:getWidth()-5,30)
    self.timeThree:setLocation(2,self.timeTwo:getHeight()+self.timeTwo:getY()+2)
    self.timeThree:setBorder(LineBorder(tocolor(255,255,255,255),1))
    self.timeThree:setBackground(colorStar)
    self.panelPena:add(self.timeThree)

    self.labelTimeThree = Label("30 - Minutos")
    self.labelTimeThree:setForeground(tocolor(255,255,255,255))
    self.labelTimeThree:setBackground(tocolor(0,0,0))
    self.labelTimeThree:setScale(1.2)
    self.labelTimeThree:setBounds(0,0,self.timeThree:getWidth(),self.timeThree:getHeight())
    self.labelTimeThree:setAlignment(Label.CENTER)
    self.timeThree:add(self.labelTimeThree)

--START 4
    self.timeFour = Panel()
    self.timeFour:setSize(self.panelStar:getWidth()-5,30)
    self.timeFour:setLocation(2,self.timeThree:getHeight()+self.timeThree:getY()+2)
    self.timeFour:setBorder(LineBorder(tocolor(255,255,255,255),1))
    self.timeFour:setBackground(colorStar)
    self.panelPena:add(self.timeFour)

    self.labelStarFour = Label("40 - Minutos")
    self.labelStarFour:setForeground(tocolor(255,255,255,255))
    self.labelStarFour:setBackground(tocolor(0,0,0))
    self.labelStarFour:setScale(1.2)
    self.labelStarFour:setBounds(0,0,self.timeFour:getWidth(),self.timeFour:getHeight())
    self.labelStarFour:setAlignment(Label.CENTER)
    self.timeFour:add(self.labelStarFour)
--START 5
    self.timeFive = Panel()
    self.timeFive:setSize(self.panelStar:getWidth()-5,30)
    self.timeFive:setLocation(2,self.timeFour:getHeight()+self.timeFour:getY()+2)
    self.timeFive:setBorder(LineBorder(tocolor(255,255,255,255),1))
    self.timeFive:setBackground(colorStar)
    self.panelPena:add(self.timeFive)

    self.labelTimeFive = Label("60 - Minutos")
    self.labelTimeFive:setForeground(tocolor(255,255,255,255))
    self.labelTimeFive:setBackground(tocolor(0,0,0))
    self.labelTimeFive:setScale(1.2)
    self.labelTimeFive:setBounds(0,0,self.timeFive:getWidth(),self.timeFive:getHeight())
    self.labelTimeFive:setAlignment(Label.CENTER)
    self.timeFive:add(self.labelTimeFive)
--START 36
    self.timeSix = Panel()
    self.timeSix:setSize(self.panelStar:getWidth()-5,30)
    self.timeSix:setLocation(2,self.startFive:getHeight()+self.startFive:getY()+2)
    self.timeSix:setBorder(LineBorder(tocolor(255,255,255,255),1))
    self.timeSix:setBackground(colorStar)
    self.panelPena:add(self.timeSix)

    self.labelTimeSix = Label("6 - Estrelas")
    self.labelTimeSix:setForeground(tocolor(255,255,255,255))
    self.labelTimeSix:setBackground(tocolor(0,0,0))
    self.labelTimeSix:setScale(1.2)
    self.labelTimeSix:setBounds(0,0,self.timeSix:getWidth(),self.timeSix:getHeight())
    self.labelTimeSix:setAlignment(Label.CENTER)
    self.timeSix:add(self.labelTimeSix)











    
    self.buttonJail = Button("PRENDER")
    self.buttonJail:setBounds((self.panelExtern:getWidth()/2)-300/2,self.panelExtern:getHeight()-50,300,40)
    
    self.buttonJail:setStyleClass("btnLogin")
	self.buttonJail:addMouseListener(self)
	self.panelExtern:add(self.buttonJail)

    return self
end


addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(DadosPlayer.getInstance())
end)


