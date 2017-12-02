local Metric = require('metric')
local Room = require('room')

local stateClass = { }
stateClass.__index = stateClass

function State(screen)
  local room = Room(screen)
  room:loadRoom()

  local instance = {
    class = 'state',
    currentRoom = room,
    unlockedRooms = { },
    width = gameWidth,
    height = gameHeight
  }
  setmetatable(instance, stateClass)
  return instance
end

function stateClass:enterRoom(name)
  local room = Room(screen)
  room:loadRoom()
  self.currentRoom = room
end

function stateClass:draw()
  print('current room: ', self.currentRoom.name)
  if self.currentRoom then
    self.currentRoom:draw()
  end
end

function stateClass:mousepressed(x, y, button, isTouch)
  if button == 1 then
    self.currentRoom:mouseCollision(x, y)
  end
end

function stateClass:update(dt)
  if self.currentRoom then
    self.currentRoom:update(dt)
  end
end

return State