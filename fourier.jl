function fourier(x)
	N = length(x)
	X = Array{Float64}(N)
	X = complex(X)
	M = Array{Float64}(N, N)
	
	#=for k=1:N
		X[k] = 0
		X[k] = @parallel (+) for n=1:N
			#X[k] += x[n] * e^(-2*pi*k*n/N*im)	
			x[n] * e^(-2*pi*k*n/N*im)
		end
	end=#
	
	for k=1:N
		X[k] = 0
		for n=1:N
			X[k] += x[n] * e^(-2*pi*k*n/N*im)	
		end
	end
	for i=1:N
		X[i] = sqrt(X[i].re^2 + X[i].im^2)
	end
	
	return X
end