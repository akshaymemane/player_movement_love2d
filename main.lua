local Player = require "player"

function love.load()
    player = Player:new(400, 200, {
        speed = 200,
        allowJump = true,
        jumpStrength = 400,
        gravity = 800,
        allowDash = true,
        dashSpeed = 500,
        dashTime = 0.12,
        dashCooldown = 0.5,
        width = 32,
        height = 32,
        allowDoubleJump = true
    })
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end