local metricClass = { }
metricClass.__index = metricClass
 
function Metric(metricType, minLevel, startLevel, maxLevel)
  local instance = {
    delta = 1,
    metricType = metricType,
    minLevel = minLevel,
    level = startLevel,
    maxLevel = maxLevel
  }
  setmetatable(instance, metricClass)
  return instance
end

-- pass a new delta or use the instance's (default)
function metricClass:upLevel(delta)
  if self.level < self.maxLevel then
    if delta then
      self.level = self.level + delta
    else
      self.level = self.level + self.delta
    end
  end
end
function metricClass:downLevel(delta)
  if self.level > self.minLevel then
    if delta then
      self.level = self.level - delta
    else
      self.level = self.level - self.delta
    end
  end
end

return Metric