require("engine.sff.collision")
require("engine.sff.entity")
require("engine.base.gamepad")

function game()
    local s={}
    sff.gamepad.clear()

    function hero(x,y)
        local anim_obj=anim()
        anim_obj:addAnim(1,5,0.1,1,2)
    
        local e=entity(anim_obj)
        e:setpos(x,y)
        e:set_anim(1)
    
        local bounds_obj=bbox(8,16, -4,-8)
        e:set_bounds(bounds_obj)
        e.debugbounds=false
    
        function e:update()
            if sff.gamepad.right then
                self:setx(self.x + 1)
                self.flipx = false
            elseif sff.gamepad.left then
                self.flipx = true
                self:setx(self.x - 1)
            end
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
        h:draw()
        j:draw()
    end

    return s
end