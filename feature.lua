local featureClass = { }
featureClass.__index = featureClass
 
function Feature(name, iFile, clickable, drawable, updatable, visible, x, y)
  local img = love.graphics.newImage(iFile)
  local w, h = img:getDimensions()
  local instance = {
    name = name,
    iFile = iFile, -- maybe get rid of this later
    clickable = clickable,
    drawable = drawable,
    updatable = updatable,
    visible = true,
    x = x,
    y = y,
    w = w,
    h = h,
    img = img
  }
  setmetatable(instance, featureClass)
  return instance
end

function featureClass:draw()
  if self.drawable and self.visible then
    love.graphics.draw(self.img, self.x, self.y)
  end
end

function featureClass:mouseCollision(x, y)
  if self.clickable then
    if (x >= self.x and x <= self.x + self.w and y <= self.y and y >= self.y + self.h) then
      print('clicked on ', feature.name)
      -- TODO: text, 'keep it for youself?' / 'give it to your beautiful roommate'
    end
  end
end

function featureClass:update(dt)
  if self.updatable then
    -- maybe movement
  end
end

return Feature