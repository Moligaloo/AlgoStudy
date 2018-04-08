#!/usr/bin/env io

BinarySearchTree := Object clone do(
	key ::= nil
	left ::= nil // the smaller subtree
	right ::= nil // the bigger subtree

	withLeaf := method(k, 
		self clone setKey(k) setLeft(null) setRight(null)
	)

	withList := method(s,
		s reduce(tree, element, tree insert(element), null)
	)

	insert := method(k, 
		do(
				if(k < key) then(left = left insert(k)) \
			elseif(k > key) then(right = right insert(k))
		)
	)

	foreach := method(
		call delegateTo(left)

		if(call argCount > 1) then(
			itor_name := call argAt(0) name 
			context := Object clone appendProto(call sender)
			context setSlot(itor_name, key)
			context doMessage(call argAt(1))
		) elseif(call argCount == 1) then(
			key doMessage(call argAt(0))
		)

		call delegateTo(right)

		self
	)

	lookup := method(k,
		do(
				if(k < key) then(return left lookup(k)) \
			elseif(k > key) then(return right lookup(k))
		)
	)

	min := method(
		if(left == null, key, left min)
	)

	max := method(
		if(right == null, key, right max)
	)

	null := clone do(
		insert = method(k, BinarySearchTree withLeaf(k))
		lookup = method(nil)		
		min = method(nil)
		max = method(nil)
		foreach = method(self)
	)
)

isLaunchScript ifTrue(
	BinarySearchTree withList(list(4, 3, 1, 2, 8, 7, 16, 10, 9, 14)) do(
		"max = #{max}, min = #{min}" interpolate println
		lookup(1) println
		lookup(100) println

		foreach(x, "(#{x})" interpolate println)
	)
)





