defmodule Philosopher do
	
	def start(hunger, l, r, names, ctrl) do
		spawn_link(fn -> init(hunger, l, r, names, ctrl) end)
	end
	
	def init(hunger, l, r, names, ctrl) do
		dreaming(hunger,l,r,names,ctrl)
	end
	
	def dreaming(0,l,r,names,ctrl) do	
		IO.puts("#{names} finished eating!")
		send(ctrl, :done)		
	end	
	
	def dreaming(hunger,l,r,names,ctrl) do
		sleep(1000)
		waiting(hunger,l,r,names,ctrl)		
	end	
	
	def waiting(hunger,l,r,names,ctrl) do		
		send(l,left(hunger,l,r,names,ctrl))		
	end	
	
	def left(hunger,l,r,names,ctrl) do		
		sleep(200)
		send(r, right(hunger,l,r,names,ctrl))		
	end
	
	def right(hunger,l,r,names,ctrl) do
		IO.puts("#{names} received chopsticks!")		
		eating(hunger,l,r,names,ctrl)
	end	
	
	def eating(hunger,l,r,names,ctrl) do
		IO.puts("#{names} is eating..")
		sleep(200)
		send(l,returnleft(hunger,l,r,names,ctrl))
	end
	
	def returnleft(hunger,l,r,names,ctrl) do		
		sleep(50)
		send(r, returnright(hunger,l,r,names,ctrl))		
	end
	
	def returnright(hunger,l,r,names,ctrl) do	
		IO.puts("#{names} returned chopsticks!")
		sleep(200)
		dreaming(hunger - 1,l,r,names,ctrl)		
	end
	
	def sleep(0) do :ok end
		def sleep(t) do
			:timer.sleep(:rand.uniform(t))
	end	
	
end