require "menu"
require "omenu"
require "game"
require "gmenu"

function love.load()
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()
  
  gameBackground = love.graphics.newImage("sprites/cyberpunk-street.png")
  gamebgQuad = love.graphics.newQuad(1,1,1920,1080,1920,1080)  
  menuBackground = love.graphics.newImage("sprites/cyberpunk-street.png")
  menubgQuad = love.graphics.newQuad(1,1,1920,1080,1920,1080)  
  optionsBackground = love.graphics.newImage("sprites/cyberpunk-street.png")
  optionsQuad = love.graphics.newQuad(1,1,1920,1080,720/2,1280/2) 
 
  ballTexture = love.graphics.newImage("sprites/ballTexture.png")
  charTexture = love.graphics.newImage("sprites/charTexture.png")
  char2Texture = love.graphics.newImage("sprites/char2Texture.png")
  
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
  
  -- Player 1 Setup (Left)
  player = {}
  player.width = 107
  player.height = 149
  player.x = width/3
  player.y = height - 200
  player.speed = 400
  player.jumpHeight = -500
  player.ground = player.y
  player.yVel = 0
  player.gravity = -500

  -- Player 2 Setup (Right)
  player2 = {}
  player2.width = 107
  player2.height = 149
  player2.x = width/4
  player2.y = height - 200
  player2.speed = 400
  player2.jumpHeight = -500
  player2.ground = player.y
  player2.yVel = 0
  player2.gravity = -500
  
  platform = {}
  platform.width = width
  platform.height = 5
  platform.x = 0
  platform.y = height - 100
  
  -- Ball Setup
  ball = {}
  ball.radius = 10
  ball.x = width/2
  ball.y = height/2
  ball.speed = 100
  ball.direction = "dl"
  
  ---------------Menu Buttons---------------
  button_spawn(width/2 - 20,450,"Start", "start")
  button_spawn(width/2 - 20,500,"Options", "options")
  button_spawn(width/2 - 20,550,"Quit", "quit")
  obutton_spawn(294,300, "Mute", "mute")
  obutton_spawn(0,300,"Back", "back")
  obutton_spawn(266,360,"+", "+")
  obutton_spawn(266,380,"-", "-")
  gbutton_spawn(width/2,360,"Restart", "restart")
  gbutton_spawn(width/2,380,"Menu", "mmenu")
  ------------------------------------------
end
 
function love.update(dt)
  mousex = love.mouse.getX()
  mousey = love.mouse.getY() 
  
  if gamestate == "menu" then
    button_check()
    backgroundSound:play()
  elseif gamestate == "options" then
    obutton_check()
    backgroundSound:play()
    volume()
  elseif gamestate == "gameover" then
    gbutton_check()
    backgroundSound:play()
  end
  
  if (gamestate == "playing") then
    gameUpdate(dt)
    backgroundSound:play()
    controls(dt)
  end
  
  --x = player.x
  --y = player.y
  
  --x2 = player2.x
  --y2 = player2.y
  
  
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  
  if (player.x <= 5) then
    player.x = player.x + 5
  end
  
  if (player.x >= width) then
    player.x = player.x - 5
  end
  
  if (player.y <= 5) then
    player.x = player.x + 5
  end
  
  if (player.y >= height) then
    player.x = player.x - 5
  end
  
  if (player2.x <= 5) then
    player2.x = player2.x + 5
  end
  
  if (player2.x >= width) then
    player2.x = player2.x - 5
  end
  
  if (player2.y <= 5) then
    player2.y = player2.y + 5
  end
  
  if (player2.y >= height) then
    player2.y = player2.y - 5
  end
  
end
 
function love.draw()
  ----------------------------
  if gamestate == "playing" then 
    gameDraw()
    love.graphics.draw(ballTexture, ball.x, ball.y)
    love.graphics.draw(charTexture, player.x, player.y)
    love.graphics.draw(char2Texture, player2.x, player2.y)
  elseif gamestate == "menu" then
    menuDraw()
  elseif gamestate == "options" then
    optionsDraw()
  end
  if gamestate == "gameover" then
    gameoverDraw()
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
  love.graphics.draw(gameBackground, gamebgQuad, 0, 0)
end

function gameoverDraw()
  love.graphics.draw(menuBackground, menubgQuad, 0, 0)
  love.graphics.print("Game Over", 100, 100)
  gbutton_draw()
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
    elseif gamestate == "gameover" then
      gbutton_click(x,y)
    end
end
