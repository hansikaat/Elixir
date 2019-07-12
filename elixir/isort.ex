defmodule Isort do

	def isort(l) do
		isort(l, [])
	end
	
	def isort(l, sorted) do
		case l do
			[] ->
			sorted
			[h | t] ->
			isort(t, insert(h,sorted))
		end
	end
	
	def insert(x,[head|tail]) when x>head do
		[head | insert(x,tail)]
	end
	def insert(x,larger) do
		[x | larger]
	end
	
end
