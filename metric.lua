local metricClass = { }
metricClass.__index = metricClass
 
function Metric(metricType)
  local instance = {
    metricType = metricType
    level = 0 -- 0 to 5
  }
  setmetatable(instance, metricClass)
  return instance
end

return Metric