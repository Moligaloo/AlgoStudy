#!/usr/bin/env io

MaxHeap := Object clone do(
	data ::= list()

	with := method(
		from_list, 
		self clone setData(from_list itemCopy) do(
			for(i, size >> 1, 0, -1, 
				down_heapify(i)
			)
		)
	)

	top := method(data first)
	exchange := method(i, j, do(data swapIndices(i, j)))
	size := method(data size)
	isEmpty := method(data isEmpty)

	down_heapify := method(i, 
		max_index := list(i*2+1, i*2+2) select(< size) reduce(a, b, if(data at(a) > data at(b), a, b), i)

		do(if(max_index != i, exchange(max_index, i) down_heapify(max_index)))
	)

	up_heapify := method(i,
		do(
			if(i > 0,
				p := (i-1) >> 1
				if(data at(p) < data at(i),
					exchange(p, i) up_heapify(p))
				)
		)
	)

	pop := method(
		top ifNonNil(exchange(0, size-1) do(data removeLast) down_heapify(0))
	)

	push := method(x, 
		do(data push (x); up_heapify(size-1))
	)
)

isLaunchScript ifTrue(
	MaxHeap with(list(3, 1, 4, 1, 5, 9)) do(
		push(6)
		data println
	)
)





