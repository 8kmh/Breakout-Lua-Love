local pad = {}
pad.x = 0
pad.y = 0
pad.width = 80
pad.height = 20



function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  
  pad.y = height - (pad.height / 2)
end


function love.update(dt)
  -- Pad follow mouse
  pad.x = love.mouse.getX()
  
  if pad.x + pad.width == width then
  end

end

function love.draw()
  love.graphics.rectangle("fill", pad.x - (pad.width / 2), pad.y - (pad.height / 2), pad.width, pad.height)
end