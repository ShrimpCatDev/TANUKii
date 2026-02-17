local Container=plan.Container

local rules=plan.Rules.new()
    :addX(plan.pixel(24))
    :addY(plan.pixel(24))
    :addWidth(plan.relative(0.1))
    :addHeight(plan.relative(0.05))

local panel=Container:extend()

function panel:new(rules)
    local p=panel.super.new(self,rules)
    p.r=16
    p.lt=4
    return p
end

function panel:draw()
    self.r=self.h/2
    lg.push("all")
    --local r=color(theme.ui.color)
    --lg.setColor(r[1],r[2],r[3],0.2)
    --lg.rectangle("fill",self.x,self.y,self.w,self.h,self.r,self.r)
    lg.setColor(color(theme.ui.color))
    lg.setLineWidth(4)
    lg.rectangle("line",self.x,self.y,self.w,self.h,self.r,self.r)
    lg.setLineWidth(1)
    lg.setColor(0.1,0.5,1,1)
        lg.circle("fill",self.x+self.w-(self.h/2),self.y+(self.h/2),(self.h/2)-2)
    lg.setColor(1,1,1,1)
    self.super.draw(self)
    lg.pop()
end

local container=panel:new(rules)
ui:addChild(container)