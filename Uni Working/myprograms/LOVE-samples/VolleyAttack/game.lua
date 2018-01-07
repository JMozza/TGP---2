function gameDraw()
  love.graphics.draw(gameBackground, gamebgQuad, 0, 0)
  
  -- Draw Characters
  --love.graphics.draw(charTexture, player.x, player.y)
  --love.graphics.draw(char2Texture, player2.x, player2.y)
  
  -- Draw Ball
  --love.graphics.draw(ballTexture, ball.x, ball.y)
end

function gameUpdate(dt)
  -- Hitbox between player 1 and ball
  if ball.y >= player.y and ball.y <= height and ball.x >= player.x and
    ball.x <= (player.x + player.width) then
    --blockBounce:play()
    if ball.x >= player.x and ball.x < (player.x + 10) then
      ball.direction = "dll"
    elseif ball.x >= (player.x + 15) and ball.x < (player.x + 25) then
      ball.direction = "dl"
    elseif ball.x >= (player.x + 30) and ball.x < (player.x + 40) then
      ball.direction = "ddl"
    elseif ball.x >= (player.x + 45) and ball.x < (player.x + 55) then
      ball.direction = "dl"
    elseif ball.x >= (player.x + 60) and ball.x < (player.x + 70) then
      ball.direction = "ddr"
    elseif ball.x >= (player.x + 75) and ball.x < (player.x + 85) then
      ball.direction = "dr"
    elseif ball.x >= (player.x + 90) and ball.x < (player.x + 100) then
      ball.direction = "drr"
    end
  end
  
  -- Hitbox between player 2 and ball
  if ball.y <= player2.y and ball.y <= height and ball.x >= player2.x and
    ball.x <= (player2.x + player2.width) then
    --blockBounce:play()
    if ball.x >= player2.x and ball.x < (player2.x + 10) then
      ball.direction = "uur"
    elseif ball.x >= (player2.x + 15) and ball.x < (player2.x + 25) then
      ball.direction = "ur"
    elseif ball.x >= (player2.x + 30) and ball.x < (player2.x + 40) then
      ball.direction = "urr"
    elseif ball.x >= (player2.x + 45) and ball.x < (player2.x + 55) then
      ball.direction = "ur"
    elseif ball.x >= (player2.x + 60) and ball.x < (player2.x + 70) then
      ball.direction = "uul"
    elseif ball.x >= (player2.x + 75) and ball.x < (player2.x + 85) then
      ball.direction = "ul"
    elseif ball.x >= (player2.x + 90) and ball.x < (player2.x + 100) then
      ball.direction = "ull"
    end
  end
  
  -- Wall Bounce
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
end

function controls(dt)
  if love.keyboard.isDown("right") then
    player.x = player.x + (dt * player.speed)
  elseif love.keyboard.isDown("left") then
    player.x = player.x - (dt * player.speed)
  end
  
  if love.keyboard.isDown("d") then
    player2.x = player2.x + (dt * player2.speed)
  elseif love.keyboard.isDown("a") then
    player2.x = player2.x - (dt * player2.speed) 
  end
    
  if player.x <= 0 then
    player.x = player.x + (dt * player.speed)
  elseif player.x + player.width >= width then
    player.x = player.x - (dt * player.speed)
  end
  
  if player2.x <= 0 then
    player2.x = player2.x + (dt * player.speed)
  elseif player2.x + player.width >= width then
    player2.x = player2.x - (dt * player.speed)
  end
end

function reLoad()
  player.width = 90
  player.height = 12
  player.x = width/2 - player.width/2
  player.y = 620
  player.speed = 400

  player2.width = 90
  player2.height = 12
  player2.x = width/2 - player2.width/2
  player2.y = 20
  player2.speed = 400
  
  ball.radius = 10
  ball.x = width/2
  ball.y = 540
  ball.speed = 100
  ball.direction = "d"
end
