with open('spring.log', 'r') as f:
	prev = None
	for line in f:
		data = line.split(':')[-1]
		p,x,y,t = map(int, data.split(','))
		if prev is not None:
			prev[1] += p
			print ",".join(map(str, prev[1:]))
		prev = [p,x,y,t]