local background = {}

function background.load()
    -- Carrega recursos do fundo (imagem de fundo, etc.)
    -- Substitua esta parte com as suas próprias definições
    background.x = 0
    background.y = 0
    background.speed = 200 -- Velocidade de movimento do fundo
    background.image = love.graphics.newImage("yee2.png") -- Substitua com o caminho correto para a imagem
    background.distanceTraveled = 0 -- Distância percorrida pelo fundo
end

function background.update(dt)
    -- Move o fundo para a esquerda
    background.x = background.x - background.speed * dt

    -- Verifica se o fundo saiu completamente da tela
    if background.x <= -background.image:getWidth() then
        background.x = 0
    end

    -- Atualiza a distância percorrida com base na velocidade do fundo
    background.distanceTraveled = background.distanceTraveled + background.speed * dt
end

function background.draw()
    -- Desenha duas imagens em loop para criar um efeito de movimento contínuo
    love.graphics.draw(background.image, background.x, background.y)
    love.graphics.draw(background.image, background.x + background.image:getWidth(), background.y)
end

function background.getDistance()
    return background.distanceTraveled
end

return background