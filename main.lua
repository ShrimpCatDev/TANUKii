require("init")
lg=love.graphics

require("init")
lg=love.graphics

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
    roms=require("roms")
    emu=require("emulators")
    love.window.setMode(1280,800,{resizable=true})
    
    --os.execute('"')
    exec("snes",roms[1].path)
end

function love.update()

end

function love.draw()

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