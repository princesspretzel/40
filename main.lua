local Ai = require('ai')
local Spot = require('spot')

-- game state variables
mainScreen = true
entities = { }

-- ai presets
aiFile = '/images/baseheartt.png'
aiImage = love.graphics.newImage(aiFile)
aiWidth, aiHeight = aiImage:getDimensions()

-- start by entering, also solves the beginning deadlock problem
door = Spot('door,', 1, 700, 700)

function love.load()
  -- love.window.setTitle()
  love.window.setMode(0, 0)
  love.graphics.setBackgroundColor(255, 255, 255)
  gameWidth, gameHeight = love.graphics.getDimensions()
  local firstSpot = Spot('first', 0, ((gameWidth/2) - (aiWidth/2)), ((gameHeight/2) - (aiHeight/2)))
  local ai = Ai(firstSpot)
  table.insert(entities, ai)
end

function love.draw()
  if mainScreen then
    for idx, entity in ipairs(entities) do
      entity:draw()
    end
  end
end

function love.mousepressed(x, y, button, istouch)
end

function love.update(dt)
  for idx, entity in ipairs(entities) do
    entity:update(dt)
  end
end