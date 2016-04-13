using MPI

MPI.Init()

comm = MPI.COMM_WORLD

rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)

inputs = Array{Int64}(size)
outputs = Array{Int64}(size)

#Generate inputs
if (rank == 0)
	println("Selected $size integers with $size processes - to change this number rerun the programme with a different number of processes \n")
	println("Input sequence is: \n")
	
	inputs = rand(1:9, size)

	println("$inputs \n")

end

maxCalcs = log2(size)
rxVal = zeros(Int, 1)

#Send to processes
localVal = MPI.Scatter(inputs, 1, 0, comm)

#Up phase
for i=0:1:maxCalcs
	txCheck = 2^(i+1)
	txOffst = 2^i
	
	if (((rank + txOffst + 1) % txCheck) == 0) && ((rank + txOffst) < size) 
		MPI.Send(localVal, Int(rank + txOffst), Int(i), comm)
		
	elseif (((rank + 1) % txCheck) == 0) 
		MPI.Recv!(rxVal, 1, Int(rank - txOffst), Int(i), comm)	
		localVal += rxVal
		
	end
end

#Down phase
for i=floor(maxCalcs):-1:1
	txCheck = 2^i
	txOffst = 2^(i-1)
	
	if (((rank + 1) % txCheck) == 0) && ((rank + txOffst) < size)
		MPI.Send(localVal, Int(rank + txOffst), Int(i), comm)
		
	elseif ((rank + 1 - txOffst) % txCheck == 0) && ((rank - txOffst) > -1)
		MPI.Recv!(rxVal, 1, Int(rank - txOffst), Int(i), comm)
		localVal += rxVal
		
	end
end

#Gather
outputs = MPI.Gather(localVal, 0, comm)

if (rank == 0)
	println("Output sequence is: \n")
	println("$outputs")
end


MPI.Finalize()
