local Metric = require('metric')

local controllerClass = { }
controllerClass.__index = controllerClass

local head = Metric('head', 0)
local imgFiles = {
  '/images/head0t.png', '/images/head1t.png', '/images/head2t.png', '/images/head3t.png', '/images/head4t.png', '/images/head5t.png', '/images/head6t.png'
}

function Controller()
  local instance = {
    class = 'controller',
    x = 0,
    y = 0,
    thinkingText = '...',
    iFile = controllerBaseFile
  }
  setmetatable(instance, controllerClass)
  return instance
end

function controllerClass:draw()
  local img = love.graphics.newImage(self.iFile)
  local imgWidth, _ = img:getDimensions() 
  love.graphics.draw(img, self.x, self.y)
  love.graphics.print(self.thinkingText, (self.x + 10 + imgWidth), self.y + 10, 0, 5)
end

function controllerClass:update()
  -- update metric w/ consequences
end

return Controller