local pad = {
  x = 0,
  y = 0,
  width = 80,
  height = 20
}

local ball = {
  x = 0,
  y = 0,
  radius = 10,
  stick = false,
  speedX = 0,
  speedY = 0
}

local brick = {}
local level = {}

function start()
  ball.stick = true

  level = {}
  local l, c

  for l = 1, 6 do
    level[l] = {}
    for c = 1, 15 do
      level[l][c] = 1
    end
  end
end

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  brick.width = width / 15
  brick.height = 25

  -- Set the pad to the bottom of the screen
  pad.y = height - (pad.height / 2)

  start()
end

function love.update(dt)
  -- Pad follow mouse
  pad.x = love.mouse.getX()

  -- Stick the ball to the pad when ball.stick == true
  if ball.stick == true then
    -- Throw the ball if ball.stick == false
    ball.y = pad.y - pad.height / 2 - ball.radius
    ball.x = pad.x
  else
    ball.x = ball.x + (ball.speedX * dt)
    ball.y = ball.y + (ball.speedY * dt)
  end
  -- Check if the ball collide with a brick
  local c = math.floor(ball.x / brick.width) + 1
  local l = math.floor(ball.y / brick.height) + 1

  if l >= 1 and l <= #level and c >= 1 and c <= 15 then
    if level[l][c] == 1 then
      ball.speedY = 0 - ball.speedY
      level[l][c] = 0
    end
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
  -- Ball bounce on the pad
  local posCollisionPad = pad.y - (pad.height / 2) - ball.radius
  if ball.y > posCollisionPad then
    local dist = math.abs(pad.x - ball.x)
    if dist < pad.width / 2 then
      ball.speedY = 0 - ball.speedY
      ball.y = posCollisionPad
    end
  end
end

function love.draw()
  local l, c
  local bx, by = 0, 0
  for l = 1, 6 do
    bx = 0
    for c = 1, 15 do
      if level[l][c] == 1 then
        -- Draw a brick
        love.graphics.rectangle("fill", bx + 1, by + 1, brick.width - 2, brick.height - 2)
      end
      bx = bx + brick.width
    end
    by = by + brick.height
  end

  love.graphics.rectangle("fill", pad.x - (pad.width / 2), pad.y - (pad.height / 2), pad.width, pad.height)
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

function love.mousepressed(x, y, n)
  if ball.stick == true then
    ball.stick = false
    ball.speedX = 200
    ball.speedY = -200
  end
end
