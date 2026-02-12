*! version 1.0.0  12feb2026
program define vcontrol
	version 14.0
	syntax anything [, SSCurl(string) GITurl(string)]
	

	if "`anything'" == "" {
		di as error "A package name is required."
		exit 198
	}

	// Set defaults if not specified
	
	local package `anything'
	
	// Extract first letter of package name for SSC URL
	local firstletter = substr("`package'", 1, 1)
	
	if "`sscurl'" == "" {
		local sscurl "http://fmwww.bc.edu/repec/bocode/`firstletter'/`package'.pkg"
	}
	if "`giturl'" == "" {
		local giturl "https://raw.githubusercontent.com/asjadnaqvi/stata-`package'/refs/heads/main/installation/`package'.pkg"
	}
	
	// Preserve current data
	preserve
	
	// SSC
	*di as txt "Checking SSC version..."
	quietly {
		import delimited using "`sscurl'", clear case(lower) delim("***")
		keep if regexm(v1, "d Distribution-Date:")
		replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
		destring v1, replace
		local sscdate = v1[1]
	}
	di as txt "SSC date: " as result "`sscdate'"
	
	// GitHub
	*di as txt "Checking GitHub version..."
	quietly {
		import delim "`giturl'", clear case(lower) delim("***")
		keep if regexm(v1, "d Distribution-Date:")
		replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
		destring v1, replace
		local githubdate = v1[1]
	}
	di as txt "GitHub date: " as result "`githubdate'"
	
	// Compare versions
	di ""
	if `githubdate' > `sscdate' {
		di as result "GitHub version is newer"
		di as txt "Recommended source: " as result "GitHub"
	}
	else if `sscdate' > `githubdate' {
		di as result "SSC version is newer"
		di as txt "Recommended source: " as result "SSC"
	}
	else {
		di as result "Both versions are identical"
	}
	
	// Restore original data
	restore
	
end