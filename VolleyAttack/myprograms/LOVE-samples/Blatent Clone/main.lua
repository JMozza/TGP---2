require "menu"
require "omenu"

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
  
  medium = love.graphics.newFont("fonts/wallpoet/Wallpoet-Regular.ttf", 20)
  big = love.graphics.newFont("fonts/wallpoet/Wallpoet-Regular.ttf", 25)
  
  backgroundSound = love.audio.newSource("sounds/Background.mp3")
  volCount = 10
  
  ball = {}
  ball.radius = 10
  ball.x = width/2
  ball.y = height/2
  ball.speed = 200
  ball.direction = "d"
  
  gamestate = "menu"
  
  ---------------Menu Buttons---------------
  button_spawn(width/2 - 20,450,"Start", "start")
  button_spawn(width/2 - 20,500,"Options", "options")
  button_spawn(width/2 - 20,550,"Quit", "quit")
  obutton_spawn(294,300, "Mute", "mute")
  obutton_spawn(0,300,"Back", "back")
  obutton_spawn(266,360,"+", "+")
  obutton_spawn(266,380,"-", "-")
  ------------------------------------------
end

function love.update(dt)
  -- Bounce ball off walls
  if (ball.x <= 5) then
    --ballBounce:play()
    if ball.direction == "l" then ball.direction = "r"
    elseif ball.direction == "ul" then ball.direction = "ur"
    elseif ball.direction == "ull" then ball.direction = "urr"
    elseif ball.direction == "lu" then ball.direction = "ru"
    elseif ball.direction == "ld" then ball.direction = "rd"
    elseif ball.direction == "dll" then ball.direction = "drr"
    elseif ball.direction == "dl" then ball.direction = "dr"
    end
  end
  
  if (ball.x >= width - 5) then
    if ball.direction == "r" then ball.direction = "l"
    elseif ball.direction == "ur" then ball.direction = "ul"
    elseif ball.direction == "urr" then ball.direction = "ull"
    elseif ball.direction == "ru" then ball.direction = "lu"
    elseif ball.direction == "rd" then ball.direction = "ld"
    elseif ball.direction == "drr" then ball.direction = "dll"
    elseif ball.direction == "dr" then ball.direction = "dl"
    end
  end

  if (ball.y <= 5) then
    if ball.direction == "u" then ball.direction = "d"
    elseif ball.direction == "ul" then ball.direction = "dl"
    elseif ball.direction == "ull" then ball.direction = "dll"
    elseif ball.direction == "lu" then ball.direction = "ld"
    elseif ball.direction == "ur" then ball.direction = "dr"
    elseif ball.direction == "urr" then ball.direction = "drr"
    elseif ball.direction == "ru" then ball.direction = "rd"
    end
  end

  if (ball.y >= height - 5) then
    if ball.direction == "d" then ball.direction = "u"
    elseif ball.direction == "dl" then ball.direction = "ul"
    elseif ball.direction == "dll" then ball.direction = "ull"
    elseif ball.direction == "ld" then ball.direction = "lu"
    elseif ball.direction == "dr" then ball.direction = "ur"
    elseif ball.direction == "drr" then ball.direction = "urr"
    elseif ball.direction == "rd" then ball.direction = "ru"
    end
  end

  -- Move ball
  if ball.direction == "u" then
    ball.y = ball.y - 2 * (dt * ball.speed)
  elseif ball.direction == "ur" then
    ball.y = ball.y - 2 * (dt * ball.speed)
    ball.x = ball.x + 1 * (dt * ball.speed)
  elseif ball.direction == "urr" then
    ball.y = ball.y - 2 * (dt * ball.speed)
    ball.x = ball.x + 2 * (dt * ball.speed)
  elseif ball.direction == "ru" then
    ball.y = ball.y - 1 * (dt * ball.speed)
    ball.x = ball.x + 2 * (dt * ball.speed)
  elseif ball.direction == "r" then
    ball.x = ball.x + 2 * (dt * ball.speed)
  elseif ball.direction == "rd" then
    ball.y = ball.y + 1 * (dt * ball.speed)
    ball.x = ball.x + 2 * (dt * ball.speed)
  elseif ball.direction == "drr" then
    ball.y = ball.y + 2 * (dt * ball.speed)
    ball.x = ball.x + 2 * (dt * ball.speed)
  elseif ball.direction == "dr" then
    ball.y = ball.y + 2 * (dt * ball.speed)
    ball.x = ball.x + 1 * (dt * ball.speed)
  elseif ball.direction == "d" then
    ball.y = ball.y + 2 * (dt * ball.speed)
  elseif ball.direction == "dl" then
    ball.y = ball.y + 2 * (dt * ball.speed)
    ball.x = ball.x - 1 * (dt * ball.speed)
  elseif ball.direction == "dll" then
    ball.y = ball.y + 2 * (dt * ball.speed)
    ball.x = ball.x - 2 * (dt * ball.speed)
  elseif ball.direction == "ld" then
    ball.y = ball.y + 1 * (dt * ball.speed)
    ball.x = ball.x - 2 * (dt * ball.speed)
  elseif ball.direction == "l" then
    ball.x = ball.x - 2 * (dt * ball.speed)
  elseif ball.direction == "lu" then
    ball.y = ball.y - 1 * (dt * ball.speed)
    ball.x = ball.x - 2 * (dt * ball.speed)
  elseif ball.direction == "ull" then
    ball.y = ball.y - 2 * (dt * ball.speed)
    ball.x = ball.x - 2 * (dt * ball.speed)
  elseif ball.direction == "ul" then
    ball.y = ball.y - 2 * (dt * ball.speed)
    ball.x = ball.x - 1 * (dt * ball.speed)
  end
  
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function love.gameDraw()
  love.graphics.draw(gameBackground, gamebgQuad, 0, 0)
end

function love.optionsDraw()
  love.graphics.draw(optionsBackground, optionsbgQuad, 0, 0)
  obutton_spawn()
end

function love.draw()
  if gamestate == "playing" then
    gameDraw()
    love.graphics.draw(ballTexture, ball.x, ball.y)
  elseif gamestate == "menu" then 
    love.graphics.draw(menuBackground, menubgQuad, 0, 0)
    button_spawn()
  elseif gamestate == "options" then 
    optionsDraw()
  end
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