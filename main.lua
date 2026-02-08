require("init")
lg=love.graphics

function love.load()
    roms=require("roms")
    love.window.setMode(1280,800,{resizable=true})
    
    select=1
end

function love.update()

end

function love.draw()
    for k,v in ipairs(roms) do
        if select==k then
            lg.print("=> "..v.name,0,(k-1)*12)
        else
            lg.print(v.name,0,(k-1)*12)
        end
    end
end

function love.keypressed(k)
    if k=="z" then

    end
end