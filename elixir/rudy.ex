defmodule Rudy do
	
	def start(port) do
		Process.register(spawn(fn -> init(port) end), :rudy)
	end
	
	def init(port) do
		opt = [:list, active: false, reuseaddr: true]
		
		case :gen_tcp.listen(port, opt) do
			{:ok, listen} ->
				handler(listen)
				:gen_tcp.close(listen)
				:ok
			{:error, error} ->
			error
		end
	end
	
	def handler(listen) do
		case :gen_tcp.accept(listen) do
			{:ok, client} ->
				request(client)
				handler(listen)
			{:error, error} ->
				error
		end
	end
	
	def request(client) do
		recv = :gen_tcp.recv(client, 0)
		case recv do
			{:ok, str} ->
				request=HTTP.parse_request(str)
				#IO.puts("Request is:")
				#IO.inspect(request)
				response=reply(request)
				:gen_tcp.send(client, response)
			{:error, error} ->
				IO.puts("RUDY ERROR: #{error}")
		end
		:gen_tcp.close(client)
	end
	
	def reply({{:get, uri, _}, _, _}) do		
		:timer.sleep(10)
		HTTP.ok("Hello!")
	end
	
	def stop() do
		Process.exit(Process.whereis(:rudy), "Time to die!")
	end
	
	
end
