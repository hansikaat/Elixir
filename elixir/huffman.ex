defmodule Huffman do

	def sample() do
		'the quick brown fox jumps over the lazy dog
		this is a sample text that we will use when we build
		up a table we will only handle lower case letters and
		no punctuation symbols the frequency will of course not
		represent english but it is probably not that far off'
	end
  
	def tree(sample) do
		freq = freq(sample)
		#huffman(freq)		
	end

	def freq(sample) do freq(sample, []) end
	def freq([],freq) do freq end
	def freq([char|rest], freq) do freq(rest, calc(char,freq)) end
	
	def calc(char,[]) do [{char,1}] end
	def calc(char,[{char,n}|rest]) do [{char,n+1}|rest] end
	def calc(char,[other|rest]) do [other|calc(char,rest)] end
	
	def huffman(freq) do sorted=isort(freq) end
	
	def isort(freq) do isort(freq, []) end
	def isort([],sorted) do [sorted] end
	def isort([head|tail],sorted) do isort(tail,insert(head,sorted)) end
	
	def insert(x,[]) do [x] end 
	def insert(x,[head|tail]) when x>head do [head,insert(x,tail)] end 
	def insert(x,larger) do [x | larger] end 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
end