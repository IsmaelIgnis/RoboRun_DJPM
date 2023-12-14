local enemy = {}

function enemy.load()
    -- Lista para armazenar os inimigos
    enemy.list = {}
    enemy.speed = 250 -- Velocidade de movimento dos inimigos
end

function enemy.update(dt)
    -- Cria um novo inimigo em intervalos aleatórios
    if math.random(100) < 2 then
        local newEnemy = {
            x = love.graphics.getWidth(), -- Posição inicial à direita da tela
            y = love.graphics.getHeight() - 80, -- Ajusta a altura do inimigo para estar no chão
            width = 60, -- Aumenta a largura do inimigo
            height = 80, -- Aumenta a altura do inimigo
        }
        table.insert(enemy.list, newEnemy)
    end

    -- Move todos os inimigos para a esquerda
    for i, e in ipairs(enemy.list) do
        e.x = e.x - enemy.speed * dt

        -- Remove os inimigos que saem completamente da tela
        if e.x + e.width < 0 then
            table.remove(enemy.list, i)
        end
    end
end

function enemy.draw()
    -- Desenha todos os inimigos
    love.graphics.setColor(1, 0, 0) -- Cor vermelha para os inimigos (ajuste conforme necessário)
    for _, e in ipairs(enemy.list) do
        love.graphics.rectangle("fill", e.x, e.y, e.width, e.height)
    end
end

return enemy
