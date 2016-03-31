function fftP(x)
	N = length(x)
	M = Int64(N / 2)
	if mod(N,2) > 0
		println("Input length must be a power of 2")
	elseif N < 16
		fourier(x)
	else 
		#Scatter
		xEven = Array{Float64}(M)
		xOdd = Array{Float64}(M)
		j = 1
		for i=1:2:N
			xOdd[j] = x[i+1]
			xEven[j] = x[i]
			j += 1
		end
		
		#=fOdd = Array{Float64}(M)
		fOdd = complex(fOdd)
		fEven = Array{Float64}(M)
		fEven = complex(fEven)=#
		
		fOdd = @spawn fftP(xOdd)
		fEven = @spawn fftP(xEven)
		
		# Gather
		fO = fetch(fOdd)
		fE = fetch(fEven)
		
		X = Array{Float64}(N)
		X = complex(X)
		for k=1:M
			X[k] = fE[k] + e^(-2*pi*k*im/N) * fO[k]
		end
		for k=M+1:N
			X[k] = fE[k - M] + e^(-2*pi*k*im/N) * fO[k - M]
		end
		return X
	end 
end