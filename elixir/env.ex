defmodule Env do	
  
	def new do [] end

	def add(id, str, env) do 
		[{ id, str} | env ] 
	end
	
	def lookup(id,[]) do nil end	
	def lookup(id, [{id,str}|rest]) do {id,str} end	
	def lookup(id, [head|tail]) do lookup(id, tail) end	
	
	def remove(ids, []) do [] end	
	def remove([], rest) do rest end					
	def remove([ids|tail], [{ids,str}|rest]) do remove(tail,rest) end	
	def remove([ids|tail], [head|rest]) do [head | remove([ids|tail],rest)] end	
	
	
	
	#{:cons,{:atom, a},{:cons{{:var, x},{:atom, b}}}}
end