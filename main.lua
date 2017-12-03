local Ai = require('ai')
local Controller = require('controller')
local Feature = require('feature')
local State = require('state')

function love.load()
  -- game state variables
  love.window.setTitle('house')
  love.window.setMode(900, 900)
  love.graphics.setBackgroundColor(255, 255, 255)
  gameWidth, gameHeight = love.graphics.getDimensions()
  state = State('main')

  -- TODO: add locks to rooms
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

  -- controller presets
  controllerBaseFile = '/images/baseheadt.png'
  controllerImage = love.graphics.newImage(controllerBaseFile)
  controllerWidth, controllerHeight = controllerImage:getDimensions() 
  -- the door has to be available everywhere
  doorFile = '/images/doort.png'
  doorImage = love.graphics.newImage(doorFile)
  doorWidth, doorHeight = doorImage:getDimensions()
  -- clickable, drawable, not updatable, visible
  door = Feature('door', doorFile, true, true, false, true, state.width - 300, state.height - 300)
  
  -- add special actors
  ai = Ai()
  controller = Controller()
end

function love.draw()
  state:draw()
  if (state.room == 'main' or state.room == nil) then
    ai:draw()
    controller:draw()
    door:draw()
  end
end

function love.mousepressed(x, y, button, istouch)
  state:mouseCollision(x, y)
  if (state.room == 'main' or state.room == nil) then
    if button == 1 then
      ai:mouseCollision(x, y)
      door:mouseCollision(x, y)
    end
  end
end

function love.update(dt)
  state:update(dt)
  if (state.room == 'main' or state.room == nil) then
    ai:update(dt)
    controller:update(dt)
  end
end