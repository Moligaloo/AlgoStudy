#!/usr/bin/env io

// https://en.wikipedia.org/wiki/Suffix_tree

Object asListFromMessage := method(
	resultList := list()

	msg := call argAt(0)
	msg appendArg(message(e))
	msg appendArg(message(resultList push(e)))
	doMessage(msg)

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
	longestRepeatedSubstring := method(
		prefixTree asListFromMessage(dfs) select(edge == "$") map(
			asListFromMessage(foreachParent) select(edge) map(edge) reverse join
		) reduce(a, b, if(a size > b size, a, b))
	)
)

isLaunchScript ifTrue(
	tree := SuffixTree with("ATCGATCGA$")
	tree prefixTree asMap asJson println

	tree longestRepeatedSubstring println
)

