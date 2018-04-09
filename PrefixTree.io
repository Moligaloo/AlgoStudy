#!/usr/bin/env io

PrefixTree := Object clone do(
	key ::= nil
	subtrees ::= nil

	init := method(
		setKey(nil) setSubtrees(Map clone)
	)

	insert := method(k,
		do(k asList reduce(tree, char, tree subtrees atIfAbsentPut(char, PrefixTree clone), self) setKey(k))
	)
)

isLaunchScript ifTrue(
	tree := PrefixTree clone
	tree insert("to") insert("today") insert("good")
)

