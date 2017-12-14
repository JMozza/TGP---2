require "menu"
require "omenu"

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
  
  gameBackground = love.graphics.newImage("sprites/cyberpunk-street.png")
  gamebgQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)  
  menuBackground = love.graphics.newImage("sprites/cyberpunk-street.png")
  menubgQuad = love.graphics.newQuad(1,1,1920,1080,1920,1080)  
  optionsBackground = love.graphics.newImage("sprites/cyberpunk-street.png")
  optionsQuad = love.graphics.newQuad(1,1,1920,1080,720/2,1280/2)  
 
  love.graphics.setBackgroundColor(104, 136, 248) 
  love.window.setMode(1920, 1080) 
  
  medium = love.graphics.newFont("fonts/wallpoet/Wallpoet-Regular.ttf", 20)
  big = love.graphics.newFont("fonts/wallpoet/Wallpoet-Regular.ttf", 25)
  --love.graphics.setColor(1, 1, 1)
  
  gamestate = "menu"
  
  ---------------Audio---------------
  backgroundSound = love.audio.newSource("sounds/Background.mp3")
  volCount = 10
  -----------------------------------
  
  ---------------Menu Buttons---------------
  button_spawn(140,350,"Start", "start")
  button_spawn(130,400,"Options", "options")
  button_spawn(145,450,"Quit", "quit")
  obutton_spawn(294,300, "Mute", "mute")
  obutton_spawn(0,300,"Back", "back")
  obutton_spawn(266,360,"+", "+")
  obutton_spawn(266,380,"-", "-")
  ------------------------------------------
end

 
function love.update(dt)
  world:update(dt) 
  mousex = love.mouse.getX()
  mousey = love.mouse.getY() 
  
  if gamestate == "menu" then
    button_check()
  elseif gamestate == "options" then
    obutton_check()
    volume()
  elseif gamestate == "playing" then
    game()
  end
  
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
  
  -----------------------------
  if gamestate == "playing" then 
    gameDraw()
  elseif gamestate == "menu" then
    menuDraw()
  elseif gamestate == "options" then
    optionsDraw()
  end
  -----------------------------
end

function menuDraw()
  love.graphics.draw(menuBackground, menubgQuad, 0, 0)
  button_draw()
end

function optionsDraw()
  love.graphics.draw(menuBackground, menubgQuad, 0, 0)
  obutton_draw()
end

function gameDraw()
  love.graphics.draw(menuBackground, menubgQuad, 0, 0)
  button_draw()
end

function volume()
    if volCount == 10 then
      backgroundSound:setVolume(1.0)
    elseif volCount == 9 then
      backgroundSound:setVolume(0.9)
    elseif volCount == 8 then
      backgroundSound:setVolume(0.8)
    elseif volCount == 7 then
      backgroundSound:setVolume(0.7)
    elseif volCount == 6 then
      backgroundSound:setVolume(0.6)
    elseif volCount == 5 then
      backgroundSound:setVolume(0.5)
    elseif volCount == 4 then
      backgroundSound:setVolume(0.4)
    elseif volCount == 3 then
      backgroundSound:setVolume(0.3)
    elseif volCount == 2 then
      backgroundSound:setVolume(0.2)
    elseif volCount == 1 then
      backgroundSound:setVolume(0.1)
    elseif volCount == 0 then
      backgroundSound:setVolume(0.0)
    end
end

function love.mousepressed(x,y)
    if gamestate == "menu" then
      button_click(x,y)
    elseif gamestate == "options" then
      obutton_click(x,y)
    elseif gamestate == "playing" then
      
    end
end
