local featureClass = { }
featureClass.__index = featureClass
 
function Feature(iFile, clickable, drawable, updatable, x, y)
  local instance = {
    iFile = iFile,
    clickable = clickable,
    drawable = drawable,
    updatable = updatable,
    x = x,
    y = y
  }
  setmetatable(instance, featureClass)
  return instance
end

function featureClass:draw()
  if self.drawable then
    local img = love.graphics.newImage(self.iFile)
    local imgWidth, _ = img:getDimensions() 
    love.graphics.draw(img, self.x, self.y)
  end
end

function featureClass:mouseCollision(x, y)
  if self.clickable then
    print('clickable feature')
  end
end

function featureClass:update()
  if self.updatable then
    print('updatable feature')
  end
end

return Feature