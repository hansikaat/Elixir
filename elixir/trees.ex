defmodule Trees do
	
	def member(_,:nil) do :no end
	def member(n,{:leaf,n}) do :yes end
	def member(n,{:leaf,x}) do :no end
	def member(n,{:node,n,_,_}) do :yes end
	def member(n,{:node,v,left, right}) do 
		if n<v do 
			member(n, left) 
		else
			member(n, right)				
		end
	end


	def lookup(key, :nil) do :no end
	def lookup(key, {:node, key, value, _, _}) do {:value,value} end
		def lookup(key, {:node, k, _, left, right}) do
		if key < k do
		lookup(key,left)
		else
		lookup(key,right)
		end
	end
	
	def modify(_, _, :nil) do :nil end
	def modify(key, val, {:node, key, _, left, right}) do
		{:node, key, val, left, right}
	end
	def modify(key, val, {:node, k, v, left, right}) do
		if key < k do
		{:node, k, v, key, val, right};
		else
		{:node, k, v, left, key, val}
		end
	end
	
		
	def insert(key, value, :nil) do {key,value} end
	def insert(key, value, {:node, k, v, left, right}) do
		if key < k do
		{:node,k,v,insert(key, value, left),right}
		else
		{:node,k,v,left,insert(key, value, right)}
		end
	end	
	
	def delete(key, {:node, key, _, :nil, :nil}) do ... end
	def delete(key, {:node, key, _, :nil, right}) do ... end
	def delete(key, {:node, key, _, left, :nil}) do ... end
	def delete(key, {:node, key, _, left, right}) do
		?
	end
	def delete(key, value, {:node, k, v, left, right}) do
		if key < k do
		...
		else
		...
		end
	end
	
end