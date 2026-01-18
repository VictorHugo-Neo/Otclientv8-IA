-- Configurações
local API_URL = "http://127.0.0.1:8000/v1/chat"
local aiWindow = nil
local chatConsole = nil
local messageInput = nil

function init()
    -- Carrega a UI
    aiWindow = g_ui.displayUI('client_aichat')
    chatConsole = aiWindow:recursiveGetChildById('chatConsole')
    messageInput = aiWindow:recursiveGetChildById('messageInput')

    -- Encaixa no Painel Esquerdo (criado no game_interface)
    local gameInterface = modules.game_interface
    if gameInterface then
        aiWindow:setupOn(gameInterface.getLeftPanel())
    end

    addMessage("Sistema", "Conectado ao AI Brain. Como posso ajudar?")
end

function terminate()
    if aiWindow then
        aiWindow:destroy()
    end
end

function onMiniWindowClose()
    if aiWindow then aiWindow:close() end
end

function addMessage(author, text)
    local label = g_ui.createWidget('UILabel', chatConsole)
    label:setText(author .. ": " .. text)
    label:setTextWrap(true)
    chatConsole:appendItem(label)
    chatConsole:scrollBottom()
end

function sendMessage()
    local message = messageInput:getText()
    if message:len() > 0 then
        local charName = g_game.getCharacterName() or "Player"
        
        -- Mostra sua mensagem
        addMessage(charName, message)
        messageInput:setText('')

        -- Envia para o Microserviço Python
        local payload = {
            character_name = charName,
            message = message
        }

        g_http.post(API_URL, json.encode(payload), function(response, status)
            if status == 200 then
                local reply = json.decode(response)
                addMessage("IA Brain", reply.text)
            else
                addMessage("Sistema", "IA Offline. Erro: " .. status)
            end
        end)
    end
end