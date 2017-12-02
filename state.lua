local Metric = require('metric')

local stateClass = { }
stateClass.__index = stateClass

function State()
  local instance = {
    class = 'state',
    screen = 'main',
    width = gameWidth,
    height = gameHeight
  }
  setmetatable(instance, stateClass)
  return instance
end

return State