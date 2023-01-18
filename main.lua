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
ball.speedX = 0
ball.speedY = 0

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
  -- Throw the ball if ball.stick == false
  else 
    ball.x = ball.x + (ball.speedX * dt)
    ball.y = ball.y + (ball.speedY * dt)
  end
  
  -- Bounce on the right wall
  if ball.x > width then
    ball.speedX = 0 - ball.speedX
    ball.x = width
  end
  
  -- Bounce on the left wall
  if ball.x < 0 then
    ball.speedX = 0 - ball.speedX
    ball.x = 0
  end
  
  -- Bounce on the top wall
  if ball.y < 0 then
    ball.speedY = 0 - ball.speedY
    ball.y = 0
  end
  
  -- Ball goes out of the screen (bottom)
  if ball.y > height then
    start()
  end
  
  
end

function love.draw()
  love.graphics.rectangle("fill", pad.x - (pad.width / 2), pad.y - (pad.height / 2), pad.width, pad.height)
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

function love.mousepressed(x, y, n)
  if ball.stick == true then 
    ball.stick = false
    ball.speedX = -200
    ball.speedY = -200
  end
end
