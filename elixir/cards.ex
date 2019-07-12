defmodule Cards do

@type suite :: :spade | :heart | :diamond | :club
@type value :: 2..14
@type card :: {:card, suite, value}
@spec sort([card]) :: [card]
@spec split([card],[card],[card]) :: {[card],[card]}
@spec merge([card],[card]) :: [card]

def lt({:card, s, v1},{:card, s, v2}) do v1<v2 end
def lt({:card, :club, _},_) do true end
def lt({:card, :diamond, _},{:card, :heart, _}) do true end
def lt({:card, :diamond, _},{:card, :spade, _}) do true end
def lt({:card, :heart, _},{:card, :spade, _}) do true end
def lt({:card, _, _},{:card, _, _}) do false end

def sort([]) do [] end
def sort([c]) do [c] end
def sort(deck) do
	{d1,d2} = split(deck)
	s1=sort(d1)
	s2=sort(d2)
	merge(s1,s2)
end

def split(deck) do split(deck,[],[]) end
def split([],d1,d2) do {d1,d2} end
def split([c|rest],d1,d2) do
	split(rest, d2, [c|d1])
end

def merge([],s2) do s2 end
def merge(s1,[]) do s1 end
def merge([c1|r1]=s1,[c2|r2]=s2) do 
	case lt(c1,c2) do
		true ->
			[c1|merge(r1,s2)]
		false ->
			[c2|merge(s1,r2)]
	end
end

end