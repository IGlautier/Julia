function partial(k)
	1 / (16^k) * ((4 / (8*k + 1)) - (2 / (8*k + 4)) - (1 / (8*k + 5)) - (1 / (8*k + 6)))
end

function iterPi(n)
	sum = 0
	for x in 0:n
		sum += partial(x)
	end
	return sum
end