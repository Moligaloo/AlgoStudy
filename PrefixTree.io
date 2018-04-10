#!/usr/bin/env io

// https://en.wikipedia.org/wiki/Trie

PrefixTree := Object clone do(
	key ::= nil
	subtrees ::= nil

	init := method(
		setKey(nil) setSubtrees(Map clone)
	)

	insert := method(k,
		do(k asList reduce(tree, char, tree subtrees atIfAbsentPut(char, PrefixTree clone), self) setKey(k))
	)

	subTreeWithPrefix := method(prefix,
		prefix asList reduce(tree, char, tree subtrees at(char) ifNil(break(nil)), self)
	)

	foreach := method(
		key ifNonNil(
			context := Object clone appendProto(call sender)
			context setSlot(call argAt(0) name, key)
			context doMessage(call argAt(1))
		)

		subtrees foreach(subtree, 
			call delegateTo(subtree)
		)
	)
)

isLaunchScript ifTrue(
	tree := PrefixTree clone
	tree insert("to") insert("today") insert("good")
	tree subTreeWithPrefix("t") foreach(x, x println)
)

