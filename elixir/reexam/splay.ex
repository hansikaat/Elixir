defmodule Splay do
	def update(nil, key, value) do
		{:node, key, value, nil, nil}
	end
	
	def update({:node, key, _, a, b}, key, value) do
		{:node, key, value, a, b}
	end
	
	def update({:node, rk, rv, zig, c}, key, value) when key<rk do
		{:splay, _, a, b} = splay(zig, key)
		{:node, key, value, a, {:node, rk, rv, b, c}}
	end
	
	def update({:node, rk, rv, a ,zag}, key, value) when key>=rk do
		{:splay, _, b, c} = splay(zag, key)
		{:node, key, value, {:node, rk, rv, a, b}, c}
	end
	
	defp splay(nil, _) do
		{:splay, :na, nil, nil}
	end
	
	defp splay({:node, key, value, a, b}, key) do
		{:splay, value, a, b}
	end
	
	defp splay({:node, rk, rv, nil, b}, key) when key<rk do
		{:splay, :na, nil, {:node, rk, rv, nil, b}}
	end
	
	defp splay({:node, rk, rv, a, nil}, key) when key>=rk do
		{:splay, :na, {:node, rk, rv, a, nil}, nil}
	end
	
end