local Ai = require('ai')
local Controller = require('controller')
local Door = require('door')
local Feature = require('feature')

function love.load()
  -- game state variables
  love.window.setTitle('house')
  love.window.setMode(900, 900)
  love.graphics.setBackgroundColor(255, 255, 255)
  gameWidth, gameHeight = love.graphics.getDimensions()

  -- TODO: add locks to rooms
  screens = { 
    'main',
    'rainbow', --6 only win condition
    'field', --5/6
    'desert', --3/4
    'tundra', --1/2
    'void' --0 (lose condition)
  }
  
  -- globally available actors
  door = Door('main')
  ai = Ai()
  controller = Controller()
end

function love.draw()
  door:draw()
  if (door.currentRoom.name == 'main' or door.currentRoom.name == nil) then
    ai:draw()
    controller:draw()
  end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
  door:mouseCollision(x, y)
    if (door.currentRoom.name == 'main' or door.currentRoom.name == nil) then
      ai:mouseCollision(x, y)
    end
  end
end

function love.update(dt)
  door:update(dt)
  if (door.currentRoom.name == 'main' or door.currentRoom.name == nil) then
    ai:update(dt)
    controller:update(dt)
  end
end