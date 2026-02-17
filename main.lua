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
        ui={color="#f0f0f0ff"}
    }
    roms=require("roms")
    emu=require("emulators")
    love.window.setMode(1280,800,{resizable=true})
    
    --exec("snes",roms[1].path)

    ui=plan.new()
    require("widgets/profile")
end

function love.update(dt)
    ui:update(dt)
end

function love.draw()
    lg.clear(color(theme.bg.color))
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
end

function love.resize(w,h)
    ui:refresh()
end