require "menu"

function love.load()
  
  math.randomseed(os.time())

  menubg = love.graphics.newImage("sprites/starfield.png")
  menubgQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)
  
  gameover = love.graphics.newImage("sprites/gameover1.png")
  gameoverQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)
  
  background = love.graphics.newImage("sprites/starfieldgame.png")
  backgroundQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)
  
  medium = love.graphics.newFont("fonts/wallpoet/Wallpoet-Regular.ttf", 20)
  love.graphics.setFont(medium)
  love.graphics.setColor(1,1,1)
  
  bgmusic = love.audio.newSource("sounds/Space Trip.mp3")
  --music = 1
  jumpsound = love.audio.newSource("sounds/jump.mp3")
  
  gamestate = "menu"
  
  score = 0
  count = 0
  
  mute = 0
  
  pipeSpeed = 1.5
  coinSpeed = 1.5 
  
  flappy = love.graphics.newImage("sprites/mship.png")
  flappy2 = love.graphics.newImage("sprites/mship1.png")
  flappyPosX = 0
  flappyPosY = 200-- Flappy staring position on screen
  
  flappyVelY = 1
  flappyGrav = -400
  flappyHeight = -500
  
  pipe = love.graphics.newImage("sprites/metaltext.png")
  pipePosX = 500
  pipePosY = math.random(200,300)
  
  pipe2 = love.graphics.newImage("sprites/metaltext2.png")
  pipe2PosX = 500 
  pipe2PosY = pipePosY - 870    --680   
  
  coin = love.graphics.newImage("sprites/pship.png")
  coinPosX = pipePosX - 100
  coinPosY = pipePosY - 100
  
  --Menu
  button_spawn(140,250,"Start", "start")
  button_spawn(144,300, "Quit", "quit")
  
end

function love.update(dt)
  
  mousex = love.mouse.getX()
  mousey = love.mouse.getY()
  
  --if gamestate == "menu" then
    --love.graphics.draw(background, backgroundQuad, 0, 0) -- change to menubg and menubgQuad if this dont work
    --game_menu()
  
    if gamestate == "playing" then
    game_screen()
  
  --elseif love.keyboard.isDown("space") and gamestate == "playing" then
    --love.graphics.draw(background, backgroundQuad, 0, 0)
    --game_screen()
  
  --elseif gamestate == "playing" or gamestate == "hitpipe" then
    --love.graphics.draw(background, backgroundQuad, 0, 0)
    --game_hit()
    
  elseif gamestate == "gameover" then
    love.graphics.print("Score: " .. score, 10, 10)
    game_over()
  end
  
  map_collide()
  
  if flappyVelY ~= 1 then
    flappyPosY = flappyPosY + flappyVelY * dt
    flappyVelY = flappyVelY - flappyGrav * dt
  end
  
end

function love.draw()
  
  if gamestate == "menu" then
    love.graphics.draw(menubg, menubgQuad, 0, 0)
    button_draw()
    --game_menu()
    
  elseif gamestate == "playing" then
    love.graphics.draw(background, backgroundQuad, 0, 0)
    game_screen()
    
  elseif gamestate == "gameover" then
    --love.graphics.draw(background, backgroundQuad, 0, 0)
    game_over()
    
  --elseif gamestate == "hitpipe" then
    --love.graphics.draw(background, backgroundQuad, 0, 0)
    --game_screen()
    
  end

end

function love.mousepressed(x,y)
    if gamestate == "menu" then
      button_click(x,y)
    end
end

--function game_menu()
  --if love.keyboard.isDown("return") then
    --gamestate = "playing"
    --bgmusic:play()
    --bgmusic:setVolume(0.1) 
  --end
  --love.graphics.print("Press Enter To Start")
--end

function game_over()
  love.graphics.draw(gameover, gameoverQuad, 0, 0)
  
  if love.keyboard.isDown("escape") then
  love.event.push("quit")
  end

  love.graphics.print("Score: " .. score, 10, 5)
  
  if love.keyboard.isDown("r") then
    gamestate = "playing"
    flappyPosX = 0
    flappyPosY = 200
    pipePosX = 600
    pipe2PosX = pipePosX
    --coinPosX = pipePosX - 100
    flappyGrav = -400
    flappyHeight = -500
    score = 0
    pipeSpeed = 1.5
    --mute = 0
  end
end

function map_collide()
  if flappyPosY > 700  or flappyPosY < -50 then
    gamestate = "gameover"
  end    
end

function game_screen()
  
  love.graphics.draw(pipe, pipePosX, pipePosY)
  love.graphics.draw(pipe2, pipe2PosX, pipe2PosY)
  --love.graphics.draw(coin, coinPosX, pipePosY - 121)
  love.graphics.draw(flappy, 125, flappyPosY)
  
  if love.keyboard.isDown("space") then
    love.graphics.draw(flappy2, 125, flappyPosY)
  end
  
  love.graphics.print("Score: " .. score, 10, 20 )
  love.graphics.print("M to mute", 10, 40)

  pipePosX = pipePosX - pipeSpeed
  pipe2PosX = pipePosX
  --coinPosX = pipePosX
  
  bgmusic:play()
  
  if love.keyboard.isDown("m") then
    mute = 1
  end
  if love.keyboard.isDown(",") then
    mute = 0
  end
  
  if mute == 0 then
  bgmusic:setVolume(0.1)
  
  elseif mute == 1 then
  bgmusic:setVolume(0.0)
  end

  if pipePosX <= flappyPosX then
    while count == 0 do
      score = score + 1
      count = count + 1
    end
  end
  
  if pipePosX < -50 then
    count = 0
  end
  
  if love.keyboard.isDown("escape") then
  love.event.push("quit")
  end

  if pipePosX < -50 then
    pipePosY = math.random(200,600) --200,600
    pipe2PosY = pipePosY - 870
    --coinPosY = pipePosY - math.random(200, 800)
    pipePosX = 400
    --coinPosX = pipePosX - 100
    pipeSpeed = pipeSpeed * 1.05
    --coinSpeed = pipeSpeed
    --count = 0
  end
  
  if love.keyboard.isDown("space") then
      flappyVelY = flappyHeight
      
      jumpsound:play()
      
      if mute == 0 then
      jumpsound:setVolume(0.5)
      
      elseif mute == 1 then
      jumpsound:setVolume(0.0)
      end
  end
  
  flappyPosY = flappyPosY + 2.5
  
  hitTest = CheckCollision(pipePosX, pipePosY, 47, 708, 125, flappyPosY, 45, 45) --60 150
  if(hitTest) then
      --gamestate = "hitpipe"
      gamestate = "gameover"
  end
  
   hitTest2 = CheckCollision(pipe2PosX, pipe2PosY, 47, 708, 125, flappyPosY, 45, 45) --first values graphics sizes/ 125 flappy  x pos 60 522
  if(hitTest2) then
      --gamestate = "hitpipe"
      gamestate = "gameover"
  end
  
  --hitTest3 = CheckCollision(coinPosX, coinPosY, 50, 50, 125, flappyPosY, 45, 45) --first values graphics sizes/ 125 flappy x pos
  --if(hitTest3) then
      --gamestate = "gameover"
  --end
  
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
