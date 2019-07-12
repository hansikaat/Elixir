defmodule Brot do

	def mandelbrot(c, m) do
	  z0 = Cmplx.new(0, 0)
	  i = 0
	  test(i, z0, c, m)
	end
	
	#def test(m, z0, c, m) do z0 end
	def test(i, z0, c, m) do
		if Cmplx.abs(z0)>2.0 do
			i
		else
			s=Cmplx.add(Cmplx.sqr(z0),c)
			test(i+1, s, c, m)
		end	
	end

end