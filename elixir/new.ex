defmodule New do
	
	def eval_expr({:atm, id}, _) do {:ok, id} end
	
	def eval_expr({:var, id}, env) do
		case Env.lookup(id,env) do
			nil ->
			:error
			{_, str} ->
			{:ok, str}
		end
	end
	
	def eval_expr({:cons, head, tail}, env) do
		case eval_expr(head, env) do
			:error ->
				:error
			{:ok, hs} ->
				case eval_expr(tail, env) do
				:error ->
					:error
				{:ok, ts} ->
					{:ok,[hs|ts]}
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
		case Env.lookup(id,env) do
		nil ->
			{:ok, Env.add(id,str,env)}
		#this ^str, should be the same str as above. not a new str
		{_, ^str} ->
			{:ok, env}
		{_, _} ->
			:fail
		end
	end
	
	def eval_match({:cons, hp, tp}, [hs|ts], env) do
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
	def extract_vars({:ignore,vars},vars) do vars	end
	def extract_vars({:var,var},vars) do [var|vars] end
	def extract_vars({:cons,head,tail},vars) do extract_vars(tail,extract_vars(head,vars)) end
	
	#def eval([exp]) do eval_seq([exp], []) end
	def eval_seq([exp], env) do	
		eval_expr(exp, env)
	end
	def eval_seq([{:match, pat, exp} | seq], env) do
		case eval_expr(exp, env) do
			:error ->
				:error
			{:ok, str} ->
				vars = extract_vars(pat)
				env = Env.remove(vars,env)
			case eval_match(pat, str, env) do
				:fail ->
					:error
				{:ok, env} ->
					eval_seq(seq, env)
			end
		end
	end
	


	
	


end