function entityName(parent)
    local e = {}

    function e:update(dt)

    end

    function e:draw()

    end

    function e:destroy()
        del(parent, e)
    end

    add(parent, e)
    return e
end

