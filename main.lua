require("init")
lg=love.graphics

local lgc=love.graphics.circle
--[[function lg.circle(mode,x,y,r,...)
    if mode=="fill" then
        lgc("fill",x,y,r)
        local w=lg.getLineWidth()
        lg.setLineWidth(1)
    end
    lgc("line",x,y,r)
    if w then lg.setLineWidth(w) end
end
local lgr=love.graphics.rectangle
function lg.rectangle(mode,x,y,...)
    if mode=="fill" then
        lgr("fill",x,y,...)
        local w=lg.getLineWidth()
        lg.setLineWidth(1)
    end
    lgr("line",x,y,...)
    if w then lg.setLineWidth(w) end
end]]

local function exec(e,rom)
    local t=""

    t=emu[e].command..' '
    for k,v in pairs(emu[e].args) do
        if v=="{rom}" then
            t=t..'"'..rom..'"'
        else
            
            t=t..'"'..v..'" '
        end
    end
    print(t)
    os.execute(t)
end

cache={
    font={}
}

function loadFont(size)
    local fs=math.floor(size)
    if not cache.font[fs] then
        cache.font[fs]=lg.newFont("assets/contb.ttf",fs)
    end
    return cache.font[fs]
end

function love.load()
    theme={
        bg={color="#63e3faff"},
        bgg={color="#4fb175ff"},
        bg2={color="#cfdbe7ff"},
        ui={color="#e1f2fdff"}
        
        --[[bg={color="#b9b9b9ff"},
        bgg={color="#969696ff"},
        bg2={color="#dfdfdfff"},
        ui={color="#4e4e4eff"}]]
        
    }
    roms=require("roms")
    emu=require("emulators")
    love.window.setMode(1280,800,{resizable=true})
    
    --exec("snes",roms[1].path)

    ui=plan.new()
    require("widgets/profile")
    require("widgets/stats")

    effect = moonshine(moonshine.effects.boxblur)
    local w,h=love.window.getMode()
    canvas=lg.newCanvas(w,h)
    local music=love.audio.newSource("assets/dsi.mp3","stream")
    music:setLooping(true)
    music:play()
end

function love.update(dt)
    ui:update(dt)
end


--yoinked from the love2d wiki

function gradient(colors)
    local direction = colors.direction or "horizontal"
    if direction == "horizontal" then
        direction = true
    elseif direction == "vertical" then
        direction = false
    else
        error("Invalid direction '" .. tostring(direction) .. "' for gradient.  Horizontal or vertical expected.")
    end
    local result = love.image.newImageData(direction and 1 or #colors, direction and #colors or 1)
    for i, color in ipairs(colors) do
        local x, y
        if direction then
            x, y = 0, i - 1
        else
            x, y = i - 1, 0
        end
        result:setPixel(x, y, color[1], color[2], color[3], color[4] or 255)
    end
    result = love.graphics.newImage(result)
    result:setFilter('linear', 'linear')
    return result
end
function drawinrect(img, x, y, w, h, r, ox, oy, kx, ky)
    return -- tail call for a little extra bit of efficiency
    love.graphics.draw(img, x, y, r, w / img:getWidth(), h / img:getHeight(), ox, oy, kx, ky)
end

function love.draw()
    lg.setCanvas(canvas)
        local c=color(theme.ui.color)
        lg.clear(c[1],c[2],c[3],0)
    lg.setCanvas()
    
    effect(function() 
        local ww,hh=love.window.getMode()
        lg.clear(color(theme.bg.color))

        local c=color(theme.bgg.color)
        local g=gradient({{0,0,0,0},c,c,direction="horizontal"})

        local s=4
        drawinrect(g, 0, -hh*1.2, ww, hh*s)

        lg.setColor(1,1,1,1)
        local c=color(theme.bg2.color)
        local gridSize = ww/10

        local w=gridSize-(gridSize/4)

        local offsetX = math.fmod(love.timer.getTime()*w/8,gridSize)
        local offsetY = math.fmod(love.timer.getTime()*w/8,gridSize)

        local offsetX2 = math.fmod(love.timer.getTime()*w/6,gridSize)
        local offsetY2 = math.fmod((love.timer.getTime()*w/6)+8,gridSize)

        for x = -gridSize, lg.getWidth() + gridSize, gridSize do
            for y = -gridSize, lg.getHeight() + gridSize, gridSize do
                lg.setColor(c[1],c[2],c[3],0.2)
                lg.rectangle("fill", x - offsetX, y-offsetY, w,w,w/8,w/8)
                lg.setColor(c[1],c[2],c[3],0.2)
                lg.rectangle("fill", x + offsetX2, y + offsetY2, w,w,w/8,w/8)
            end
        end
    end)
    --[[lg.setColor(color(theme.ui.color))
    lg.setLineWidth(4)
    lg.rectangle("line",8,8,64,64,8,8)
    lg.setLineWidth(1)]]
    ui:draw()

    lg.setColor(0,0,0,0.2)
    lg.draw(canvas,4,4)

    lg.setColor(1,1,1,1)
    lg.draw(canvas)
end

function love.keypressed(k)
    --[[if k=="z" then
        --os.execute(emu[roms[select].emu].." "..roms[select].path)
        os.execute('"'..emu[arg[roms[select].emu].emu]..'" '..arg[roms[select].emu].arg..' "'..roms[select].path..'"')
    end
    if k=="up" then
        select=select-1
        if select<1 then
            select=#roms
        end
    end
    if k=="down" then
        select=select+1
        if select>#roms then
            select=1
        end
    end]]
    if k=="f11" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
end

function love.resize(w,h)
    ui:refresh()
    effect.resize(w,h)
    canvas=lg.newCanvas(w,h)
end