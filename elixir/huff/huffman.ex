defmodule Huffman do

	def sample do
		'the quick brown fox jumps over the lazy dog
		this is a sample text that we will use when we build
		up a table we will only handle lower case letters and
		no punctuation symbols the frequency will of course not
		represent english but it is probably not that far off'
	end
	
	def text() do
		'this is something that we should encode'
	end
	
	def test do
		sample = sample()
		tree = tree(sample)
		#encode = encode_table(tree)
		#decode = decode_table(tree)
		#text = text()
		#seq = encode(text, encode)
		#decode(seq, decode)
	end
	
	def tree(sample) do
		freq = freq(sample)
		huffman(freq)
	end
	
	def freq(sample) do
		freq(sample, [])
	end
	def freq([], freq) do
		freq
	end
	def freq([char | rest], freq) do
		freq(rest, update(char,freq))
	end
	
	def update(char,[]) do
		{char,1}
	end
	def update(char,[{char,n}|freq]) do
		[{char,n+1}|freq]
	end
	def update(char,[elem|freq]) do
		[elem|update(char,freq)]
	end
	
	def huffman(freq) do
		sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
		huffman_tree(sorted)
	end
	
	def huffman_tree([{tree, _}]), do: tree
	def huffman_tree([{a, af}, {b, bf} | rest]) do
		huffman_tree(insert({{a, b}, af + bf}, rest))
	end
	
	def insert({a, af}, []), do: [{a, af}]
	def insert({a, af}, [{b, bf} | rest]) when af < bf do
		[{a, af}, {b, bf} | rest]
	end
	def insert({a, af}, [{b, bf} | rest]) do
		[{b, bf} | insert({a, af}, rest)]
	end
	
	
	
end