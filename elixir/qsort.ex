defmodule Qsort do
	def qsort([]) do [] end
	
	def qsort([p | l]) do
		{l1, l2} = qsplit(p, l, [], [])
		small = qsort(l1)
		large = qsort(l2)
		append(small, [p | large])
	end
	
	def qsplit(_, [], small, large) do {small,large} end
	
	def qsplit(p, [h | t], small, large) do
		if h<p do
			qsplit(p,t,[h|small],large)
		else
			qsplit(p,t,small,[h|large])
		end
	end
	
	def append(l1, l2) do
		case l1 do
		[] -> l2
		[h | t] -> [h|append(t,l2)]
		end
	end
end