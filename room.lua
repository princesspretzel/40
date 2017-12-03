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

-- TODO: could set everything back to "visible"
function roomClass:loadFeatures(featuresTable)
  for idx, feature in ipairs(featuresTable) do
    table.insert(self.features, feature)
  end
end

function roomClass:loadRoom()
  -- reset counters per room
  if self.name == 'title' then
    love.window.setTitle('life instructions')
    self.backgroundColorR = 255
    self.backgroundColorG = 255
    self.backgroundColorB = 255
    self:loadFeatures(RoomFeatures.titleFeatures)
  end
  if self.name == 'main' then
    love.window.setTitle('you are inside your house, hanging out with your beautiful roommate')
    self.backgroundColorR = 255
    self.backgroundColorG = 255
    self.backgroundColorB = 255
    self:loadFeatures(RoomFeatures.mainFeatures)
  end
  if self.name == 'rainbow' then
    love.window.setTitle('o many are the rewards of yanking your soul back from narcissism instincts')
    self.backgroundColorR = 0
    self.backgroundColorG = 0
    self.backgroundColorG = 200
    self:loadFeatures(RoomFeatures.rainbowFeatures)
  end
  if self.name == 'field' then
    love.window.setTitle('a beautiful field full of beautiful things')
    self.backgroundColorR = 0
    self.backgroundColorG = 200
    self.backgroundColorB = 0
    self:loadFeatures(RoomFeatures.fieldFeatures)
  end
  if self.name == 'desert' then
    love.window.setTitle('in the desert, you can remember your name cuz there ain\'t no one there for to give ukraine')
    self.backgroundColorR = 230
    self.backgroundColorG = 240
    self.backgroundColorB = 0 
    self:loadFeatures(RoomFeatures.desertFeatures)
  end 
  if self.name == 'tundra' then
    love.window.setTitle('The Tundra')
    self.backgroundColorR = 200
    self.backgroundColorG = 200
    self.backgroundColorB = 200 
    self:loadFeatures(RoomFeatures.tundraFeatures)
  end 
  if self.name == 'void' then
    love.window.setTitle('this the void from which there is no return')
    self.backgroundColorR = 0
    self.backgroundColorG = 0
    self.backgroundColorB = 0
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
  for idx, feature in ipairs(self.features) do
    if feature.visible then
      feature:mouseCollision(x, y)
    end
  end
end

function roomClass:update(dt)
  for idx, feature in ipairs(self.features) do
    feature:update(dt)
  end
end

return Room