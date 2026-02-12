*! version 1.0.0  12feb2026
program define vcontrol
	version 14.0
	syntax anything [, url(string) update replace]
	

	if "`anything'" == "" {
		di as error "A package name is required."
		exit 198
	}

	// Set defaults if not specified
	
	local package `anything'
	
	// Extract first letter of package name for SSC URL
	local firstletter = substr("`package'", 1, 1)
	
	local sscurl "http://fmwww.bc.edu/repec/bocode/`firstletter'/`package'.pkg"
	
	if "`url'" == "" {
		local giturl "https://raw.githubusercontent.com/asjadnaqvi/stata-`package'/refs/heads/main/installation"
	}
	else {
		local giturl "`url'"
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
		*di as txt "SSC date: " as result "`sscdate'"
		
		// GitHub
		*di as txt "Checking GitHub version..."
		quietly {
			import delim "`giturl'/`package'.pkg", clear case(lower) delim("***")
			keep if regexm(v1, "d Distribution-Date:")
			replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
			destring v1, replace
			local githubdate = v1[1]
		}


	// Restore original data
	restore

	*di as txt "GitHub date: " as result "`githubdate'"
	
	// Compare versions
	if `githubdate' > `sscdate' {
		di as txt "SSC   : `sscdate'"
		di as txt "GitHub: `githubdate' (latest)" 
	}
	else if `sscdate' > `githubdate' {
		di as txt "SSC   : `sscdate' (latest)" 
		di as txt "GitHub: `githubdate'" 
	}
	else {
		di as result "Both versions are identical"
	}
	
	if "`update'" != "" {
		if `githubdate' > `sscdate' {
			di as result "Updating from GitHub:"
			net install `package', from("`giturl'") `replace'
				
		}
		else {
			di as result "Updating from SSC:"	
			ssc install `package', `replace'
		}
	}
	
end
