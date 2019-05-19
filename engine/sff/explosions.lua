-- implements updatable and drawable interfaces
function explosions(parent)
	local ex={}
	ex.circles={}
	
	function ex:explode(x,y)
		add(self.circles,{x=x,y=y,t=0,s=2})
	end
	
	function ex:multiexplode(x,y)
		local time=0
		add(self.circles,{c=6, seg=19, x=x	,y=y	,t=time,s=love.math.random(2)+1}) 	time=time-2
		add(self.circles,{c=7, seg=8 , x=x+7,y=y-3	,t=time,s=love.math.random(2)+1}) 	time=time-2
		add(self.circles,{c=6, seg=5 , x=x-7,y=y+3	,t=time,s=love.math.random(2)+1}) 	time=time-2
		add(self.circles,{c=8, seg=6 , x=x	,y=y	,t=time,s=love.math.random(2)+1}) 	time=time-2
		add(self.circles,{c=6, seg=7 , x=x+7,y=y+3	,t=time,s=love.math.random(2)+1}) 	time=time-2
		add(self.circles,{c=7, seg=9 , x=x-7,y=y-3	,t=time,s=love.math.random(2)+1}) 	time=time-2
		add(self.circles,{c=6, seg=12, x=x	,y=y	,t=time,s=love.math.random(2)+1}) 	time=time-2
	end
	
	-- call on update() (clears & updates circles)
	function ex:update()
		local toDelete = {}
		for eidx = 1, #self.circles do
			local e = self.circles[eidx]

			if e ~= nil then
				e.t= e.t+(e.s/2.1)
				if e.t >= 30 then
					add(toDelete, e)
				end
			end
		end

		for idx=1, #toDelete do
			local eidx = toDelete[idx]
			del(self.circles, eidx)
		end
	end
	
	-- call on _draw()
	function ex:draw()
		for eidx = 1, #self.circles do
			local e = self.circles[eidx]
			love.graphics.setColor(sff.palette[e.c])
			love.graphics.circle("line", e.x, e.y, e.t/2, e.seg)
		end
	end

	function ex:destroy()
		del(parent, ex)
	end

	add(parent, ex)
	return ex
end