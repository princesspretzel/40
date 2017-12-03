local metricClass = { }
metricClass.__index = metricClass
 
function Metric(metricType, minLevel, startLevel, maxLevel)
  local instance = {
    metricType = metricType,
    minLevel = minLevel,
    level = startLevel,
    maxLevel = maxLevel
  }
  setmetatable(instance, metricClass)
  return instance
end

function metricClass:upLevel(delta)
  if self.level < self.maxLevel then
    self.level = self.level + delta
  end
end

function metricClass:downLevel(delta)
  if self.level > self.minLevel then
    self.level = self.level - delta
  end
end

return Metric