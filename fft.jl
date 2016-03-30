function fft(x)
	N = length(x)
	M = Int64(N / 2)
	if mod(N,2) > 0
		println("Input length must be a power of 2")
	elseif N < 32
		fourier(x)
	else 
		xEven = Array{Float64}(M)
		xOdd = Array{Float64}(M)
		j = 1
		for i=1:2:N
			xOdd[j] = x[i+1]
			xEven[j] = x[i]
			j += 1
		end
		
		fOdd = Array{Float64}(M)
		fOdd = complex(fOdd)
		fEven = Array{Float64}(M)
		fEven = complex(fEven)
		fOdd = fft(xOdd)
		fEven = fft(xEven)
		X = Array{Float64}(N)
		X = complex(X)
		for k=1:M
			X[k] = fEven[k] + e^(-2*pi*k*im/N) * fOdd[k]
		end
		for k=M+1:N
			X[k] = fEven[k - M] + e^(-2*pi*k*im/N) * fOdd[k - M]
		end
		return X
	end 
end