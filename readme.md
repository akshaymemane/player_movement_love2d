# Player Module for LÖVE (Love2D)

A lightweight, injectable **Player** module for [LÖVE (Love2D)](https://love2d.org/) projects.  
Supports top-down or platformer-style movement, jumping (with optional double jump), and dashing.

---

## ✨ Features

- **Simple API** – Drop-in `Player` object with `:new`, `:update`, and `:draw` methods.
- **Configurable** – Easily tweak movement speed, jump strength, gravity, dash behavior, and size.
- **Platformer Support** – Gravity, ground collision, single or double jump.
- **Top-Down Support** – Switch to free movement mode by disabling jumping.
- **Dash Mechanic** – Short burst of movement with cooldown support.

---

## 📦 Installation

Copy `player.lua` into your project directory.

Require it in your `main.lua` (or wherever needed):

```lua
local Player = require "player"
```

🚀 Usage

1. Create a Player Instance
   function love.load()
   player = Player:new(400, 200, {
   speed = 200,
   allowJump = true, -- Enable platformer mode (false = top-down mode)
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

2. Update Player Each Frame
   function love.update(dt)
   player:update(dt)
   end

3. Draw Player
   function love.draw()
   player:draw()
   end

⚙️ Configuration Options
| Option | Type | Default | Description |
| ------------------- | ------ | ------- | ---------------------------------------------------------------------- |
| **speed** | number | `200` | Base horizontal/vertical movement speed. |
| **allowJump** | bool | `false` | Enables platformer mode with gravity and jumping. |
| **jumpStrength** | number | `400` | Upward velocity applied when jumping. |
| **gravity** | number | `800` | Downward force applied every second (only used if `allowJump = true`). |
| **allowDash** | bool | `false` | Enables dash mechanic. |
| **dashSpeed** | number | `400` | Speed applied during dash. |
| **dashTime** | number | `0.15` | Duration of dash in seconds. |
| **dashCooldown** | number | `0.5` | Minimum time before dash can be used again. |
| **width** | number | `32` | Player rectangle width (used for drawing & positioning). |
| **height** | number | `32` | Player rectangle height. |
| **allowDoubleJump** | bool | `false` | Allows one additional mid-air jump after the first jump. |

🎮 Default Controls
Right / Left Arrow – Move horizontally
Up / Down Arrow – Move vertically (only if allowJump = false, i.e., top-down mode)
Space – Jump (if jumping is enabled)
Left Shift – Dash (if dashing is enabled)

🧩 Extending / Injecting
You can extend or override any function:
local Player = require "player"
function Player:draw()
love.graphics.setColor(1, 0, 0) -- custom color
love.graphics.rectangle("fill", self.x - self.width/2, self.y - self.height/2, self.width, self.height)
love.graphics.setColor(1, 1, 1)
end

This lets you use sprites, animations, or custom rendering without touching player.lua.

📝 Notes
The included "ground collision" simply checks if self.y >= 400.
Replace with a collision library (e.g. bump.lua
) for real games.
Dash and double-jump are optional and are only active when explicitly enabled.
You can spawn multiple players by calling Player:new() multiple times with different positions/configs.
