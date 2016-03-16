function fft(x)
	N = length(x)
	if N % 2 > 0
		println("Input length must be a power of 2")
	elseif N < 32
		fourier(x)
	else 
		xEven = Array{Float64}(N/2)
		xOdd = Array{Float64}(N/2)
		for i=1:2:N
			xOdd
		
		fft(x[0::2])
		
end