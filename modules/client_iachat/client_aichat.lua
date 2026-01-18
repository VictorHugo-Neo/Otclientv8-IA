-- Configurações globais do módulo
local API_URL = "http://127.0.0.1:8000/v1/chat"
local SERVICE_NAME = "IA Brain"

-- Variáveis de controle de UI
local aiWindow = nil
local chatConsole = nil
local messageInput = nil
local isWaitingResponse = false

function init()
    -- 1. Carrega a interface visual definida no .otui
    aiWindow = g_ui.displayUI('client_aichat')
    
    -- 2. Mapeia os componentes internos
    chatConsole = aiWindow:recursiveGetChildById('chatConsole')
    messageInput = aiWindow:recursiveGetChildById('messageInput')

    -- 3. Acopla a janela ao painel lateral esquerdo (definido no game_interface)
    local gameInterface = modules.game_interface
    if gameInterface and gameInterface.getLeftPanel() then
        aiWindow:setupOn(gameInterface.getLeftPanel())
    end

    addMessage("Sistema", "Conectado ao " .. SERVICE_NAME .. ". Como posso ajudar hoje?")
end

function terminate()
    -- Limpeza ao fechar o cliente ou descarregar o módulo
    if aiWindow then
        aiWindow:destroy()
        aiWindow = nil
    end
end

function onMiniWindowClose()
    if aiWindow then
        aiWindow:close()
    end
end

-- Função auxiliar para adicionar mensagens ao console do chat
function addMessage(author, text)
    if not chatConsole then return end
    
    local label = g_ui.createWidget('UILabel', chatConsole)
    label:setText(author .. ": " .. text)
    label:setTextWrap(true) -- Garante que textos longos quebrem a linha
    
    chatConsole:appendItem(label)
    chatConsole:scrollBottom() -- Rola automaticamente para a última mensagem
    
    return label
end

-- Função principal de envio
function sendMessage()
    -- Evita enviar múltiplas mensagens enquanto espera a resposta da IA
    if isWaitingResponse then 
        return 
    end

    local message = messageInput:getText()
    
    if message:len() > 0 then
        isWaitingResponse = true
        
        -- Obtém o nome do personagem logado (ou usa "Player" se offline)
        local charName = g_game.isOnline() and g_game.getCharacterName() or "Player"
        
        -- Exibe a mensagem do jogador localmente e limpa o campo
        addMessage(charName, message)
        messageInput:setText('')

        -- Prepara o payload JSON para o microserviço Python
        local payload = {
            character_name = charName,
            message = message,
            npc_name = "Companion"
        }

        -- Envia a requisição HTTP POST de forma assíncrona
        g_http.post(API_URL, json.encode(payload), function(response, status)
            isWaitingResponse = false
            
            if status == 200 then
                -- Sucesso: Decodifica o JSON retornado pelo FastAPI
                local success, reply = pcall(function() return json.decode(response) end)
                
                if success and reply and reply.text then
                    addMessage(SERVICE_NAME, reply.text)
                else
                    addMessage("Sistema", "Erro ao processar resposta da IA.")
                end
            else
                -- Falha na conexão ou erro no servidor Python
                addMessage("Sistema", "IA Offline ou erro no servidor (Status: " .. tostring(status) .. ")")
            end
        end)
    end
end