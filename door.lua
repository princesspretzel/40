local Metric = require('metric')
local Room = require('room')

local doorClass = { }
doorClass.__index = doorClass

local doorOpenSound = love.audio.newSource('/sounds/close_door_1.mp3')
local doorLockedSound = love.audio.newSource('/sounds/door_lock.mp3')

local screensByHeartCount = {'void', 'tundra', 'tundra', 'desert', 'desert', 'field', 'field', 'rainbow'}

function Door(screen)
  -- load the first room
  local room = Room(screen)
  room:loadRoom()
  -- define the base image vars
  local img = love.graphics.newImage('/images/doort.png')
  local w, h = img:getDimensions()
  -- create the door instance
  local instance = {
    class = 'door',
    currentRoom = room,
    unlockedRooms = { },
    metrics = { },
    itemCount = 0,
    x = gameWidth - w - 100,
    y = gameHeight - h - 100,
    w = w,
    h = h,
    img = img
  }
  setmetatable(instance, doorClass)
  return instance
end

-- returns the number of stops can go by before ai loses a heart
function doorClass:howManyStopsCanBeIgnored()
  for idx, metric in ipairs(self.metrics) do
    if metric.metricType == 'head' then
      ego = metric.level
    end
    if metric.metricType == 'heart' then
      feeling = metric.level
    end
  end
  return (ego - feeling)
end

-- check if you can increase heart count and decrement item if ego (head metric)
function doorClass:canGiveHeart()
  for idx, metric in ipairs(self.metrics) do
    if metric.metricType == 'head' then
      if metric.level <= (metric.maxLevel/2) then
        return true
      end
      if self.itemCount > 0 then
        self.itemCount = self.itemCount - 1
        return true
      end
      return false
    end
  end
end

-- gives you the room you can unlock at this level
function doorClass:availableRoom()
  if self.currentRoom.name ~= 'main' then
    return 'main'
  else
    local heartCount
    for idx, metric in ipairs(self.metrics) do
      if metric.metricType == 'heart' then
        heartCount = metric.level
      end
    end
    return screensByHeartCount[heartCount + 1]
  end
  print('ERROR: there is no available room')
end

function doorClass:isDoorClicked(x, y)
  if (x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h) then
    return true
  end
end

function doorClass:enterRoom(name)
  local room = Room(name)
  self.currentRoom = room
  -- load features of the current room
  self.currentRoom:loadRoom()
  self.currentRoom:turnOnSound()
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
    if self.currentRoom.name == 'void' then
      doorLockedSound:play()
    else
      doorOpenSound:play()
      local option = self:availableRoom()
      self:enterRoom(option)
    end
  end
end

function doorClass:update(dt)
  if self.currentRoom then
    if self.currentRoom.name == 'title' then
      self.x = 520
      self.y = 550
    else
      self.x = gameWidth - self.w - 100
      self.y = gameHeight - self.h - 100
    end
    self.currentRoom:update(dt)
  end
end

return Door