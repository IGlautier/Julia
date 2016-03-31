function prefixParallel(n)

	@everywhere id = myid()
	input = Array(Int, n)
	
	for i=1:n
		input[i] = rand(0:9)
		println(input[i])
	end
	
	output = Array(Int, n)
	output[1] = input[1]
	refs = Array
	#println(output[1])
	t = 0
	for i=2:2:n
	#	output[i] = input[i] + output[i-1]		
		t = @spawnat i x = input[i-1] + input[i]
	end
	

	
	fetch(t)
	
	
end
	
