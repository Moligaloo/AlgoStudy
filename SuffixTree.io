#!/usr/bin/env io

// https://en.wikipedia.org/wiki/Suffix_tree

SuffixTree := Object clone do(
	prefixTree ::= nil

	// time and space complexity is O(n) where n is the length of string
	with := method(string,
		self clone setPrefixTree(
			Range 0 to(string size-1) map(i, string exSlice(i)) prepend(CompactPrefixTree clone) reduce(insert)
		)
	)
)

isLaunchScript ifTrue(
	tree := SuffixTree with("banana")
	tree prefixTree asMap asJson println
)

