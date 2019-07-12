defmodule Intro do

	def nth(n,[]) do [] end
	def nth(1,[h|t]) do h end
	def nth(n,[h|t]) do
		nth(n-1,t)
	end
	
	def len([]) do 0 end	
	def len([h|t]) do
		len(t)+1
	end
	
	def sum([]) do 0 end	
	def sum([h|t]) do
		sum(t)+h
	end
	
	def duplicate([]) do [] end	
	def duplicate([h|t]) do
		[h,h|duplicate(t)]
	end
	
	def add(x,[]) do [x] end	
	def add(h,[h|t]) do
		[h|t]
	end
	def add(x,[h|t]) do
		[x,h|t]
	end
	
	def remove(x,[]) do [] end
	def remove(h,[h|t]) do remove(h,t) end
	def remove(x,[h|t]) do 
		[h|remove(x,t)] 
	end
	
	def unique([]) do [] end	
	def unique([x|t]) do [x|unique(remove(x,t))] end
	
	def pack([]) do [] end
	def pack([x|tail]) do 
		{all,rest}=match(x,tail,[x],[])
		[all|pack(rest)]
	end
	
	def match(_,[],all,rest) do
		{all,rest}
	end
	def match(x,[x|tail],all,rest) do
		match(x,tail,[x|all],rest)
	end
	def match(x,[y|tail],all,rest) do
		match(x,tail,all,[y|rest])
	end
	
	def reverse(l) do reverse(l,[]) end
	def reverse([],rev) do rev end
	def reverse([h|t],rev) do
		reverse(t,[h|rev])
	end
	
	def isort(l) do isort(l,[]) end
	def isort([],sorted) do
		sorted
	end
	def isort([h|t],sorted) do
		isort(t,insert(h,sorted))
	end
	
	def insert(e,[]) do [e] end
	def insert(e,[h|t]) do 
		if e<h do
			[e,h|t]
		else
			[h|insert(e,t)]
		end
	end
	
	def msort([]) do []	end
	def msort([x]) do [x] end
	def msort(l) do 
		{x,y}=msplit(l,[],[])
		merge(msort(x),msort(y))
	end
	
	def merge(x,[]) do x end
	def merge([],y) do y end
	def merge([h|t],[x|y]) do 
		if h<x do
			[h|merge(t,[x|y])]
		else
			[x|merge([h|t],y)]
		end
	end
	
	def msplit([h|t],x,y) do
		msplit(t,[h|y],x)
	end
	def msplit([],x,y) do
		{x,y}
	end
	
end