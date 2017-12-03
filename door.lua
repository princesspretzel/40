local Metric = require('metric')
local Room = require('room')

local doorClass = { }
doorClass.__index = doorClass

function Door(screen)
  local room = Room(screen)
  room:loadRoom()

  local img = love.graphics.newImage('/images/doort.png')
  local w, h = img:getDimensions()
  
  local instance = {
    class = 'door',
    currentRoom = room,
    unlockedRooms = { },
    x = 600,
    y = 600,
    w = w,
    h = h,
    img = img
  }
  setmetatable(instance, doorClass)
  return instance
end

-- should be able to use normal features, need a good/ok way to put it in every features table
function doorClass:isDoorClicked(x, y)
  print('checking door click')
  if (x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h) then
    return true
  end
end

function doorClass:enterRoom(name)
  local room = Room(name)
  self.currentRoom = room
  -- load features of the current room
  self.currentRoom:loadRoom()
end

function doorClass:draw()
  love.graphics.draw(self.img, self.x, self.y)
  if self.currentRoom then
    self.currentRoom:draw()
  end
end

function doorClass:mouseCollision(x, y)
  if self.currentRoom then
    self.currentRoom:mouseCollision(x, y)
  end
  if self:isDoorClicked(x, y) then
    self:enterRoom('rainbow')
  end
end

function doorClass:update(dt)
  if self.currentRoom then
    self.currentRoom:update(dt)
  end
end

return Door