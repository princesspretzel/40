local featureClass = { }
featureClass.__index = featureClass
 
function Feature(name, iFile, clickable, drawable, updatable, visible, x, y)
  local img = love.graphics.newImage(iFile)
  local w, h = img:getDimensions()
  local instance = {
    name = name,
    iFile = iFile, -- maybe get rid of this later
    choiceInProgress = false,
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

function featureClass:showItemChoices()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print('choose what you want to do with the ', self.x, self.y - 10)
  love.graphics.print(self.name, self.x, self.y + 10)
  love.graphics.print('keep it for yourself', self.x + self.w, self.y + 30)
  love.graphics.print('give it to ybr', self.x + self.w, (self.y + 50))
  love.graphics.print('leave it alone', self.x + self.w, self.y + 70)
  love.graphics.setColor(255, 255, 255)
end

function featureClass:interpretChoiceClick(x, y)
  if ((x < self.x + self.w + 100) and (x > self.x - 100)) and ((y > self.y - 50) and (y < self.y + self.h + 50)) then
    if ((y > self.y - 50) and (y < self.y + 40)) then
      controller:egoBoost()
      self.visible = false
    end
    if ((y >= self.y + 40) and (y < self.y + 60)) then
      door.itemCount = 1
      self.visible = false
    end
    self.choiceInProgress = false
  end
end

function featureClass:draw()
  if self.drawable and self.visible then
    love.graphics.draw(self.img, self.x, self.y)
  end
  if self.choiceinProgress and self.visible then
    self:showItemChoices()
  end
end

function featureClass:mouseCollision(x, y)
  if (self.clickable and (self.choiceInProgress ~= true)) then
    if (x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h) then
      self.choiceinProgress = true
      print('self returned to room class after item click: ', self.choiceinProgress)
      return self
    end
  end
  return nil
end

--idk
function featureClass:update(dt)
  -- if self.updatable then
  --   print('updatable')
  -- end
end

return Feature