require("engine.sff.entity")
require("engine.base.helpers")

function mage(x,y,parent)
    local anim_obj=anim()
    local w=1
    local h=1
    anim_obj:addAnim(49,1,0.01, w,h)

    local e=entity(anim_obj)
    e:setpos(x,y)
    e:set_anim(1)

    local bounds_obj=bbox(w*sff.sprite.pxUnit,h*sff.sprite.pxUnit)
    e:set_bounds(bounds_obj)
    e.debugbounds=false
    e.speed = 1

    function e:update()
        -- e:topdownmovement()
    end

    add(parent, e)
    return e
end

