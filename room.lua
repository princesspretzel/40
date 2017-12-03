local Feature = require('feature')
local RoomFeatures = require('rooms')

local roomClass = { }
roomClass.__index = roomClass

function Room(name)
  local instance = {
    class = 'room',
    name = name,
    backgroundColorR = 255,
    backgroundColorG = 255,
    backgroundColorB = 255,
    features = { },
    -- music = musicFile, 
    width = gameWidth,
    height = gameHeight
  }
  setmetatable(instance, roomClass)
  return instance
end

function roomClass:loadFeatures(featuresTable)
  for idx, feature in ipairs(featuresTable) do
    table.insert(self.features, feature)
  end
end

function roomClass:loadRoom()
  if self.name == 'main' then
    self.backgroundColorR = 255
    self.backgroundColorG = 255
    self.backgroundColorB = 255
    self:loadFeatures(RoomFeatures.mainFeatures)
  end
  if self.name == 'rainbow' then
    self.backgroundColorR = 0
    self.backgroundColorG = 0
    self.backgroundColorG = 200
    self:loadFeatures(RoomFeatures.rainbowFeatures)
  end
  if self.name == 'field' then
    self.backgroundColorR = 0
    self.backgroundColorG = 200
    self.backgroundColorB = 0
    self:loadFeatures(RoomFeatures.fieldFeatures)
  end
  if self.name == 'desert' then
    self.backgroundColorR = 200
    self.backgroundColorG = 0
    self.backgroundColorB = 0 
    self:loadFeatures(RoomFeatures.desertFeatures)
  end 
  if self.name == 'tundra' then
    self.backgroundColorR = 200
    self.backgroundColorG = 200
    self.backgroundColorB = 200 
    self:loadFeatures(RoomFeatures.tundraFeatures)
  end 
  if self.name == 'void' then
    self.backgroundColorR = 255
    self.backgroundColorG = 255
    self.backgroundColorB = 255
    self:loadFeatures(RoomFeatures.voidFeatures)
  end
end

function roomClass:draw()
  love.graphics.setBackgroundColor(self.backgroundColorR, self.backgroundColorG, self.backgroundColorB)
  for idx, feature in ipairs(self.features) do
    feature:draw()
  end
end

function roomClass:mouseCollision(x, y)
  print('room mouse collision')
  for idx, feature in ipairs(self.features) do
    feature:mouseCollision(x, y)
  end
end

function roomClass:update(dt)
  for idx, feature in ipairs(self.features) do
    feature:update(dt)
  end
end

return Room