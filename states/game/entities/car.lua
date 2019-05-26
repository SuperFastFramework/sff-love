require("engine.sff.entity")
require("engine.base.gamepad")

--[[
WIP
]]--

function car(x,y,parent)
    local anim_obj=anim()
    anim_obj:addAnim("top", 99,1,1,1,1)
    anim_obj:addAnim("side", 98,1,1,1,1)
    anim_obj:addAnim("down", 100,1,1,1,1)

    local e=entity(anim_obj)
    e:setpos(x,y)
    e:set_anim("top")

    local bounds_obj=bbox(8,16, -4,-8)
    e:set_bounds(bounds_obj)
    e.debugbounds=false
    e.speed = 50
    anim_obj.angle = 0
    e.angle = 0

    function e:movement(dt)

        -- Make angle between 0 and 360
        local deg = math.deg(e.angle)
        if deg > 360 then
            deg = deg - 360
            anim_obj.angle = math.rad(deg)
        elseif deg < 0 then
            deg = deg + 360
            anim_obj.angle = math.rad(deg)
        end
print(deg)
        -- Animation
        e.flipx = false

        if deg >= 45 and deg <= 135 then
            self:set_anim("top")
        elseif (deg > 135 and deg <= 225) or ((deg < 45 and deg >= 0) or (deg < 0 and deg >= 315))then
            if deg > 135 and deg <= 225 then
                e.flipx = true
            end
            self:set_anim("side")
        elseif deg > 225 and deg < 315 then
            self:set_anim("down")
        end

        -- Movement
        local move = false
        if sff.gamepad.up then
            move=true
        end

        if sff.gamepad.right then
            e.angle = e.angle - math.rad(2)
        elseif sff.gamepad.left then
            e.angle = e.angle + math.rad(2)
        end

        if move then
            self:setx(self.x + (math.cos(e.angle)*self.speed)*dt)
            self:sety(self.y - (math.sin(e.angle)*self.speed)*dt)
        end
    end

    function e:update(dt)
        e:movement(dt)

        -- camera locked on player
        camera.x = e.x
        camera.y = e.y
    end

    -- overwrite entity's draw() function
    e._draw=e.draw
    function e:draw()
        self:_draw()

    end

    add(parent, e)
    return e
end