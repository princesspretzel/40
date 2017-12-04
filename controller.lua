local Metric = require('metric')

local controllerClass = { }
controllerClass.__index = controllerClass

local imgFiles = {
  '/images/head0t.png', '/images/head1t.png', '/images/head2t.png', '/images/head3t.png', '/images/head4t.png', '/images/head5t.png', '/images/head6t.png'
}
local head = Metric('head', 0, 2, table.getn(imgFiles))

function Controller()
  -- give the door access to the heart metric
  table.insert(door.metrics, head)
  -- define the base image vars  
  local img = love.graphics.newImage('/images/head2t.png')
  local w, h = img:getDimensions() 
  local instance = {
    class = 'controller',
    thinkingText = 'another day in which to excel! i wonder - how shall i waste it?',
    x = 0,
    y = 0,
    w = w,
    h = h,
    img = img
  }
  setmetatable(instance, controllerClass)
  return instance
end

function controllerClass:egoBoost()
  if ((head.level + 1) < table.getn(imgFiles)) then
    head:upLevel(1)
    local iFile = imgFiles[head.level + 1]
    self.img = love.graphics.newImage(iFile)
  end
end

function controllerClass:egoControl()
  if (head.level > 0) then
    head:downLevel(1)
    local iFile = imgFiles[head.level + 1]
    self.img = love.graphics.newImage(iFile)
  end
end

-- different text if you don't pick anything up or keep it
function controllerClass:textChangeRoom()
  if door.currentRoom.name == 'field' then
    self.thinkingText = 'a field! so full of glorious opportunity! to do something nice! for someone else!'
  end
  if door.currentRoom.name == 'desert' then
    self.thinkingText = 'hmm... not much here.  i\'ll do my best'
  end
  if door.currentRoom.name == 'tundra' then
    self.thinkingText = 'crap. crapcrapcrap.'
  end  
end

function controllerClass:textChangeItemChoice()
  if head.level == 0 then
    self.thinkingText = 'oohhhhh what is this'
  end
  if head.level == 1 then
    self.thinkingText = 'why do i feel so calm'
  end
  if head.level == 2 then
    self.thinkingText = 'feelin pretty good :)'
  end
  if head.level == 3 then
    self.thinkingText = 'same old same old'
  end
  if head.level == 4 then
    self.thinkingText = 'i have kind of a stomachache... or a headache can\'t really tell'
  end
  if head.level == 5 then
    self.thinkingText = 'time to resolve some old cognitive dissonance i got lying around'
  end
  if head.level == 6 then
    self.thinkingText = 'nahhh'
  end
end

function controllerClass:draw()
  love.graphics.draw(self.img, self.x, self.y)
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(self.thinkingText, self.x + self.w - 10, self.y + 40)
  love.graphics.setColor(255, 255, 255)
end

function controllerClass:update()
  self:textChangeItemChoice()
end

return Controller