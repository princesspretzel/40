local featureClass = { }
featureClass.__index = featureClass

-- I don't know why the x-axis of the mouse seems so off to me 
local xWorkAround = 200

function Feature(name, iFile, clickable, drawable, updatable, visible, x, y)
  local img = love.graphics.newImage(iFile)
  local w, h = img:getDimensions()
  local instance = {
    name = name,
    iFile = iFile, -- maybe get rid of this later
    itemLocked = false,
    choicesLocked = true,
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
  love.graphics.print('choose what you want to do with the ', self.x, self.y - 30)
  love.graphics.print(self.name, self.x, self.y - 10)
  love.graphics.print('keep it for yourself', (self.x + self.w + 10), (self.y + 40))
  love.graphics.print('give it to ybr later', (self.x + self.w + 10), (self.y + 70))
  love.graphics.print('gaze upon it', (self.x + self.w + 10), (self.y + 100))
  love.graphics.setColor(255, 255, 255)
end

function featureClass:choiceClick(x, y)
  if ((x + xWorkAround >= self.x + self.w) and (x < self.x + self.w + 115) and (y > self.y + 25) and (y < self.y + 115)) then
    if ((y >= self.y + 25) and (y < self.y + 55)) then
      return 'keep'
    end
    if ((y >= self.y + 55) and (y < self.y + 85)) then
      return 'give'
    end
    if ((y >= self.y + 85) and (y < self.y + 115)) then
      return 'leave'
    end
    print('ERROR: we should never see this message if the math above is right')
  end
end

function featureClass:resolveChoiceClick(choice)
  print('resolving choice')
  if choice == 'keep' then
    controller:egoBoost()
    self.visible = false
    return
  end
  if choice == 'give' then
    door.itemCount = door.itemCount + 1
    self.visible = false
    return
  end
  if choice == 'leave' then
    controller:egoControl()
    return
  end
  print('ERROR: choice is invalid: ', choice)
end

function featureClass:draw()
  if self.drawable and self.visible then
    love.graphics.draw(self.img, self.x, self.y)
  end
  if self.itemLocked and self.visible then
    self:showItemChoices()
  end
end

-- setting and unsetting locks on the item and its choices
function featureClass:mouseCollision(x, y)
  if self.clickable and self.visible then

    -- if feature choices are unlocked
    if self.choicesLocked ~= true then
      print('choices are unlocked for ', self.name)
      local choice = self:choiceClick(x, y) --check for choice click, contains conditional to figure out collision
      self:resolveChoiceClick(choice) --resolve choice click
      self.choicesLocked = true --lock choices
      self.itemLocked = false --unlock item (except visiblility lock)
    end

    -- if feature item is unlocked
    if self.itemLocked ~= true then
      print('item is unlocked for ', self.name)  
      -- this conditional only checks for collisions between the mouse and the feature, NOT the choice list
      if (x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h) then
        self.itemLocked = true --lock feature item
        self.choicesLocked = false --unlock feature choices
      end
    end

  end
end

--idk
function featureClass:update(dt)
  -- if self.updatable then
  --   print('updatable')
  -- end
end

return Feature