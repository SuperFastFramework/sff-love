function entityName(x,y)
    local anim_obj=anim()
    local w=1
    local h=1
    anim_obj:add(starting_fr,frame_cnt,speed, w,h)

    local e=entity(anim_obj)
    e:setpos(x,y)
    e:set_anim(1)

    local bounds_obj=bbox(w*sff.sprite.pxUnit,h*sff.sprite.pxUnit)
    e:set_bounds(bounds_obj)
    e.debugbounds=false
    e.speed = 1

    --[[
    function e:topdownmovement()
        self.lastdir=self.curdir
        -- Animation
        local moving = true
        if sff.gamepad.right then
            self:set_anim(2) --side
            self.curdir = sff.directions.RIGHT
        elseif sff.gamepad.left then
            self:set_anim(2) --side
            self.curdir = sff.directions.LEFT
        elseif sff.gamepad.up then
            self:set_anim(4) --up
            self.curdir = sff.directions.UP
        elseif sff.gamepad.down then
            self:set_anim(6) --down
            self.curdir = sff.directions.DOWN
        else
            moving = false
            if self.lastdir == sff.directions.RIGHT or self.lastdir == sff.directions.LEFT then
                self:set_anim(1) --idle-sides
            elseif self.lastdir == sff.directions.UP then
                self:set_anim(3) --idle-up
            elseif self.lastdir == sff.directions.DOWN then
                self:set_anim(5) --idle-down
            end
        end

        -- movement
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

            self:setx(self.x + (math.cos(angle)*self.speed))
            self:sety(self.y + -(math.sin(angle)*self.speed))
        end
    end
    ]]

    function e:update()
        -- e:topdownmovement()
    end


    -- overwrite entity's draw() function
    -- e._draw=e.draw
    -- function e:draw()
    --     self:_draw()
    --     ** your code here **
    -- end

    return e
end

