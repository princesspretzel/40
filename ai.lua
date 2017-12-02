local Metric = require('metric')
local Spot = require('spot')

local aiClass = { }
aiClass.__index = aiClass

local heart = Metric('heart', 0)
local spots = {
  Spot('computer', 1, 200, 500),
  Spot('bed', 2, 400, 100),
  Spot('trash', 3, 100, 300),
  Spot('laundry', 4, 200, 400),
  Spot('oven', 5, 500, 300),
  Spot('fridge', 6, 600, 200), 
  Spot('vacuum', 7, 600, 500) 
}
local imgFiles = {
  '/images/heart0t.png', '/images/heart1t.png', '/images/heart2t.png', '/images/heart3t.png', '/images/heart4t.png', '/images/heart5t.png', '/images/heart6t.png'
}

local availableSpots = { }

function Ai(destination)
  loadSpots()
  local instance = {
    class = 'ai',
    x = 0,
    y = 0,
    destination = destination,
    iFile = aiBaseFile,
    paused = false,
    stop = 0, -- no idea how to balance yet 
    variation = 1, -- rng lvl from 1 to length
    availableSpots = availableSpots,
    -- add r later to look like walking
  }
  setmetatable(instance, aiClass)
  return instance
end

function loadSpots()
  for n = 1, table.getn(spots) do
    table.insert(drawables, spots[n])
    table.insert(availableSpots, spots[n])
  end
end

-- choose a spot that is not the current spot,
-- or one that has already been visited
function aiClass:nextSpot()
  print('number of available spots: ', table.getn(self.availableSpots))
  print('moving towards ', self.destination.name)
  self:removeLastDestination()
  return self.availableSpots[love.math.random(table.getn(self.availableSpots))]
end

function aiClass:removeLastDestination()
  table.remove(self.availableSpots, self.destination.position)
end

function aiClass:movement(dt)
  if self.paused then --pausing at a destination spot
    self.stop = self.stop - dt
    -- self.stop will never actually be zero except when set
    if self.stop < 0 then
      self.destination = self:nextSpot()
      -- reset the clock
      self.paused = false
      self.stop = 0
    end
  else --movement to a destination spot
    -- close the distance between current position of the center and the destination
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
      self.stop = 1 --seconds, this function runs ~60 fps
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
  if ((x <= (self.x + aiWidth)) and (x >= self.x)) then
    xClick = true
  end
  if ((y <= (self.y + aiHeight)) and (y >= self.y)) then
    yClick = true
  end
  if xClick and yClick and self.paused then
    if (heart.level < table.getn(imgFiles)) then
      heart:updateLevel(1)
      self.iFile = imgFiles[heart.level + 1]
    end
  end
end

function aiClass:draw()
  img = love.graphics.newImage(self.iFile)
  love.graphics.draw(img, self.x, self.y)
end

function aiClass:update(dt)
  self:movement(dt)
end

return Ai