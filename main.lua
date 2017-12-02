local Ai = require('ai')
local Controller = require('controller')
local Spot = require('spot')
local State = require('state')

clickables = { }
drawables = { }
updatables = { }

screens = { 
  'main',
  'rainbow', --6 only win condition
  'field', --5/6
  'desert', --3/4
  'tundra', --1/2
  'void' --0 (lose condition)
}

-- ai presets
aiBaseFile = '/images/baseheartt.png'
aiImage = love.graphics.newImage(aiBaseFile)
aiWidth, aiHeight = aiImage:getDimensions()

--controller presets
controllerBaseFile = '/images/baseheadt.png'
controllerImage = love.graphics.newImage(controllerBaseFile)
controllerWidth, controllerHeight = controllerImage:getDimensions() 

gameWidth, gameHeight = love.graphics.getDimensions()
state = State('rainbow')

function love.load()
  -- love.window.setTitle()
  love.window.setMode(900, 900)
  love.graphics.setBackgroundColor(255, 255, 255)

  local controller = Controller()
  -- start by entering through door and walking to first spot (center of screen) solves the beginning deadlock problem
  local firstSpot = Spot('first', 0, ((state.width/2) - (aiWidth/2)), ((state.height/2) - (aiHeight/2)))
  local ai = Ai(firstSpot)
  local door = Spot('door,', 1, 700, 700)
  ai.x = door.x
  ai.x = door.y

  table.insert(drawables, ai)
  table.insert(updatables, ai)
  table.insert(clickables, ai)
  
  table.insert(drawables, controller)
  table.insert(updatables, controller)
end

function love.draw()
  if state.room == 'main' then
    for idx, drawable in ipairs(drawables) do
      drawable:draw()
    end
  else
    state:draw()
  end
end

function love.mousepressed(x, y, button, istouch)
  if state.room == 'main' then
    if button == 1 then
      for idx, clickable in ipairs(clickables) do
        clickable:mouseCollision(x, y)
      end
    end
  else
    state:mouseCollision(x, y)
  end
end

function love.update(dt)
  if state.room == 'main' then
    for idx, updatable in ipairs(updatables) do
      updatable:update(dt)
    end
  else
    state:update(dt)
  end
end