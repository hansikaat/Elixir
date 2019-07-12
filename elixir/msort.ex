defmodule Msort do
	def msort(l) do
		case l do
		[] ->
			[]
		l ->
			{l1, l2} = msplit(l, [], [])
			merge(msort(l1), msort(l2))
		end
	end
	
	def merge(l1, []) do l1 end
	def merge([], l2) do l2 end
	def merge([h1|t1], [h2|t2]) do
		if h1<h2 do
			merge(t1,[h2|t2])
		else
			merge([h1|t1], t2)
		end
	end
	
	def msplit(l, l1, l2) do
		case l do
			[] ->
			{l1, l2}
		[h|t] ->
			msplit(t, [h|l2], l1)
		end
	end
end