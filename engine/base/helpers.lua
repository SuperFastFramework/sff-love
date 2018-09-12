-- I want to write the love.graphics.setColor like in love 11. This overwrite allows that
local sc=love.graphics.setColor
function love.graphics.setColor(r,g,b,a)
    if type(r) == 'table' then
        local t = r
        r = t[1]
        g = t[2]
        b = t[3]
        a = t[4]
    end

    sc(r*255, g*255, b*255, a*255)
end

function add(tbl, obj)
    table.insert(tbl, obj)
    obj.tidx = #tbl
end

function del(tbl, obj)
    table.remove(tbl, obj.tidx)
end