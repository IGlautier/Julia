function prefixParallel(n)

	if (n >= nprocs())
		println("You need more processors!")
		return
	end
	R = floor(log2(n))
	
	@everywhere rank = myid() - 1
	input = Array(Int, n)
	localVals = Array{RemoteRef}(n)
	println("Inputs")
	for i=1:n
		input[i] = rand(0:9)
		localVals[i] = @spawnat i+1 fetch(input[i])
		println(input[i])
	end
	
	for r=0:R-1
		check = 2^r+1
		hop = 2^r
		@printf("Iteration %d \n", r)
		for i=0:n-1
			println(i)
			if (rem(i, 2^(r+1) ) == 0)
				@printf("%d + %d \n", i+1, i+1-hop)
				localVals[i+1] = @spawnat i+2 fetch(localVals[i+1]) + fetch(localVals[i + 1 - hop])
			end
		end
	end
	
	
	println("Outputs")
#=	for t=1:n
		println(fetch(localVals[1]))
	end=#
	

	
end
	
