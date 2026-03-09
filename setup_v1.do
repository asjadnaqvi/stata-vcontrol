
clear

cap cd "D:\Dropbox\STATA - VCONTROL"

// SSC
quietly {
	import delimited using "http://fmwww.bc.edu/repec/bocode/t/tidytuesday.pkg", clear case(lower) delim("***")
	keep if regexm(v1, "d Distribution-Date:")
	replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
	destring v1, replace
	local sscdate = v1[1]
}
di "`sscdate'"



// GitHub
quietly {
	import delim "https://raw.githubusercontent.com/asjadnaqvi/stata-tidytuesday/refs/heads/main/installation/tidytuesday.pkg", clear case(lower) delim("***")
	keep if regexm(v1, "d Distribution-Date:")
	replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
	destring v1, replace
	local githubdate = v1[1]
}
di "`githubdate'"


if `githubdate' > `sscdate' {
	di in green "GitHub"
}