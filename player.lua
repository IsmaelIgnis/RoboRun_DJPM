local player = {}


function player.load()
    -- Variáveis para as dimensões e posição do robô
    player.x = 50
    player.y = love.graphics.getHeight() - 80 -- Ajusta a altura do jogador para estar no chão
    player.width = 60 -- Aumenta a largura do jogador
    player.height = 80 -- Aumenta a altura do jogador

    -- Inicializa a velocidade vertical (dy) do robô
    player.dy = 0

    -- Define a gravidade e se o jogador pode pular
    jumpVelocity = -600
    canJump = true
end

function player.update(dt)
    -- Aplica a gravidade ao jogador
    player.y = player.y + player.dy * dt
    player.dy = player.dy + gravity * dt

    -- Verifica se o jogador está no chão
    if player.y >= love.graphics.getHeight() - player.height then
        player.y = love.graphics.getHeight() - player.height
        canJump = true
    end
end

function player.draw()
    -- Desenha o corpo do robô (retângulo principal)
    love.graphics.setColor(0.5, 0.5, 0.8) -- Cor azul claro
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

    -- Desenha a cabeça do robô (círculo)
    love.graphics.setColor(0.7, 0.7, 0.9) -- Cor azul mais claro
    love.graphics.circle("fill", player.x + player.width / 2, player.y - 20, 20)

    -- Desenha os olhos do robô (dois círculos menores dentro da cabeça)
    love.graphics.setColor(1, 1, 1) -- Cor branca para os olhos
    love.graphics.circle("fill", player.x + player.width / 2 - 8, player.y - 30, 5)
    love.graphics.circle("fill", player.x + player.width / 2 + 8, player.y - 30, 5)

    -- Desenha os braços do robô (dois retângulos)
    love.graphics.setColor(0.5, 0.5, 0.8) -- Cor azul claro
    love.graphics.rectangle("fill", player.x - 10, player.y + 10, 10, 40)
    love.graphics.rectangle("fill", player.x + player.width, player.y + 10, 10, 40)
end

return player
