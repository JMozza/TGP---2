function love.load()
  love.physics.setMeter(64) 
  world = love.physics.newWorld(0, 9.81*64, true) 
 
  objects = {} -- table to hold all our physical objects
 
  objects.top = {}
  objects.top.body = love.physics.newBody(world, 1920/2, 20) 
  objects.top.shape = love.physics.newRectangleShape(1920, 50) 
  objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape); 
  
  objects.bottom = {}
  objects.bottom.body = love.physics.newBody(world, 1920/2, 1060) 
  objects.bottom.shape = love.physics.newRectangleShape(1920, 50) 
  objects.bottom.fixture = love.physics.newFixture(objects.bottom.body, objects.bottom.shape); 
  
  objects.left = {}
  objects.left.body = love.physics.newBody(world, 20, 1080/2) 
  objects.left.shape = love.physics.newRectangleShape(50, 1080) 
  objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape); 
  
  objects.right = {}
  objects.right.body = love.physics.newBody(world, 1900, 1080/2) 
  objects.right.shape = love.physics.newRectangleShape(50, 1080) 
  objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape);

  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 1920/2, 1080/2, "dynamic") 
  objects.ball.shape = love.physics.newCircleShape(20) 
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) 
  objects.ball.fixture:setRestitution(1) 
  --objects.ball.body:setMass(0)
  
  objects.player1 = {}
  objects.player1.body = love.physics.newBody(world, 200, 900, "static")
  objects.player1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  objects.player1.fixture = love.physics.newFixture(objects.player1.body, objects.player1.shape, 5) 
  
  objects.player2 = {}
  objects.player2.body = love.physics.newBody(world, 1500, 900, "static")
  objects.player2.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  objects.player2.fixture = love.physics.newFixture(objects.player2.body, objects.player2.shape, 2)
 
  love.graphics.setBackgroundColor(104, 136, 248) 
  love.window.setMode(1920, 1080) 
  
  gamestate = "menu"
end

 
function love.update(dt)
  world:update(dt) 
  
  x = objects.player1.body:getX()
  y = objects.player1.body:getY()
  
  x2 = objects.player2.body:getX()
  y2 = objects.player2.body:getY()
  
  if love.keyboard.isDown("d") then 
    objects.ball.body:applyForce(1600, 0)
  elseif love.keyboard.isDown("a") then
    objects.ball.body:applyForce(-1600, 0)
  elseif love.keyboard.isDown("w") then 
    objects.ball.body:applyForce(0, -1600)
  end
   
  if love.keyboard.isDown("h") then 
    objects.player1.body:setX(x + 5)
    --objects.player1.body:applyForce(1600, 0)
  end
  if love.keyboard.isDown("f") then
    objects.player1.body:setX(x - 5)
    --objects.player1.body:applyForce(-1600, 0)
  end
  if love.keyboard.isDown("t") then
    objects.player1.body:setY(y - 5)
    --objects.player1.body:applyForce(0, -2600)
  end
  if love.keyboard.isDown("g") then
    objects.player1.body:setY(y + 5)
  end
  
  if love.keyboard.isDown("l") then 
    objects.player2.body:setX(x2 + 5)
    --objects.player1.body:applyForce(1600, 0)
  end
  if love.keyboard.isDown("j") then
    objects.player2.body:setX(x2 - 5)
    --objects.player1.body:applyForce(-1600, 0)
  end
  if love.keyboard.isDown("i") then
    objects.player2.body:setY(y2 - 5)
    --objects.player1.body:applyForce(0, -2600)
  end
  if love.keyboard.isDown("k") then
    objects.player2.body:setY(y2 + 5)
  end
  
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  
  if (x < 50) then
    objects.player1.body:setX(x + 5)
  end
end
 
function love.draw()
  love.graphics.setColor(72, 160, 14) 
  love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
  love.graphics.polygon("fill", objects.bottom.body:getWorldPoints(objects.bottom.shape:getPoints()))
  love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
  love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
  
  love.graphics.setColor(193, 47, 14) 
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
 
  love.graphics.setColor(50, 50, 50) 
  love.graphics.polygon("fill", objects.player1.body:getWorldPoints(objects.player1.shape:getPoints()))
  love.graphics.polygon("fill", objects.player2.body:getWorldPoints(objects.player2.shape:getPoints()))
end
