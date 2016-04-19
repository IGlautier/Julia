function fftP(x)
	N = length(x)
	
	
	if N == 1
		#fourier(x)
	#=	X = zeros(N)
		X = complex(X)
		X[1] = x[1] * e^(-2*pi*im)=#
		return x
	else 
		M = Int64(N / 2)
	
		xEven = Array{Float64}(M)
		xOdd = Array{Float64}(M)
		j = 1
		for i=1:2:N
			xOdd[j] = x[i+1]
			xEven[j] = x[i]
			j += 1
		end
		
	
		fOdd = @spawn fftP(xOdd)
		
		fEven = @spawn fftP(xEven)
		
		# Gather
		fO = fetch(fOdd)
		fE = fetch(fEven)

		
		X = zeros(N)
		X = complex(X)
		for k=1:M
			f = e^(-2*pi*k*im/N)
			X[k] = fEven[k] + f * fOdd[k]
			X[k+M] = fEven[k] - f * fOdd[k]			
		end
		for i=1:N
			X[i] = sqrt(X[i].re^2 + X[i].im^2)
		end

		return X
	end 
end
