function piSimple(n)
	x = 4
	for i=3:2:n
		x = x + ((4/i) * (-1)^(i))
	end
	return x
end