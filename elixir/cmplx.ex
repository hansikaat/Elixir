defmodule Cmplx do

	def new(r,i) do {:cn, r, i} end

	def add({:cn, r1, i1},{:cn, r2, i2}) do {:cn, r1+r2, i1+i2} end

	def sqr({:cn, r, i}) do {:cn, r*r-i*i,2*r*i} end

	def abs({:cn, r, i}) do :math.sqrt(r*r+i*i) end	

end