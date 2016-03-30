function matFourier(x)
	N = length(x)
	x = reshape(x, 1, 10000)

	M = Array{Float64}(N, N)
	M = complex(M)
	w = e^(2*pi*im/N)
	f = 1/sqrt(N)
	for i=1:N
		for j=1:N
			M[i, j] = f*w^(j*i)			
		end
	end
	X = x * M
	X = reshape(X, 10000, 1)
	for i=1:N
		X[i] = sqrt(X[i].re^2 + X[i].im^2)
	end
	return X
end