--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("PainelPM", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end

end).getSuperclass()

function PainelPM:init()
	super.init(self)
	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))
 
	self:css([[
button {
	color: #FFFFFF;
	background-color:  #03396c;
	cursor: pointer;
}
button:hover {
	color: #FFFFFF;
	background-color: #005b96;
	cursor: pointer;
}
button:active{
	color: #FFFFFF;
	background-color: #6497b1;
	cursor: pointer;
}    

  
]])

    self.panelExtern = Panel()
    self.panelExtern:setBounds(Graphics.getInsets(0,0,247,0))
    self.panelExtern:setSize(425,480)
    self.panelExtern:setLocation(self.screenX/3,self.screenY/4.5)
    self.panelExtern:setBackground(0,0,0,150)
	self.panelExtern:setBorder(LineBorder(tocolor(0,0,0),2))

	self:add(self.panelExtern)

    self.panelTitle = Panel()
    self.panelTitle:setBounds(0,0,self.panelExtern:getWidth(),55)
    self.panelTitle:setBackground(0,0,0,200)
    self.panelExtern:add(self.panelTitle)
  

    self.labelTitle = Label("Painel Policia")
    self.labelTitle:setForeground(tocolor(255,255,255,255))
    self.labelTitle:setBackground(tocolor(255,255,255,1))
    self.labelTitle:setScale(1.2)
    self.labelTitle:setBounds(0,0,self.panelTitle:getWidth(),self.panelTitle:getHeight())
    self.labelTitle:setAlignment(Label.CENTER)
    self.panelTitle:add(self.labelTitle)
    self:setVisible(true)

    self.iconPolice = Image()
	self.iconPolice:setSource("Gfx/police-icon.png")
	self.iconPolice:setLocation(5,(self.panelTitle:getY()) + 5)
    self.iconPolice:setSize(48,48)
    self.panelExtern:add(self.iconPolice)

    self.iconPolice = Image()
	self.iconPolice:setSource("Gfx/police-icon.png")
	self.iconPolice:setLocation(self.panelTitle:getWidth()-self.iconPolice:getWidth()-50,(self.panelTitle:getY()) + 5)
    self.iconPolice:setSize(48,48)
    self.panelExtern:add(self.iconPolice)

    self.avatarLogo = Image()
    self.avatarLogo:setSource("Gfx/logo.png")
    self.avatarLogo:setBorder(LineBorder(tocolor(0,0,0),1))
	self.avatarLogo:setLocation(15,(self.panelTitle:getY()+self.panelTitle:getHeight()) + 5)
    self.avatarLogo:setSize(150,150)
    self.panelExtern:add(self.avatarLogo)

    self.panelDecorator = Panel()
    self.panelDecorator:setSize(self.panelExtern:getWidth(),30)
    self.panelDecorator:setLocation(0,self.avatarLogo:getHeight()+self.avatarLogo:getY()+5)
    self.panelDecorator:setBackground(0,0,0,150)
	self.panelDecorator:setBorder(LineBorder(tocolor(0,0,0),2))
    self.panelExtern:add(self.panelDecorator)


    self.panelInfoPlayer = Panel()
    self.panelInfoPlayer:setSize(250,150)
    self.panelInfoPlayer:setLocation(self.avatarLogo:getWidth()+self.avatarLogo:getX()+5,self.avatarLogo:getY())
    self.panelInfoPlayer:setBackground(0,0,0,150)
	--self.panelInfoPlayer:setBorder(LineBorder(tocolor(0,0,255),2))
    self.panelExtern:add(self.panelInfoPlayer)

    self.panelTitle = Panel()
    self.panelTitle:setBounds(0,0,self.panelInfoPlayer:getWidth(),25)
    self.panelTitle:setBackground(0,0,0,200)
    self.panelInfoPlayer:add(self.panelTitle)

    self.labelTitle = Label("Informações do Suspeito")
    self.labelTitle:setForeground(tocolor(255,255,255,255))
    self.labelTitle:setBackground(tocolor(255,255,255,1))
    self.labelTitle:setScale(1)
    self.labelTitle:setBounds(0,0,self.panelInfoPlayer:getWidth(),20)
    self.labelTitle:setAlignment(Label.CENTER)
    self.panelInfoPlayer:add(self.labelTitle)

    self.labelNameSuspect = Label("Nome: #FF0000ianito")
    self.labelNameSuspect:setForeground(tocolor(255,255,255,255))
    self.labelNameSuspect:setBackground(tocolor(255,255,255,1))
    self.labelNameSuspect:setScale(1)
    self.labelNameSuspect:setBounds(5,self.labelTitle:getHeight()+self.labelTitle:getY()+5,self.panelInfoPlayer:getWidth(),20)
    self.labelNameSuspect:setAlignment(Label.LEFT)
    self.panelInfoPlayer:add(self.labelNameSuspect)

    self.labelHealth = Label("Vida: #FF0000100%")
    self.labelHealth:setForeground(tocolor(255,255,255,255))
    self.labelHealth:setBackground(tocolor(255,255,255,1))
    self.labelHealth:setScale(1)
    self.labelHealth:setBounds(5,self.labelNameSuspect:getHeight()+self.labelNameSuspect:getY()+5,self.panelInfoPlayer:getWidth(),20)
    self.labelHealth:setAlignment(Label.LEFT)
    self.panelInfoPlayer:add(self.labelHealth)

    self.labelArmor = Label("Colete: #DCDCDC68%")
    self.labelArmor:setForeground(tocolor(255,255,255,255))
    self.labelArmor:setBackground(tocolor(255,255,255,1))
    self.labelArmor:setScale(1)
    self.labelArmor:setBounds(5,self.labelHealth:getHeight()+self.labelHealth:getY()+5,self.panelInfoPlayer:getWidth(),20)
    self.labelArmor:setAlignment(Label.LEFT)
    self.panelInfoPlayer:add(self.labelArmor)

    self.labelMoney = Label("Dinheiro: #00FF00R$9876")
    self.labelMoney:setForeground(tocolor(255,255,255,255))
    self.labelMoney:setBackground(tocolor(255,255,255,1))
    self.labelMoney:setScale(1)
    self.labelMoney:setBounds(5,self.labelArmor:getHeight()+self.labelArmor:getY()+5,self.panelInfoPlayer:getWidth(),20)
    self.labelMoney:setAlignment(Label.LEFT)
    self.panelInfoPlayer:add(self.labelMoney)

    self.dataRegistro = Label("Data de Registro: #DCDCDC18/04/2019")
    self.dataRegistro:setForeground(tocolor(255,255,255,255))
    self.dataRegistro:setBackground(tocolor(255,255,255,1))
    self.dataRegistro:setScale(1)
    self.dataRegistro:setBounds(5,self.labelMoney:getHeight()+self.labelMoney:getY()+5,self.panelInfoPlayer:getWidth(),20)
    self.dataRegistro:setAlignment(Label.LEFT)
    self.panelInfoPlayer:add(self.dataRegistro)



    self.labelTitle = Label("Comandos")
    self.labelTitle:setForeground(tocolor(255,255,255,255))
    self.labelTitle:setBackground(tocolor(255,255,255,1))
    self.labelTitle:setScale(1.2)
    self.labelTitle:setBounds(0,0,self.panelDecorator:getWidth(),self.panelDecorator:getHeight())
    self.labelTitle:setAlignment(Label.CENTER)
    self.panelDecorator:add(self.labelTitle)

    
   

    self.panelCommands = Panel()
    self.panelCommands:setSize(self.panelExtern:getWidth(),225)
    self.panelCommands:setLocation(0,self.panelDecorator:getHeight()+self.panelDecorator:getY()+5)
    self.panelCommands:setBackground(0,0,0,150)
	--self.panelCommands:setBorder(LineBorder(tocolor(0,0,255),2))
    self.panelExtern:add(self.panelCommands)

    self.buttonAlgemar = Button("ALGEMAR")
    self.buttonAlgemar:setBounds(5,5,self.panelCommands:getWidth()-10,40)
    self.buttonAlgemar:setStyleClass("btnLogin")
	self.buttonAlgemar:addMouseListener(self)
    self.panelCommands:add(self.buttonAlgemar)

    self.buttonRevistar = Button("REVISTAR")
    self.buttonRevistar:setBounds(5,self.buttonAlgemar:getHeight()+self.buttonAlgemar:getY()+5,self.panelCommands:getWidth()-10,40)
    self.buttonRevistar:setStyleClass("btnLogin")
	self.buttonRevistar:addMouseListener(self)
    self.panelCommands:add(self.buttonRevistar)
    
    self.buttonPorte = Button("SETAR NIVEL")
    self.buttonPorte:setBounds(5,self.buttonRevistar:getHeight()+self.buttonRevistar:getY()+5,self.panelCommands:getWidth()-10,40)
    self.buttonPorte:setStyleClass("btnLogin")
	self.buttonPorte:addMouseListener(self)
    self.panelCommands:add(self.buttonPorte)

    self.buttonCheckCNH = Button("CHECAR CNH")
    self.buttonCheckCNH:setBounds(5,self.buttonPorte:getHeight()+self.buttonPorte:getY()+5,self.panelCommands:getWidth()-10,40)
    self.buttonCheckCNH:setStyleClass("btnLogin")
	self.buttonCheckCNH:addMouseListener(self)
    self.panelCommands:add(self.buttonCheckCNH)

    self.buttonTakeWeapon = Button("PEGAR ARMAS / DROGAS")
    self.buttonTakeWeapon:setBounds(5,self.buttonCheckCNH:getHeight()+self.buttonCheckCNH:getY()+5,self.panelCommands:getWidth()-10,40)
    self.buttonTakeWeapon:setStyleClass("btnLogin")
	self.buttonTakeWeapon:addMouseListener(self)
    self.panelCommands:add(self.buttonTakeWeapon)

    
    self:setVisible(false)
    self.onPlayerPressKey = function (button,press)
        for i,k in pairs(getElementsByType("colshape")) do
            if(isElementWithinColShape(localPlayer,k)) then
                if(getElementData(k,DATA_IS_COL_SHOW)) then
                    if(button == BUTTON_OPEN)then
                        if(isChatBoxInputActive ()) then return end
                        if(press) then
                            if not self:isVisible() then
                                self:setVisible(true)
                                showCursor(true)
                                
                            else
                               self:setVisible(false)
                                showCursor(false)
                            end
                        end
                    end
                end
            end
        
        end
        
       
    end
    
    addEventHandler( "onClientKey", root, self.onPlayerPressKey) 
    return self
end
local pedActual = nil 
function eventOnEnter()
    dxDrawTextOnElement(pedActual,"Pressione N para abrir o painel",1.2,20,255,255,255,255,1.3,"sans")
end





function PainelPM.onPoliceEnterCol(shape,matchingDimension)
   if(matchingDimension) then
        if(getElementData(shape,DATA_IS_COL_SHOW)) then
            pedActual = shape
            addEventHandler("onClientRender",root,eventOnEnter)
            setElementData(source,DATA_PLAYER_SELECTED,getElementData(shape,DATA_PLAYER_SELECTED))
        end
    end
end
function PainelPM.onPoliceLeaveCol(shape,matchingDimension)
    if(matchingDimension) then
         if(getElementData(shape,DATA_IS_COL_SHOW)) then
            removeEventHandler("onClientRender",root,eventOnEnter)
            setElementData(source,DATA_PLAYER_SELECTED,nil)
         end
     end
 end

showCursor(false)

addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(PainelPM.getInstance())

    for i,k in pairs(getElementsByType("player"))do
        if not (k == localPlayer) then
            local x,y,z = getElementPosition(k)
            local col = createColSphere(x,y,z,1.5)
            attachElements(col,k)
            setElementData(k,DATA_COL_TO_SHOW,col)
            setElementData(col,DATA_PLAYER_SELECTED,k)
            setElementData(col,DATA_IS_COL_SHOW,true)
            addEventHandler("onClientElementColShapeHit",root,PainelPM.onPoliceEnterCol)
            addEventHandler("onClientElementColShapeLeave",root,PainelPM.onPoliceLeaveCol)
            outputChatBox("EVEND ADD")
        end
       
    end
end)

function PainelPM:mousePressed(e)
	if(e:getButton() == MouseEvent.BUTTON1) then
        if(e.source == self.buttonAlgemar) then
            local p = getElementData(localPlayer,DATA_PLAYER_SELECTED)
            triggerServerEvent ( "tryJailPlayer", resourceRoot,p)
            showCursor(false)
            self:setVisible(false)
        end
	end
end

    -- Since mouse_wheel_up and mouse_wheel_down cant return a release, we dont have to check the press.
 

