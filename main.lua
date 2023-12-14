local player = require("player")
local background = require("background")
local enemy = require("enemy")
local loseFont

local isPlayerAlive = true -- Variável de estado para controlar se o jogador está vivo
local distanciaPercorrida = 0 -- Variável para rastrear a distância percorrida pelo jogador

function love.load()
    -- Carrega o jogador
    player.load()

    -- Carrega o background
    background.load()

    -- Carrega os inimigos
    enemy.load()

    -- Carrega a fonte para a tela de perda
    loseFont = love.graphics.newFont(48)

    -- Define a gravidade
    gravity = 1200


    -- Inicializa a janela do jogo em modo de tela cheia
    local screenWidth, screenHeight = love.window.getDesktopDimensions()
    love.window.setMode(screenWidth, screenHeight, {fullscreen = true})

    -- Define o título da janela do jogo
    love.window.setTitle("Jogo de Personagem")
end

function love.update(dt)
    -- Atualiza a distância percorrida pelo jogador
    distanciaPercorrida = distanciaPercorrida + background.speed * dt

    if isPlayerAlive then
        -- Atualiza o jogador
        player.update(dt)

        -- Atualiza o background
        background.update(dt)

        -- Atualiza os inimigos
        enemy.update(dt)

        -- Verifica se o jogador pode pular
        if love.keyboard.isDown("space") and canJump then
            player.dy = jumpVelocity
            canJump = false
        end

        -- Verifica a colisão entre jogador e inimigos
        for _, e in ipairs(enemy.list) do
            if CheckCollision(player.x, player.y, player.width, player.height, e.x, e.y, e.width, e.height) then
                -- Colisão detectada, o jogador "morreu"
                -- Aqui você pode adicionar lógica para reiniciar o jogo, exibir uma mensagem, etc.
                print("Você bateu em um inimigo! GAME OVER!")
                isPlayerAlive = false -- Define o jogador como morto
                --love.event.quit() -- Encerra o jogo
            end
        end
        
        
        
    end    
end

function love.draw()

    love.graphics.setColor(1, 1, 1) -- Define a cor padrão (branco) antes de desenhar

    -- Desenha o fundo
    background.draw()

    -- Desenha o jogador na posição x e y
    player.draw()

    -- Desenha os inimigos
    enemy.draw()

    if not isPlayerAlive then
        -- Desenha a tela de perda (lose screen) com a nova fonte
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

        love.graphics.setColor(1, 0, 0)
        love.graphics.setFont(loseFont) -- Define a fonte para o texto da tela de perdat())


        love.graphics.printf("Morreste! E contigo a oportunidade de salvar o mundo \nPressione R para reiniciar.", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    end

    -- Configuração da fonte para a mensagem
    local font = love.graphics.newFont(18)
    love.graphics.setFont(font)

    -- Configuração da cor do texto
    love.graphics.setColor(1, 1, 1) -- Cor branca para o texto

    -- Posicionamento e exibição da mensagem
    local distancia = "Distância percorrida: " .. math.floor(background.getDistance()) .. " metros"
    local textWidth = font:getWidth(distancia)
    love.graphics.print(distancia, love.graphics.getWidth() - textWidth - 20, 20)
end

function love.keypressed(key)
    if not isPlayerAlive and key == "r" then
        -- Reinicia o jogo se o jogador estiver morto e pressionar a tecla "r"
        RestartGame()
    end
end

function RestartGame()
    -- Reinicia as variáveis do jogo para o estado inicial
    isPlayerAlive = true

    -- Reinicia a posição do jogador
    player.x = 50
    player.y = 300

    -- Reinicia a lista de inimigos
    enemy.list = {}

    -- Reinicia a distância percorrida pelo fundo
    background.distanceTraveled = 0
end

-- Função para verificar a colisão entre dois retângulos
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end
