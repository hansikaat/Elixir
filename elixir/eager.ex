defmodule Eager do
	
	def eval_expr({:atm, id}, ) do id end
	
	def eval_expr({:var, id}, env) do
		case Env.lookup(id,env) do
			nil ->
			:error
			{_, str} ->
			{:ok, str}
		end
	end
	
	def eval_expr({:cons, {:var, id}, {:atm, id}}, env) do
		case eval_expr({:var, id}, env) do
			:error ->
				:error
			{:ok, hs} ->
				case eval_expr({:atm, id}, env) do
				:error ->
					:error
				{:ok, ts} ->
					{:ok, [hs|ts]}
				end
		end
	end
	
	def eval_match(:ignore, _, env) do
		{:ok, env}
	end
	
	def eval_match({:atm, id}, id, env) do
		{:ok, env}
	end

	def eval_match({:var, id}, str, env) do
		case env do
		[] ->
			{:ok, [{id,str}]}
		{_, ^str} ->
			{:ok, [{id,str}]}
		{_, _} ->
			:fail
		end
	end
	
	def eval_match({:cons, hp, tp}, {:cons, hs, ts}, env) do
		case eval_match(hp, hs, env) do
		:fail ->
			:fail
		{:ok, env} ->
		eval_match(tp, ts, env)
		end
	end
	
	def eval_match(_, _, _) do
		:fail
	end
	
	def extract_vars(exp) do extract_vars(exp,[]) end	
	def extract_vars({:atm,_},vars) do vars	end
	def extract_vars({:var,var},vars) do [var|vars] end
	def extract_vars({:cons,head,tail},vars) do extract_vars(tail,extract_vars(head,vars)) end
	
	def eval([exp]) do eval_seq([exp], []) end
	def eval_seq([exp], env) do	
		eval_expr([exp], env)
	end
	def eval_seq([{:match, exps, expss} | expsss], env) do
		case eval_expr(exps, env) do
			:error ->
				:fail
			{:ok, env} ->
				vars = extract_vars(exps)
				env = Env.remove(vars,env)
			case eval_match(exps, expss, env) do
				:fail ->
					eval_seq(expsss, env)
				{:ok, env} ->
					eval_seq(expss, env)
			end
		end
	end


end