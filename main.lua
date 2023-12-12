local player = require("player")
local background = require("background")

function love.load()
    -- Carrega o jogador
    player.load()

    -- Carrega o background
    background.load()

    -- Define a gravidade
    gravity = 800

    -- Define a velocidade inicial de pulo e a força do pulo
    jumpVelocity = -300
    canJump = true

    -- Inicializa a janela do jogo em modo de tela cheia
    local screenWidth, screenHeight = love.window.getDesktopDimensions()
    love.window.setMode(screenWidth, screenHeight, {fullscreen = true})

    -- Define o título da janela do jogo
    love.window.setTitle("Jogo de Personagem")
end

function love.update(dt)
    -- Atualiza o jogador
    player.update(dt)

    -- Atualiza o background
    background.update(dt)

    -- Verifica se o jogador pode pular
    if love.keyboard.isDown("space") and canJump then
        player.dy = jumpVelocity
        canJump = false
    end

    -- Aplica a gravidade ao jogador
    player.y = player.y + player.dy * dt
    player.dy = player.dy + gravity * dt

    -- Movimenta o fundo para dar sensação de movimento do jogador


    -- Verifica se o jogador está no chão
    if player.y >= 300 then
        player.y = 300
        canJump = true
    end
end

function love.draw()
    -- Desenha o fundo
    background.draw()

    -- Desenha o jogador na posição x e y
    player.draw()
end
