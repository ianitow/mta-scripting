
local screenW,screenH = guiGetScreenSize()
local resW, resH = 1024, 768
local x, y =  (screenW/resW), (screenH/resH)
local painel = false

addEventHandler("onClientResourceStart", resourceRoot,
    function()
	
        homem = guiCreateCheckBox(x*491, y*491, x*88, y*29, "MASCULINO", false, false)
        guiSetFont(homem, "default-bold-small")

        mulher = guiCreateCheckBox(x*593, y*491, x*81, y*29, "FEMININO", false, false)
        guiSetFont(mulher, "default-bold-small")

        brasil = guiCreateCheckBox(x*491, y*530, x*107, y*29, "BRASILEIRO", false, false)
        guiSetFont(brasil, "default-bold-small")

        estrageiro = guiCreateCheckBox(x*593, y*530, x*107, y*29, "ESTRANGEIRO", false, false)
        guiSetFont(estrageiro, "default-bold-small")

        nome = guiCreateEdit(x*476, y*375, x*212, y*28, "", false)
		guiEditSetMaxLength ( nome, 35 )
		
        idade = guiCreateEdit(x*477, y*413, x*67, y*30, "", false) 
		guiEditSetMaxLength ( idade, 2 )

        email = guiCreateEdit(x*477, y*453, x*212, y*28, "", false)
        guiEditSetMaxLength ( email, 35 )
		
        Visible(false)
		
    end
)

function Visible(confg)
guiSetVisible(homem, confg)
guiSetVisible(mulher, confg)
guiSetVisible(brasil, confg)
guiSetVisible(estrageiro, confg)
guiSetVisible(nome, confg)
guiSetVisible(email, confg)
guiSetVisible(idade, confg)
end


function dx ()
    local nomew = getPlayerName(localPlayer) or "N/A"
	local vida = getElementHealth(localPlayer) or "N/A"
	local colete = getPedArmor(localPlayer) or "N/A"
	local horas = getElementData(localPlayer, "Tempo") or "N/A"
	local localizacao_cidade = getElementData(localPlayer,"City") or "N/A"
	local localizacao_pais = getElementData(localPlayer,"Country") or "N/A"
	local anim,_,_= interpolateBetween(0, 0, 0, 505, 0, 0, ((getTickCount() - ident) / 2000), "OutBounce")
	local gui,fade,fade2= interpolateBetween(0, 0, 0, 1, 255, 198, ((getTickCount() - ident) / 2000), "Linear")
	local fade3,fade4,_= interpolateBetween(0, 0, 0, 156, 146, 0, ((getTickCount() - ident) / 2000), "Linear")
	local segundos = getTickCount() / 500
	local angle = math.sin(segundos) * 2
	
        guiSetAlpha ( homem, gui )
        guiSetAlpha ( mulher, gui )
        guiSetAlpha ( brasil, gui )
        guiSetAlpha ( estrageiro, gui )
        guiSetAlpha ( nome, gui )
        guiSetAlpha ( idade, gui )
        guiSetAlpha ( email, gui )
	
        Retangulo(252, 137, 492, anim, tocolor(0, 0, 0, fade3), false)
        Retangulo(252, 137, 492, 59, tocolor(255, 255, 255, fade2), false)
		Borda(x*252, y*137, x*492, y*anim, tocolor(255, 255, 255, fade3), 2)	
        Imagem(300, 221, 120, 129, "gfx/logo.png", angle, 0, 0, tocolor(255, 255, 255, fade), false)
        Texto(string.upper("NICK: "..nomew.."#FFFFFF\n\n  VIDA: "..math.floor(tonumber(vida)).."%\n\n  COLETE: "..math.floor(tonumber(colete)).."%\n\n  HORAS JOGADAS: "..horas.."\n\n  LOCALIZAÇÂO: "..localizacao_cidade.." - "..localizacao_pais..""), 420, 206, 725, 368, tocolor(255, 255, 255, fade), 1.00, "default-bold", "center", "center", false, false, false, true, false)
        Texto("NOME: ", 315, 374, 435, 403, tocolor(255, 255, 255, fade), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        Texto("IDADE:", 315, 413, 435, 442, tocolor(255, 255, 255, fade), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        Texto("EMAIL:", 315, 452, 435, 481, tocolor(255, 255, 255, fade), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        Texto("SEXO:", 315, 491, 435, 520, tocolor(255, 255, 255, fade), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        Texto("NACIONALIDADE:", 315, 530, 435, 559, tocolor(255, 255, 255, fade), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        Texto("INFORMAÇÕES DO JOGADOR", 252, 137, 744, 196, tocolor(0, 0, 0, fade), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		if Mouse (x*422, y*579, x*161, y*37) then
        Retangulo(422, 579, 161, 37, tocolor(255, 255, 255, fade), false)
		else
        Retangulo(422, 579, 161, 37, tocolor(255, 255, 255, fade4), false)		
		end
        Texto("SALVAR", 422, 579, 583, 616, tocolor(0, 0, 0, fade), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function Texto (a,b,c,d,e,f,g,h,i,j,k,l,m,n,o)
    dxDrawText(a, x*b, y*c, x*d, y*e, f, x*g, h, i, j, k, l, m, n, o)
end

function Retangulo (a,b,c,d,e,f)
    dxDrawRectangle(x*a, y*b, x*c, y*d, e, f)
end

function Imagem (a,b,c,d,e,f,g,h,i,j)
    dxDrawImage(x*a, y*b, x*c, y*d, e, f, g, h, i, j)
end

function Borda(a,b,c,d,e,f)
    dxDrawLine(a, b, a+c, b, e, f,false)
    dxDrawLine(a, b, a, b+d, e, f,false)
    dxDrawLine(a, b+d, a+c, b+d, e, f,false)
    dxDrawLine(a+c, b, a+c, b+d, e, f,false)
end

addEventHandler("onClientGUIClick", resourceRoot, function( ) 
    if source == homem then  
        if guiCheckBoxGetSelected(source) then 
            guiCheckBoxSetSelected(mulher, false)
        end 
    elseif source == mulher then 
        if guiCheckBoxGetSelected(source) then 
            guiCheckBoxSetSelected(homem, false)
        end 
    end 
end) 

addEventHandler("onClientGUIClick", resourceRoot, function( ) 
    if source == brasil then  
        if guiCheckBoxGetSelected(source) then 
            guiCheckBoxSetSelected(estrageiro, false)
        end 
    elseif source == estrageiro then 
        if guiCheckBoxGetSelected(source) then 
            guiCheckBoxSetSelected(brasil, false)
        end 
    end 
end) 

function Save (_,state)
if painel == true then
if state == "down" then
if Mouse (x*422, y*579, x*161, y*37) then
local nomee = guiGetText(nome)
local idadee = guiGetText(idade)
local emaill = guiGetText(email)
if (string.len(nomee) == 0) then
outputChatBox ( "Você esqueceu do seu nome, verifique e tente novamente." , 255, 255, 255, true)  return end

if (string.len(nomee) < 5) then
outputChatBox ( "Seu nome é muito curto, verifique e tente novamente." , 255, 255, 255, true)  return end

if (string.find (nomee, '%d' )) then
outputChatBox ( "Seu nome nao pode conter numeros, verifique e tente novamente." , 255, 255, 255, true)  return end

if (string.len(idadee) == 0) then
outputChatBox ( "Você esqueceu da sua idade, verifique e tente novamente." , 255, 255, 255, true)  return end

if tonumber(idadee) < 5 or tonumber(idadee) > 50 then
outputChatBox ( "Sua idade é invalida, verifique e tente novamente." , 255, 255, 255, true)  return end

if (string.len(emaill) == 0) then
outputChatBox ( "Você esqueceu do seu email, verifique e tente novamente." , 255, 255, 255, true)  return end

if (string.len(emaill) < 5) then
outputChatBox ( "Seu email é muito curto, verifique e tente novamente." , 255, 255, 255, true)  return end

if not (string.find (emaill, '@' )) then
outputChatBox ( "Seu email esta incorreto, verifique e tente novamente." , 255, 255, 255, true)  return end

if not (string.find (emaill, '.com' )) then
outputChatBox ( "Seu email esta incorreto, verifique e tente novamente." , 255, 255, 255, true)  return end

if not guiCheckBoxGetSelected(homem) and not guiCheckBoxGetSelected(mulher) then
outputChatBox ( "Você precisa selecionar o sexo, verifique e tente novamente." , 255, 255, 255, true)  return end

if (guiCheckBoxGetSelected(homem))then
    sexoo = "Masculino"
elseif (guiCheckBoxGetSelected(mulher))then
    sexoo = "Feminino"
end

if not guiCheckBoxGetSelected(brasil) and not guiCheckBoxGetSelected(estrageiro) then
outputChatBox ( "Você precisa selecionar a nacionalidade, verifique e tente novamente." , 255, 255, 255, true)  return end

if (guiCheckBoxGetSelected(brasil))then
    nacionalidade = "Brasileiro"
elseif (guiCheckBoxGetSelected(estrageiro))then
    nacionalidade = "Estrangeiro"
end

triggerServerEvent("Salvar_identidade", getLocalPlayer(), nomee, idadee, emaill, sexoo, nacionalidade)

removeEventHandler("onClientRender", root, dx)
showCursor(false)
Visible(false)
guiSetInputEnabled(false)
setElementData ( localPlayer, "shader", false )
painel = false

end
end
end
end
addEventHandler ("onClientClick", root, Save)

function abrir ()
if painel == false then
showCursor(true)
Visible(true)
showCursor(true)
addEventHandler("onClientRender", root, dx)
setElementData ( localPlayer, "shader", true )
ident = getTickCount()
guiSetInputMode("no_binds")
painel = true
end
end
addEvent("Painel_identidade", true)
addEventHandler("Painel_identidade", getRootElement(), abrir)

local x,y = guiGetScreenSize()
function Mouse (x,y,w,h)
 local mx,my = getCursorPosition ()
 local fullx,fully = guiGetScreenSize()
 cursorx,cursory = mx*fullx,my*fully
 if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
  return true
 else
  return false
 end
end