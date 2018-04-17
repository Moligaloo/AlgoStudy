#!/usr/bin/env io

// https://en.wikipedia.org/wiki/Suffix_tree

Object asListFromMessage := method(
	resultList := list()

	doMessage(
		call argAt(0) appendArg(message(e)) appendArg(message(resultList push(e)))
	)

	resultList
)

SuffixTree := Object clone do(
	prefixTree ::= nil

	// time and space complexity is O(n) where n is the length of string
	with := method(string,
		self clone setPrefixTree(
			Range 0 to(string size-1) map(i, string exSlice(i)) prepend(CompactPrefixTree clone) reduce(insert)
		)
	)

	// https://en.wikipedia.org/wiki/Longest_repeated_substring_problem
	longestRepeatedSubstring := method(string,
		self with(string .. "$") prefixTree asListFromMessage(dfs) map(
			asListFromMessage(foreachParent) select(edge) map(edge) reverse join
		) reduce(a, b, if(a size > b size, a, b))
	)
)

isLaunchScript ifTrue(
	tree := SuffixTree with("banana$")
	tree prefixTree asMap asJson println

	SuffixTree longestRepeatedSubstring("ATCGATCGA") println
)

