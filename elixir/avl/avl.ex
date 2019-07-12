defmodule AVL do

	def tree do
		nil
	end
	
	insert(nil,key, value) do
		{:node, key, value, nil, nil}
	end
	
	insert({:node, key, _, a, b},key, value) do
		{:node, key, value, a, b}
	end

	insert({:node, rk, rv, a, b},kk, kv) do
		when kk<rk
		{:node, rk, rv, insert(a,kk,kv), b}
	end
	
	insert({:node, rk, rv, a, b},kk, kv) do
		when kk>rk
		{:node, rk, rv, a, insert(b,kk,kv)}
	end
	
	def depth(nil, _) do 
		:fail 
	end
	
	def depth({:node,k,_, _,_},k) do
		{:ok, 1}
	end
	
	def depth({:node,k,_, l,r},key) do
		cond do
			k>key ->
				case depth(l,key) do
					{:ok, depth} -> {:ok, depth+1}
					:fail -> :fail
				end
			true ->
				case depth(r,key) do
					{:ok, depth} -> {:ok, depth+1}
					:fail -> :fail
				end
		end
	end
	
	def max(nil) do 0 end
	def max({:node,_,_, l,r}) do 
		max(max(l)+max(r))+1
	end
	
	def lookup(nil,_) do :fail end
	def lookup({:node,k,v,_,_},k) do 
		{:ok, v} 
	end
	def lookup({:node,k,_,l,r},key) do 
		cond do 
			key < k -> lookup(l,key)
			true -> lookup(r,key)
		end
	end
	
	
	def insert(tree, key, value) do
		case insrt(tree, key, value) do
			{:inc, q} -> q
			{:ok, q} -> q
		end
	end	
	
	defp insrt(nil, key, value) do
		{:inc, {:node, key, value, 0, nil, nil}}
	end
	
	defp insrt({:node, key, _, f, a, b}, key, value) do
		{:ok, {:node, key, value, f, a, b}}
	end
	
	defp insrt({:node, rk, rv, 0, a, b}, kk, kv) when kk < rk do
		case insrt(a, kk, kv) do
			{:inc, q} ->
				{:inc, {:node, rk, rv, -1, q, b}}
			{:ok, q} ->
				{:ok, {:node, rk, rv, 0, q, b}}
		end
	end
	
	defp insrt({:node, rk, rv, 0, a, b}, kk, kv) when kk > rk do
		case insrt(a, kk, kv) do
			{:inc, q} ->
				{:inc, {:node, rk, rv, +1, q, b}}
			{:ok, q} ->
				{:ok, {:node, rk, rv, 0, q, b}}
		end
	end
	
	defp insrt({:node, rk, rv, +1, a, b}, kk, kv) when kk < rk do
		case insrt(a, kk, kv) do
			{:inc, q} ->
				{:ok, {:node, rk, rv, 0, q, b}}
			{:ok, q} ->
				{:ok, {:node, rk, rv, +1, q, b}}
		end
	end
	
	defp insrt({:node, rk, rv, -1, a, b}, kk, kv) when kk > rk do
		case insrt(a, kk, kv) do
			{:inc, q} ->
				{:ok, {:node, rk, rv, 0, q, b}}
			{:ok, q} ->
				{:ok, {:node, rk, rv, -1, q, b}}
		end
	end
	
	defp insrt({:node, rk, rv, -1, a, b}, kk, kv) when kk < rk do
		case insrt(a, kk, kv) do
			{:inc, q} ->
				{:ok, rotate({:node, rk, rv, -2, q, b})}
			{:ok, q} ->
				{:ok, {:node, rk, rv, -1, q, b}}
		end
	end
	
	defp insrt({:node, rk, rv, +1, a, b}, kk, kv) when kk > rk do
		case insrt(a, kk, kv) do
			{:inc, q} ->
				{:ok, rotate({:node, rk, rv, +2, q, b})}
			{:ok, q} ->
				{:ok, {:node, rk, rv, +1, q, b}}
		end
	end
	
	defp insrt({:node, rk, rv, -1, a, b}, kk, kv) when kk < rk do
		case insrt(a, kk, kv) do
			{:inc, q} ->
				{:ok, rotate({:node, rk, rv, -2, q, b})}
			{:ok, q} ->
				{:ok, {:node, rk, rv, -1, q, b}}
		end
	end
	
	defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a,
		{:node, zk, zv, -1, b, c}}, d}) do
		{:node, zk, zv, 0, {:node, yk, yv, 0, a, b}, {:node, xk, xv, +1, c, d}}
	end
	
	defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a,
		{:node, zk, zv, +1, b, c}}, d}) do
		{:node, zk, zv, 0, {:node, yk, yv, -1, a, b}, {:node, xk, xv, 0, c, d}}
	end
	
	defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a,
		{:node, zk, zv, 0, b, c}}, d}) do
		{:node, zk, zv, 0, {:node, yk, yv, 0, a, b}, {:node, xk, xv, 0, c, d}}
	end
	
	defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, 0, b, c}, d}}) do
		{:node, zk, zv, 0, {:node, xk, xv, 0, a, b}, {:node, yk, yv, 0, c, d}}
	end
	
	defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, +1, b, c}, d}}) do
		{:node, zk, zv, 0, {:node, xk, xv, -1, a, b}, {:node, yk, yv, 0, c, d}}
	end
	
	defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, -1, b, c}, d}}) do
		{:node, zk, zv, 0, {:node, xk, xv, 0, a, b}, {:node, yk, yv, +1, c, d}}
	end

end