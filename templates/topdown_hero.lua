require("engine.sff.entity")
require("engine.base.gamepad")

function hero(x,y,parent)
    local anim_obj=anim()
    anim_obj:addAnim("idle-side", 1,4,0.05,1,1)
    anim_obj:addAnim("side",      6,4,0.19,1,1)
    anim_obj:addAnim("idle-up",  33,2,0.05,1,1)
    anim_obj:addAnim("up",       36,4,0.15,1,1)
    anim_obj:addAnim("idle-down",17,4,0.05,1,1)
    anim_obj:addAnim("down",     22,4,0.15,1,1)

    local e=entity(anim_obj)
    e:setpos(x,y)
    e:set_anim("idle-side")

    local bounds_obj=bbox(8,16, -4,-8)
    e:set_bounds(bounds_obj)
    e.debugbounds=false
    e.lastdir=sff.directions.RIGHT
    e.curdir=sff.directions.RIGHT
    e.speed = 50


    function e:movement(dt)
        self.lastdir=self.curdir
        -- Animation
        local moving = true
        if sff.gamepad.right then
            self:set_anim("side")
            self.curdir = sff.directions.RIGHT
        elseif sff.gamepad.left then
            self:set_anim("side")
            self.curdir = sff.directions.LEFT
        elseif sff.gamepad.up then
            self:set_anim("up")
            self.curdir = sff.directions.UP
        elseif sff.gamepad.down then
            self:set_anim("down")
            self.curdir = sff.directions.DOWN
        else
            moving = false
            if self.lastdir == sff.directions.RIGHT or self.lastdir == sff.directions.LEFT then
                self:set_anim("idle-side")
            elseif self.lastdir == sff.directions.UP then
                self:set_anim("idle-up")
            elseif self.lastdir == sff.directions.DOWN then
                self:set_anim("idle-down")
            end
        end

        -- Movement
        if moving then
            local angle = 0
            if sff.gamepad.up then
                angle = math.rad(90)
            elseif sff.gamepad.down then
                angle = math.rad(270)
            end

            if sff.gamepad.right then
                self.flipx = false
                if angle > 0 then
                    if sff.gamepad.up then
                        angle = angle - math.rad(45)
                    else
                        angle = angle + math.rad(45)
                    end
                else
                    angle = 0
                end
            elseif sff.gamepad.left then
                self.flipx = true
                if angle > 0 then
                    if sff.gamepad.up then
                        angle = angle + math.rad(45)
                    else
                        angle = angle - math.rad(45)
                    end
                else
                    angle = math.rad(180)
                end
            end

            self:setx(self.x + (math.cos(angle)*self.speed)*dt)
            self:sety(self.y + -(math.sin(angle)*self.speed)*dt)
        end

    end

    function e:update(dt)
        e:movement(dt)

        -- camera locked on player
        camera.x = e.x
        camera.y = e.y
    end

    -- overwrite entity's draw() function
    -- e._draw=e.draw
    -- function e:draw()
    --     self:_draw()
    --     ** your code here **
    -- end

    add(parent, e)
    return e
end