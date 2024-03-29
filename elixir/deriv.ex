defmodule Deriv do

@type literal() :: {:const, number()}
| {:const, atom()}
| {:var, atom()}

@type expr() :: {:add, expr(), expr()}
| {:mul, expr(), expr()}
| literal()

@type constant() :: {:const, number()} | {:const, atom()}

def deriv({:const, _}, _), do: {:const, 0}
def deriv({:var, v}, v), do: {:const, 1}
def deriv({:var, y}, _), do: {:const, 0}
def deriv({:mul, e1, e2}, v), do: {:add,{:mul,deriv(e1,v),e2},{:mul,e1,deriv(e2,v)}} 
def deriv({:add, e1, e2}, v), do: {:add,deriv(e1,v),deriv(e2,v)} 
def deriv({:exp, {:var, v}, {:const, c}}, v) do
    {:mul, {:const, c}, {:exp, {:var, v}, {:const, c - 1}}}
  end

end