require("engine.sff.collision")
require("engine.sff.entity")
require("engine.base.gamepad")

function game()
    local s={}
    sff.gamepad.clear()

    function hero(x,y)
        local anim_obj=anim()
        anim_obj:addAnim(1,4,0.05,1,1)  -- idle-side
        anim_obj:addAnim(6,4,0.19,1,1)  -- side
        anim_obj:addAnim(33,2,0.05,1,1) -- idle-up
        anim_obj:addAnim(36,4,0.15,1,1) -- up
        anim_obj:addAnim(17,4,0.05,1,1) -- idle-down
        anim_obj:addAnim(22,4,0.15,1,1) -- down

        local e=entity(anim_obj)
        e:setpos(x,y)
        e:set_anim(1)
    
        local bounds_obj=bbox(8,16, -4,-8)
        e:set_bounds(bounds_obj)
        e.debugbounds=false
        e.lastdir=sff.directions.RIGHT
        e.curdir=sff.directions.RIGHT
        e.speed = 1


        function e:movement()
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

                self:setx(self.x + (math.cos(angle)*self.speed))
                self:sety(self.y + -(math.sin(angle)*self.speed))
            end

        end

        function e:update()
            e:movement()
        end
    
        -- overwrite entity's draw() function
        -- e._draw=e.draw
        -- function e:draw()
        --     self:_draw()
        --     ** your code here **
        -- end
    
        return e
    end

    local h = hero(60,60)
    local j = hero(80,60)

    -- sff.gamepad.enterCallback =
    -- sff.gamepad.aCallback     =
    -- sff.gamepad.bCallback     =

    function s:update(dt)
        h:update()
        if collides(h, j) then
            --print("collides")
        end
    end


    function s:draw()
        love.graphics.setColor(sff.palette[16])
        love.graphics.rectangle("fill",0,0,CONF.width, CONF.height)
        love.graphics.setColor(sff.palette[9])
        h:draw()
        j:draw()
    end

    return s
end