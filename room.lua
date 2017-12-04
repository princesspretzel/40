local Feature = require('feature')
local RoomFeatures = require('rooms')

local roomClass = { }
roomClass.__index = roomClass

-- counter for lose condition
local voidClicks = 0
local voidMessages = {
  'you have lost',
  'you didn\'t take care',
  'you had many chances',
  'you squandered them all'
}

-- sounds
local titleSound = love.audio.newSource('/sounds/car+driveby2.mp3')
local voidSound = love.audio.newSource('/sounds/heartbeat.mp3')
local tundraSound = love.audio.newSource('/sounds/windhowl.mp3')
local desertSound = love.audio.newSource('/sounds/fire2.mp3')
local fieldSound = love.audio.newSource('/sounds/rainforestambience.mp3')
local rainbowSound = love.audio.newSource('/sounds/cheering1.mp3')

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
-- load features, turn off old sounds
function roomClass:loadFeatures(featuresTable)
  for idx, feature in ipairs(featuresTable) do
    table.insert(self.features, feature)
  end
end

--turn off all sounds
function roomClass:silence()
  titleSound:stop()
  voidSound:stop()
  tundraSound:stop()
  desertSound:stop()
  fieldSound:stop()
  rainbowSound:stop()
end

function roomClass:loadRoom()
  self:silence()
  if self.name == 'title' then
    love.window.setTitle('life instructions')
    self.backgroundColorR = 255
    self.backgroundColorG = 255
    self.backgroundColorB = 255
    self:loadFeatures(RoomFeatures.titleFeatures)
    titleSound:setLooping(true)
    titleSound:play()
  end
  if self.name == 'main' then
    love.window.setTitle('you are inside your house, hanging out with your beautiful roommate')
    self.backgroundColorR = 255
    self.backgroundColorG = 255
    self.backgroundColorB = 255
    self:loadFeatures(RoomFeatures.mainFeatures)
  end
  if self.name == 'rainbow' then
    love.window.setTitle('you can care for others as you care for yourself')
    self.backgroundColorR = 0
    self.backgroundColorG = 0
    self.backgroundColorG = 200
    self:loadFeatures(RoomFeatures.rainbowFeatures)
    rainbowSound:setLooping(true)
    rainbowSound:play()
  end
  if self.name == 'field' then
    love.window.setTitle('a beautiful field full of beautiful things')
    self.backgroundColorR = 0
    self.backgroundColorG = 200
    self.backgroundColorB = 0
    fieldSound:setLooping(true)
    fieldSound:play()
    self:loadFeatures(RoomFeatures.fieldFeatures)
  end
  if self.name == 'desert' then
    love.window.setTitle('the desert it has its charms and its challenges')
    self.backgroundColorR = 230
    self.backgroundColorG = 240
    self.backgroundColorB = 0 
    desertSound:setLooping(true)
    desertSound:play()
    self:loadFeatures(RoomFeatures.desertFeatures)
  end 
  if self.name == 'tundra' then
    love.window.setTitle('The Tundra: sure is chilly and a barren wasteland out here!')
    self.backgroundColorR = 200
    self.backgroundColorG = 200
    self.backgroundColorB = 200 
    tundraSound:setLooping(true)
    tundraSound:play()
    self:loadFeatures(RoomFeatures.tundraFeatures)
  end 
  if self.name == 'void' then
    love.window.setTitle('this the void from which there is no return')
    self.backgroundColorR = 0
    self.backgroundColorG = 0
    self.backgroundColorB = 0
    voidSound:setLooping(true)
    voidSound:play()
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
  if self.name == 'void' then
    voidClicks = voidClicks + 1
    if (voidClicks <= table.getn(voidMessages)) then
      love.window.setTitle(voidMessages[voidClicks])
    else
      love.window.setTitle('"women should win medals for loving men" --my friend kristen')
    end
  end
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