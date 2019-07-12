defmodule TestTree do

	def test do
	TwoThree.insertf(14, :grk, {:two, 7, {:three, 2, 5, {:leaf, 2, :foo},
	{:leaf, 5, :bar}, {:leaf, 7, :zot}}, {:three, 13, 16,
	{:leaf, 13, :foo}, {:leaf, 16, :bar}, {:leaf, 18, :zot}}})
	end
	
end