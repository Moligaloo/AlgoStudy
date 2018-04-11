#!/usr/bin/env io

// https://en.wikipedia.org/wiki/Trie

// "prefix tree" is also known as "trie"

PrefixTree := Object clone do(
	subtrees ::= nil

	init := method(
		setSubtrees(Map clone)
	)

	insert := method(k,
		(k asList reduce(tree, char, tree subtrees atIfAbsentPut(char, PrefixTree clone), self)) subtrees atPut("", k)
		self
	)

	subTreeWithPrefix := method(prefix,
		prefix asList reduce(tree, char, tree subtrees at(char) ifNil(break(nil)), self)
	)

	asMap := method(
		map := Map clone
		subtrees foreach(key, subtree,
			map atPut(key, if(subtree hasProto(Sequence), subtree, subtree asMap))
		)
		map
	)

	foreach := method(
		subtrees foreach(subtree, 
			if(subtree hasProto(PrefixTree), 
				// call recursively
				call delegateTo(subtree), 
				// leaf node
				context := Object clone appendProto(call sender)
				context setSlot(call argAt(0) name, subtree)
				context doMessage(call argAt(1))
			)
		)
	)
)

isLaunchScript ifTrue(
	tree := list("to", "today", "good") reduce(tree, word, tree insert(word), PrefixTree clone)
	tree asMap asJson println
	tree subTreeWithPrefix("to") foreach(x, x println)
)

