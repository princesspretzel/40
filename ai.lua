local Metric = require('metric')

local aiClass = { }
aiClass.__index = aiClass

local imgFiles = { '/images/heart0t.png', '/images/baseheartt.png', '/images/heart1t.png', '/images/heart2t.png', '/images/heart3t.png', '/images/heart4t.png', '/images/heart5t.png', '/images/heart6t.png' }
local heart = Metric('heart', 0, 1, (table.getn(imgFiles) - 1))

local availableSpots = { }
local initialUnclickedStopsBeforeHeartDecrease = 7

function Ai()
  -- create a manipulable copy of the features of the main room
  loadSpots()
  -- give the door access to the heart metric
  table.insert(door.metrics, heart)
  -- define the base image vars  
  local img = love.graphics.newImage('/images/baseheartt.png')
  local w, h = img:getDimensions()
  -- create the ai instance
  local instance = {
    class = 'ai',
    destination = door,
    paused = false,
    stop = 0,
    variation = 1, --TODO: use this? rng lvl from 1 to length
    maxUnclickedStopsBeforeHeartDecrease = initialUnclickedStopsBeforeHeartDecrease,
    availableSpots = availableSpots,
    lastHeartIncrease = 0,
    x = gameWidth,
    y = gameHeight,
    w = w,
    h = h,
    img = img,
    text = nil
  }
  setmetatable(instance, aiClass)
  return instance
end

function loadSpots()
  for idx, feature in ipairs(door.currentRoom.features) do
    table.insert(availableSpots, feature)
  end
end

function aiClass:findSpot(spot)
  for idx, feature in ipairs(self.availableSpots) do
    if spot.name == feature.name then
      return idx
    end
  end
end

function aiClass:setHappyText()
  self.text = 'it\'s fun to do \nthis together'
end

function aiClass:setSadText()
  self.text = 'i don\'t want do \nthis with you \nright now'
end

function aiClass:unsetText()
  self.text = nil
end

-- if # stops go by and you don't do anything nice, you lose a heart
function aiClass:heartCheck()
  -- factor in the difference between the ego and the feelings
  self.maxUnclickedStopsBeforeHeartDecrease = (initialUnclickedStopsBeforeHeartDecrease - door:howManyStopsCanBeIgnored())
  print('self.maxUnclickedStopsBeforeHeartDecrease: ', self.maxUnclickedStopsBeforeHeartDecrease)
  if self.lastHeartIncrease > self.maxUnclickedStopsBeforeHeartDecrease then
    self:heartDecrease()
  end
end

function aiClass:heartDecrease()
  if ((heart.level - 1) >= 0) then
    heart:downLevel(1)
    local iFile = imgFiles[heart.level + 1]
    self.img = love.graphics.newImage(iFile)
    self.lastHeartIncrease = 0
  end
end

function aiClass:heartIncrease()
  if (heart.level + 1 < table.getn(imgFiles)) then
    heart:upLevel(1)
    local iFile = imgFiles[heart.level + 1]
    self.img = love.graphics.newImage(iFile)
    self.lastHeartIncrease = 0
  end
end

-- choose a spot that is not the current spot, or one that has already been visited
function aiClass:nextSpot()
  print('number of available spots: ', table.getn(self.availableSpots))
  print('moving towards ', self.destination.name)

  self:removeLastDestination()
  self:unsetText()
  self.lastHeartIncrease = self.lastHeartIncrease + 1 
  return self.availableSpots[love.math.random(table.getn(self.availableSpots))]
end

function aiClass:removeLastDestination()
  local idx = self:findSpot(self.destination)
  if idx then
    table.remove(self.availableSpots, idx)
  end
end

function aiClass:movement(dt)
  --pausing at a destination spot
  if self.paused then
    self.stop = self.stop - dt
    -- self.stop will never actually be zero except when set to it
    if self.stop < 0 then
      self.destination = self:nextSpot()
      -- reset the clock
      self.paused = false
      self.stop = 0
    end
  --movement to a destination spot
  else
    -- close the distance between current position of the center and the destination
    -- print('self.destination.x: ', self.destination.x)
    -- print('self.destination.y: ', self.destination.y)
    if (self.destination.x > self.x) then
      self.x = self.x + (self.variation)
    end
    if (self.destination.x < self.x) then
      self.x = self.x - (self.variation)
    end
    if (self.destination.y > self.y) then
      self.y = self.y + (self.variation)
    end
    if (self.destination.y < self.y) then
      self.y = self.y - (self.variation)
    end
    -- when the distance between the current center position and the destination is closed, choose the next destination
    if (self.destination.x == self.x and self.destination.y == self.y and self.stop == 0) then
      self.paused = true
      self.stop = 2 --seconds, this function runs ~60 fps
    end
  end
  -- when the "round" is over (all spots have been visited), start over
  if (table.getn(self.availableSpots) == 1) then
    loadSpots()
    self.availableSpots = availableSpots
  end
end

function aiClass:mouseCollision(x, y)
  local xClick = false
  local yClick = false
  if ((x <= (self.x + self.w)) and (x >= self.x)) then
    xClick = true
  end
  if ((y <= (self.y + self.h)) and (y >= self.y)) then
    yClick = true
  end
  if xClick and yClick and self.paused then
    if door:canGiveHeart() then
      self:heartIncrease()
      self:setHappyText()
    else
      self:setSadText()
    end
  end
end

function aiClass:draw()
  if (door.currentRoom.name == 'main' or door.currentRoom.name == nil) then
    love.graphics.draw(self.img, self.x, self.y)
    if self.text then
      love.graphics.setColor(0, 0, 0)
      love.graphics.print(self.text, self.x + 5, self.y - 30)
      love.graphics.setColor(255, 255, 255)
    end
  end
end

function aiClass:update(dt)
  if (door.currentRoom.name == 'main' or door.currentRoom.name == nil) then
    self:movement(dt)
    self:heartCheck()
  end
end

return Ai