#!/usr/bin/env io

// https://en.wikipedia.org/wiki/Radix_tree
// "compact prefix tree" is also known as "radix tree" or "patricia tree"

Sequence longestCommonPrefix := method(otherString,
	length := for(i, 1, (size min(otherString size)), 
		if(at(i-1) != otherString at(i-1), break(i-1), i)
	)

	if(length != nil and length > 0, exSlice(0, length), nil)
)

CompactPrefixTree := Object clone do(
	leaf ::= nil
	subtrees ::= nil

	init := method(
		setLeaf(nil) setSubtrees(Map clone)
	)

	withLeaf := method(k,
		CompactPrefixTree clone setLeaf(k)
	)

	atPut := method(
		call delegateTo(subtrees)
	)

	insert := method(full_key, edge,
		edge = edge ifNilEval(full_key)
		subtrees foreach(key, subtree,
			prefix := key longestCommonPrefix(edge)
			if(prefix,
				if(prefix == key,
					// case 1. insert recursively
					subtree insert(full_key, edge asMutable removePrefix(prefix)),

					// case 2. find common prefix, split it,
					subtrees removeAt(key)

					new_tree := CompactPrefixTree clone
					new_tree  atPut(key asMutable removePrefix(prefix), subtree)
					new_tree  atPut(edge asMutable removePrefix(prefix), CompactPrefixTree withLeaf(full_key))

					subtrees atPut(prefix, new_tree)
				)

				return self
			)
		)

		// case 3. common prefix is not found, just insert it
		subtrees atPut(edge, CompactPrefixTree withLeaf(full_key))
		return self
	)

	asMap := method(
		map := Map clone

		leaf ifNonNil(map atPut("$", leaf))

		subtrees foreach(key, subtree, 
			map atPut(key, subtree asMap)
		)

		map
	)
)

isLaunchScript ifTrue(
	tree := list("test", "toaster", "toasting", "slow", "slowly") reduce(
		tree, word,
		tree insert(word),
		CompactPrefixTree clone
	)

	tree asMap asJson println
)
