local Feature = require('feature')

local roomClass = { }
roomClass.__index = roomClass

-- img, clickable, drawable, updatable, x, y
local rainbowFeatures = {
  Feature('/images/rainbowt.png', false, true, false, 300, 300),
  Feature('/images/happysunt.png', false, true, false, 200, 200),
  Feature('/images/cloudst.png', false, true, false, 400, 500),
}
-- local fieldFeatures = {
--   Feature()  
-- }
-- local desertFeatures = {
--   Feature()  
-- }
-- local tundraFeatures = {
--   Feature()  
-- }
local voidFeatures = {
  Feature('/images/vortext.png', false, true, false, 350, 750) 
}

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
    table.insert(self.features, mainFeatures)
  end
  if self.name == 'rainbow' then
    self.backgroundColorR = 0
    self.backgroundColorG = 0
    self.backgroundColorG = 200
    self:loadFeatures(rainbowFeatures)
    print('self.features: ', self.features)
  end
  -- if self.name == 'field' then
  --   self.backgroundColor = {0, 200, 0}    
  --   table.insert(self.features, fieldFeatures)
  -- end
  -- if self.name == 'desert' then
  --       self.backgroundColor = {200, 0, 0}
  --   table.insert(self.features, desertFeatures)
  -- end 
  -- if self.name == 'tundra' then
  --   self.backgroundColor = {200, 200, 200}
  --   table.insert(self.features, tundraFeatures)
  -- end 
  if self.name == 'void' then
    self.backgroundColorR = 255
    self.backgroundColorG = 255
    self.backgroundColorB = 255
    table.insert(self.features, voidFeatures)
  end
end

function roomClass:draw()
  love.graphics.setBackgroundColor(self.backgroundColorR, self.backgroundColorG, self.backgroundColorB)
  for idx, feature in ipairs(self.features) do
    feature:draw()
  end
end

function roomClass:mousepressed(x, y, button, istouch)
  if button == 1 then
    for idx, feature in ipairs(self.features) do
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