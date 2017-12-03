local Metric = require('metric')

local controllerClass = { }
controllerClass.__index = controllerClass

local head = Metric('head', 0)
local imgFiles = {
  '/images/head0t.png', '/images/head1t.png', '/images/head2t.png', '/images/head3t.png', '/images/head4t.png', '/images/head5t.png', '/images/head6t.png'
}

function Controller()
  local img = love.graphics.newImage('/images/baseheadt.png')
  local w, h = img:getDimensions() 
  local instance = {
    class = 'controller',
    thinkingText = '...',
    x = 0,
    y = 0,
    w = w,
    h = h,
    img = img
  }
  setmetatable(instance, controllerClass)
  return instance
end

function controllerClass:draw()
  love.graphics.draw(self.img, self.x, self.y)
  love.graphics.print(self.thinkingText, (self.x + 10 + self.w), self.y + 10, 0, 5)
end

function controllerClass:update()
  -- update metric w/ consequences
end

return Controller