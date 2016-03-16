function piPl(n)
	
	sum = @parallel (+) for x=0:n
		partial(x)
	end
	
end