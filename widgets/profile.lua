local Container=plan.Container

local rules=plan.Rules.new()
    :addX(plan.relative(0.01))
    :addY(plan.relative(0.02))
    :addWidth(plan.relative(0.15))
    :addHeight(plan.aspect(0.255))

local panel=Container:extend()

function panel:new(rules)
    local p=panel.super.new(self,rules)
    p.r=16
    p.lt=4
    return p
end

function panel:draw()
    lg.setCanvas(canvas)
        self.r=self.h/2
        lg.push("all")

        lg.setColor(color(theme.ui.color))
        lg.setLineWidth(self.w/56)
        lg.rectangle("line",self.x,self.y,self.w,self.h,self.r,self.r)
        lg.setLineWidth(1)

        lg.setFont(loadFont(self.h*0.5))
        local f=lg.getFont()
        local s="12:42 PM"
        lg.print(s,self.x+(self.w/16),self.y+(self.h/2)-(f:getHeight()/2))

        lg.setColor(1,1,1,1)

        self.super.draw(self)
        lg.pop()
    lg.setCanvas()
end

local container=panel:new(rules)
ui:addChild(container)