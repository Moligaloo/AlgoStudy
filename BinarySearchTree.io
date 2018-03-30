#!/usr/bin/env io

BinarySearchTree := Object clone do(
	key ::= nil
	left ::= nil // the smaller subtree
	right ::= nil // the bigger subtree

	createLeaf := method(k, 
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

	PREORDER := 0
	INORDER := 1
	POSTORDER := 2

	traverse := method(callback, order,
		order ifNilEval(INORDER) switch(
			PREORDER, callback call(key); left traverse(callback, PREORDER); right traverse(callback, PREORDER),
			INORDER, left traverse(callback, INORDER); callback call(key); right traverse(callback, INORDER),
			POSTORDER, left traverse(callback, POSTORDER); right traverse(callback, POSTORDER); callback call(key)
		)
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
		insert = method(k, BinarySearchTree createLeaf(k))
		traverse = method(order, callback, self)
		lookup = method(nil)		
		min = method(nil)
		max = method(nil)
	)
)

isLaunchScript ifTrue(
	s := list(4, 3, 1, 2, 8, 7, 16, 10, 9, 14)

	tree := BinarySearchTree withList(s)
	tree min println
	tree max println
	tree lookup(1) println
	tree lookup(100) println
	tree traverse(block(e, e println))
)





