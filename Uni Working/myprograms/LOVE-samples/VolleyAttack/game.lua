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
  if (ball.x <= player.x + player.width) and (ball.y >= player.y + player.height) then
    --death:play()
    gamestate = "gameover"
  end
  
  -- Hitbox between player 2 and ball
  if (ball.x <= player2.x + player2.width) and (ball.y >= player2.y + player2.height) then
    --death:play()
    gamestate = "gameover"
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
  
  if love.keyboard.isDown("m") then
    if player.yVel == 0 then
      player.yVel = player.jumpHeight
    end
  end
  
  if player.yVel ~= 0 then
		player.y = player.y + player.yVel * dt
		player.yVel = player.yVel - player.gravity * dt
	end
  
  if player.y > player.ground then
		player.yVel = 0
    	player.y = player.ground
	end
  
  if love.keyboard.isDown("space") then
    if player2.yVel == 0 then
      player2.yVel = player2.jumpHeight
    end
  end
  
  if player2.yVel ~= 0 then
		player2.y = player2.y + player2.yVel * dt
		player2.yVel = player2.yVel - player2.gravity * dt
	end
  
  if player2.y > player2.ground then
		player2.yVel = 0
    	player2.y = player2.ground
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
  gamestate = "playing"
  
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
end
