defmodule Heap do

@spec new() :: heap()
@type heap() :: nil | {:heap, integer(), heap(), heap()}
@spec add(heap(), integer()) :: heap()
@spec pop(heap()) :fail | {:ok, integer(), heap()}
@spec swap(heap(), integer()) {:ok, integer(), heap()}

	def new() do
		nil
	end
	
	def add(nil, v) do
		{:heap, v, nil, nil}
	end
	def add({:heap, k, left, right}, v) when k > v do
		{:heap, k, add(right, v), left}
	end
	def add({:heap, k, left, right}, v) do
		{:heap, v, add(right, k), left}
	end
	
	def pop(nil) do :fail end
	def pop({:heap, k, left, nil}) do
		{:ok, k, left}
	end
	def pop({:heap, k, nil, right}) do
		{:ok, k, right}
	end
	def pop({:heap, k, left, right}) do
		{:heap, l, _, _} = left
		{:heap, r, _, _} = right
		if l < r do
			{:ok, _, rest} = pop(right)
			{:ok, k, {:heap, r, left, rest}}
		else
			{:ok, _, rest} = pop(left)
			{:ok, k, {:heap, l, rest, right}}
		end
	end
	
	def swap(nil, v) do
		{:ok, v, nil}
	end
	
	def qsort([]) do [] end
	def qsort([p|l]) do
		{l1,l2}=qsplit(p,l,[],[])
		small=qsort(l1)
		large=qsort(l2)
		append(small,[p|large])
	end
	
	qsplit(_,[],l1,l2) do
		{l1,l2}
	end	
	qsplit(p,[h|t],small,large) do
		if h<p do 
			qsplit(p,t,[h|small],large)
		else
			qsplit(p,t,small,[h|large])
		end
	end
	
	append(small,large) do
		case small do
			[] -> large
			[h|t] -> [h|append(t,large)]
		end		
	end
	
end