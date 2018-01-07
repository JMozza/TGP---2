obutton = {}

function obutton_spawn(x,y,text,id)
    table.insert(obutton, {x = x, y = y, text = text, id = id, mouseovertext = false})
end

function obutton_draw()
  for i,v in ipairs(obutton) do
    if v.mouseovertext == true then
      love.graphics.setFont(big)
    end
    if v.mouseovertext == false then
      love.graphics.setFont(medium)
    end
    love.graphics.print(v.text,v.x,v.y)
  end
    love.graphics.setColor(255,255,255)
  end

function obutton_click(x,y)
    for i,v in ipairs(obutton) do
        if x > v.x and
        x < v.x + medium:getWidth(v.text) and
        y > v.y and
        y < v.y + medium:getHeight() then
            if v.id == "back" then
              gamestate = "menu"
              menuClick:play()
            end
            if v.id == "+" then
              if volCount < 10 then
                volCount = volCount + 1
              elseif volCount == 10 then
                volCount = volCount
              end
            end
            if v.id == "-" then
              if volCount > 0 then
                volCount = volCount - 1
              elseif volCount < 1 then
                volCount = volCount
              end
            end
            if v.id == "mute" then
              if volCount > 0 then
                volCount = 0
              elseif volCount == 0 then
                volCount = volCount + 10
              end
            end
        end            
    end
end

function obutton_check()
  for i,v in ipairs(obutton) do
    if mousex > v.x and
    mousex < v.x + medium:getWidth(v.text) and
    mousey > v.y and
    mousey < v.y + medium:getHeight() then
      v.mouseovertext = true
    else
      v.mouseovertext = false
    end
  end
end