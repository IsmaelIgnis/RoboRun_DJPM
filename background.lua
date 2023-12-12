local background = {}

function background.load()
    -- Carrega recursos do fundo (imagem de fundo, etc.)
    -- Substitua esta parte com as suas próprias definições
    background.x = 0
    background.y = 0
    background.speed = 100 -- Velocidade de movimento do fundo
    background.image = love.graphics.newImage("yee.png") -- Substitua com o caminho correto para a imagem
end

function background.update(dt)
    -- Move o fundo para a esquerda
    background.x = background.x - background.speed * dt
end

function background.draw()
    -- Desenha o fundo em loop para criar um efeito de movimento contínuo
    love.graphics.draw(background.image, background.x, background.y)
    love.graphics.draw(background.image, background.x + background.image:getWidth(), background.y)
end

return background
