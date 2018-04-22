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
			call sender setSlot(call argAt(0) name, key)
			call sender doMessage(call argAt(1))
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

	asJsonValue := method(
		if(left == null and right == null, 
			key,
			list(
				list("key", key ifNonNilEval(key asString)),
				list("left", left ifNonNilEval(left asJsonValue)),
				list("right", right ifNonNilEval(right asJsonValue))
			) select(second) asMap
		)
	)

	remove := method(k,
		if(key == k,
			removeRoot,
			if(k < key, left = left remove(k))
			if(k > key, right = right remove(k))
			self
		)
	)

	removeRoot := method(
		if(left == null, return right)
		if(right == null, return left)

		key = left key
		left = left removeRoot
		self
	)

	null := clone do(
		insert = method(k, BinarySearchTree withLeaf(k))
		lookup = method(nil)		
		min = method(nil)
		max = method(nil)
		foreach = method(self)
		remove = method(self)
		removeRoot = method(self)
	)
)

isLaunchScript ifTrue(
	BinarySearchTree withList(list(4, 3, 1, 2, 8, 7, 16, 10, 9, 14)) do(
		"max = #{max}, min = #{min}" interpolate println
		lookup(1) println
		lookup(100) println

		foreach(x, "(#{x})" interpolate println)
		asJsonValue asJson println
	)
)





