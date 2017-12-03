local featureClass = { }
featureClass.__index = featureClass
 
function Feature(name, iFile, clickable, drawable, updatable, visible, x, y)
  local instance = {
    name = name,
    iFile = iFile,
    clickable = clickable,
    drawable = drawable,
    updatable = updatable,
    visible = true,
    x = x,
    y = y
  }
  setmetatable(instance, featureClass)
  return instance
end

function featureClass:draw()
  if self.drawable and self.visible then
    local img = love.graphics.newImage(self.iFile)
    local imgWidth, _ = img:getDimensions() 
    love.graphics.draw(img, self.x, self.y)
  end
end

function featureClass:mouseCollision(x, y)
  if self.clickable then
    print('clickable feature')
    -- self.visible = false
  end
end

function featureClass:update(dt)
  if self.updatable then
    print('updatable feature')
    -- maybe movement
  end
end

return Feature