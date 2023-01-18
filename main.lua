local pad = {}
pad.x = 0
pad.y = 0
pad.width = 80
pad.height = 20

local ball = {}
ball.x = 0
ball.y = 0
ball.radius = 10
ball.stick = false

function start()
  ball.stick = true
end



function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  
  -- Set the pad to the bottom of the screen
  pad.y = height - (pad.height / 2)
  
  start()
  
end


function love.update(dt)
  -- Pad follow mouse
  pad.x = love.mouse.getX()
  
  -- Stick the ball to the pad when ball.stick == true
  if ball.stick == true then
    ball.y = pad.y - pad.height / 2 - ball.radius
    ball.x = pad.x
  end

end

function love.draw()
  love.graphics.rectangle("fill", pad.x - (pad.width / 2), pad.y - (pad.height / 2), pad.width, pad.height)
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end