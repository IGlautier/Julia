function prefixSerial(n)
	input = Array{Int64}(n)
	for i=1:n
		input[i] = rand(0:9)
		println(input[i])
	end
	
	output = Array{Int64}(n)
	output[1] = input[1]
	println(output[1])
	for i=2:n
		output[i] = input[i] + output[i-1]
		println(output[i])
	end
	
	
end
	
	