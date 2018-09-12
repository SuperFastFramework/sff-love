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

    function e:update()
    end

    -- overwrite entity's draw() function
    -- e._draw=e.draw
    -- function e:draw()
    --     self:_draw()
    --     ** your code here **
    -- end

    return e
end

