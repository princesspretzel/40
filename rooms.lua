local Feature = require('feature')

-- img, clickable, drawable, updatable, visible, x, y
local Rooms = {
  -- titleFeatures = {
  --   Feature('house', '/images/houset.png', false, true, false, true, 200, 500)
  -- },
  mainFeatures = {
    Feature('computer', '/images/placeholdert.png', false, true, false, true, 200, 500),
    Feature('bed', '/images/placeholdert.png', false, true, false, true, 400, 100),
    Feature('trash', '/images/placeholdert.png', false, true, false, true, 100, 300),
    Feature('laundry', '/images/placeholdert.png', false, true, false, true, 200, 400),
    Feature('oven', '/images/placeholdert.png', false, true, false, true, 500, 300),
    Feature('fridge', '/images/placeholdert.png', false, true, false, true, 600, 200), 
    Feature('vacuum', '/images/placeholdert.png', false, true, false, true, 600, 500)
  }, rainbowFeatures = {
    Feature('rainbow', '/images/rainbowt.png', false, true, false, true, 0, 0),
    Feature('happysun', '/images/happysunt.png', false, true, false, true, 700, 50),
    Feature('clouds', '/images/cloudst.png', false, true, false, true, 100, 200),
  }, fieldFeatures = {
    -- Feature('tree', '/images/treet.png', false, true, false, true, 300, 300),
    -- Feature('othertree', '/images/othertreet.png', false, true, false, true, 600, 600),
    -- Feature('grass1', '/images/grass1t.png', false, true, false, true, 800, 100),
    -- Feature('grass2', '/images/grass2t.png', false, true, false, true, 400, 500),
    -- Feature('grass3', '/images/grass3t.png', false, true, false, true, 600, 200),
    -- Feature('flower1', '/images/flower1t.png', true, true, true, true, 700, 100),
    -- Feature('flower2', '/images/flower2t.png', true, true, true, true, 200, 800),
    -- Feature('prettyrock', '/images/prettyrockt.png', true, true, true, true, 500, 500)
  }, desertFeatures = {
    Feature('sandblob', '/images/sandblobt.png', false, true, false, true, 650, 50),
    Feature('dunes', '/images/dunest.png', false, true, false, true, 200, 200),
    Feature('camel', '/images/camelt.png', false, true, false, true, 300, 300),
    Feature('uncutecactus', '/images/uncutecactust.png', false, true, false, true, 950, 50),
    Feature('cutecactus', '/images/cutecactust.png', true, true, true, true, 100, 150),
    Feature('shell', '/images/shellt.png', true, true, true, true, 800, 450)
  }, tundraFeatures = {
    Feature('biggergrayblob', '/images/biggergrayblobt.png', false, true, false, true, 700, 100),
    Feature('grayblob', '/images/grayblobt.png', false, true, false, true, 100, 400),
    Feature('weirdfossil', '/images/weirdfossilt.png', true, true, true, true, 350, 500)
  }, voidFeatures = {
    Feature('vortex', '/images/vortext.png', false, true, false, true, 200, 200),
    Feature('star', '/images/start.png', false, true, true, true, 900, 100) 
  }
}

return Rooms