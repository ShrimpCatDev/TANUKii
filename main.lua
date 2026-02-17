require("init")
lg=love.graphics

local lgc=love.graphics.circle
function lg.circle(mode,x,y,r,...)
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
end

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

function love.load()
    theme={
        bg={color="#b9b9b9ff"},
        bg2={color="#dfdfdfff"},
        ui={color="#4e4e4eff"}
    }
    roms=require("roms")
    emu=require("emulators")
    love.window.setMode(1280,800,{resizable=true})
    
    --exec("snes",roms[1].path)

    ui=plan.new()
    require("widgets/profile")
    effect = moonshine(moonshine.effects.boxblur)
end

function love.update(dt)
    ui:update(dt)
end

function love.draw()
    
    
    effect(function() 
        lg.clear(color(theme.bg.color))
        local c=color(theme.bg2.color)
        local ww,hh=love.window.getMode()
        local gridSize = ww/12

        local w=gridSize-(gridSize/4)

        local offsetX = math.fmod(love.timer.getTime()*w/6,gridSize)
        local offsetY = math.fmod(love.timer.getTime()*w/6,gridSize)

        local offsetX2 = math.fmod(love.timer.getTime()*w/4,gridSize)
        local offsetY2 = math.fmod((love.timer.getTime()*w/4)+8,gridSize)

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
end