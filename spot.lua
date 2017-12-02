local spotClass = { }
spotClass.__index = spotClass

function Spot(name, position, x, y)
  local instance = {
    name = name,
    position = position, -- this is gross, there must be a better way to keep track of index numbers
    x = x,
    y = y
  }
  setmetatable(instance, spotClass)
  return instance
end

function spotClass:draw()
  if mainScreen then
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle('fill', self.x, self.y, 20)
    love.graphics.setColor(255, 255, 255)
  end
end

function spotClass:update()
end

return Spot