local Container=plan.Container

local rules=plan.Rules.new()
    :addX(plan.center())
    :addY(plan.relative(0.15))
    :addWidth(plan.relative(0.95))
    :addHeight(plan.relative(0.7))

local panel=Container:extend()

function panel:new(rules)
    local p=panel.super.new(self,rules)
    p.r=16
    p.lt=4
    return p
end

local function grect(steps,x,y,w,h,...)
    local r,g,b=lg.getColor()
    lg.setLineWidth(2)
    for i=0,steps do
        local n=i/steps
        lg.setColor(r,g,b,1-n)
        lg.rectangle("line",x+i,y+i,w-(i+i),h-(i+i),...)
    end
    lg.setLineWidth(1)
end

function panel:draw()
    lg.setCanvas(canvas)
        local w,h=love.window.getMode()

        self.r=w/32
        lg.push("all")



        local c=color(theme.ui.color)
        lg.setColor(c[1],c[2],c[3],0.3)
        lg.rectangle("fill",self.x,self.y,self.w,self.h,self.r,self.r)
        lg.setColor(c[1],c[2],c[3],1)
        grect(w/48,self.x,self.y,self.w,self.h,self.r,self.r)

        lg.setColor(color(theme.ui.color))
        lg.setLineWidth(self.w/300)
        lg.rectangle("line",self.x,self.y,self.w,self.h,self.r,self.r)
        lg.setLineWidth(1)

        lg.setFont(loadFont(self.h*0.5))
        local f=lg.getFont()

        lg.setColor(1,1,1,1)

        self.super.draw(self)
        lg.pop()
    lg.setCanvas()
end

local container=panel:new(rules)
ui:addChild(container)