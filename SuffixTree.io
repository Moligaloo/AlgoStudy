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

	// https://en.wikipedia.org/wiki/Longest_repeated_substring_problem
	longestRepeatedSubstring := method(
		longest := ""

		prefixTree dfs(searchNode, 
			if(searchNode edge == "$",
				edges := list()
				node := searchNode parent
				while(node edge,
					edges push(node edge)
					node = node parent
				)

				string := edges reverse join
				if(longest size < string size, 
					longest = string
				)
			)
		)

		longest
	)
)

isLaunchScript ifTrue(
	tree := SuffixTree with("ATCGATCGA$")
	tree prefixTree asMap asJson println

	tree longestRepeatedSubstring println
)

