local Player = {}
Player.__index = Player

function Player:new(x, y, config)
    config = config or {}
    local obj = {
        x = x or 0,
        y = y or 0,
        vx = 0,
        vy = 0,
        speed = config.speed or 200,
        allowJump = config.allowJump or false,
        jumpStrength = config.jumpStrength or 400,
        gravity = config.gravity or 800,
        onGround = false,
        allowDash = config.allowDash or false,
        dashSpeed = config.dashSpeed or 400,
        dashTime = config.dashTime or 0.15,
        dashCooldown = config.dashCooldown or 0.5,
        dashTimer = 0,
        dashCooldownTimer = 0,
        isDashing = false,
        width = config.width or 32,
        height = config.height or 32,
        allowDoubleJump = config.allowDoubleJump or false,
        doubleJumped = false,
    }
    setmetatable(obj, self)
    return obj
end

function Player:update(dt)
    -- Horizontal movement
    local move = 0
    if love.keyboard.isDown("right") then move = move + 1 end
    if love.keyboard.isDown("left") then move = move - 1 end

    if self.isDashing then
        self.dashTimer = self.dashTimer - dt
        if self.dashTimer <= 0 then
            self.isDashing = false
            self.dashCooldownTimer = self.dashCooldown
        end
    elseif self.allowDash and self.dashCooldownTimer <= 0 and love.keyboard.isDown("lshift") and move ~= 0 then
        self.isDashing = true
        self.dashTimer = self.dashTime
        self.vx = move * self.dashSpeed
    else
        self.vx = move * self.speed
        if self.dashCooldownTimer > 0 then
            self.dashCooldownTimer = self.dashCooldownTimer - dt
        end
    end

    -- Jumping (platformer style) with double jump
    if self.allowJump then
        if not self._jumpPressedLast then self._jumpPressedLast = false end
        local jumpPressed = love.keyboard.isDown("space")

        if jumpPressed and not self._jumpPressedLast then
            if self.onGround then
                self.vy = -self.jumpStrength
                self.onGround = false
                self.doubleJumped = false
            elseif self.allowDoubleJump and not self.doubleJumped then
                self.vy = -self.jumpStrength
                self.doubleJumped = true
            end
        end
        self._jumpPressedLast = jumpPressed

        self.vy = self.vy + self.gravity * dt
        self.y = self.y + self.vy * dt

        -- Simple ground collision (for demo)
        if self.y >= 400 then
            self.y = 400
            self.vy = 0
            self.onGround = true
            self.doubleJumped = false
        else
            self.onGround = false
        end
    else
        -- Top-down movement
        local moveY = 0
        if love.keyboard.isDown("down") then moveY = moveY + 1 end
        if love.keyboard.isDown("up") then moveY = moveY - 1 end
        self.vy = moveY * self.speed
        self.y = self.y + self.vy * dt
    end

    self.x = self.x + self.vx * dt
end

function Player:draw()
    love.graphics.rectangle("fill", self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end

return Player