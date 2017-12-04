local Feature = require('feature')

-- img, clickable, drawable, updatable, visible, x, y
local Rooms = {
  titleFeatures = {
    Feature('house', '/images/houset.png', false, true, false, true, 300, 100),
    Feature('address', '/images/addresst.png', false, true, false, true, 440, 30),
    Feature('houserules', '/images/houserulest.png', false, true, false, true, 30, 200),
    Feature('instructions', '/images/instructionst.png', false, true, false, true, 900, 300)
  },
  mainFeatures = {
    Feature('tv', '/images/tvt.png', false, true, false, true, 500, 400),
    Feature('couch', '/images/coucht.png', false, true, false, true, 70, 200),
    Feature('trash', '/images/trasht.png', false, true, false, true, 1000, 300),
    Feature('music', '/images/musict.png', false, true, false, true, 100, 400),
    Feature('kitchen', '/images/kitchent.png', false, true, false, true, 700, 550),
    Feature('telescope', '/images/telescopet.png', false, true, false, true, 800, 50),
    Feature('window', '/images/windowt.png', false, true, false, true, 400, 50)
  }, rainbowFeatures = {
    Feature('rainbow', '/images/rainbowt.png', false, true, false, true, 0, 0),
    Feature('the sun', '/images/happysunt.png', false, true, false, true, 700, 50),
    Feature('clouds', '/images/cloudst.png', false, true, false, true, 100, 200),
  }, fieldFeatures = {
    Feature('tree', '/images/treet.png', false, true, false, true, 300, 300),
    Feature('other tree', '/images/othertreet.png', false, true, false, true, 900, 200),
    Feature('grass1', '/images/grass1t.png', false, true, false, true, 800, 100),
    Feature('grass2', '/images/grass2t.png', false, true, false, true, 200, 200),
    Feature('grass3', '/images/grass3t.png', false, true, false, true, 600, 200),
    Feature('flower1', '/images/flower1t.png', true, true, true, true, 700, 100),
    Feature('flower2', '/images/flower2t.png', true, true, true, true, 800, 300),
    Feature('pretty rock', '/images/prettyrockt.png', true, true, true, true, 550, 550),
    Feature('rose bush', '/images/rosebusht.png', false, true, false, true, 0, 400)
  }, desertFeatures = {
    Feature('sandblob', '/images/sandblobt.png', false, true, false, true, 650, 50),
    Feature('dunes', '/images/dunest.png', false, true, false, true, 200, 200),
    Feature('camel', '/images/camelt.png', false, true, false, true, 300, 300),
    Feature('uncute cactus', '/images/uncutecactust.png', false, true, false, true, 950, 50),
    Feature('cute cactus', '/images/cutecactust.png', true, true, true, true, 150, 250),
    Feature('shell', '/images/shellt.png', true, true, true, true, 750, 600)
  }, tundraFeatures = {
    Feature('bigger gray blob', '/images/biggergrayblobt.png', false, true, false, true, 700, 100),
    Feature('gray blob', '/images/grayblobt.png', false, true, false, true, 100, 400),
    Feature('weird fossil', '/images/weirdfossilt.png', true, true, true, true, 350, 500)
  }, voidFeatures = {
    Feature('vortex', '/images/vortext.png', false, true, false, true, 200, 200),
    Feature('star', '/images/start.png', false, true, true, true, 900, 100) 
  }
}

return Rooms