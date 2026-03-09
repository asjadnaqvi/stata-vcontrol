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
		quietly {
			import delimited using "`sscurl'", clear case(lower) delim("***")
			keep if regexm(v1, "d Distribution-Date:")
			replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
			destring v1, replace
			local sscdate = v1[1]
		}
		
		// check version
		quietly {
			ssc describe `package', saving(__tempfile.txt, replace)
			import delim using __tempfile.txt, clear case(lower) delim("***")
			keep if regexm(v1, "Distribution-Date:")
			replace v1 = ustrregexra(v1, "Distribution-Date: ", "")
			destring v1, replace
			local sscdate2 = v1[1]
			cap delete __tempfile.txt
		}

		// GitHub
		quietly {
			import delim "`giturl'/`package'.pkg", clear case(lower) delim("***")
			keep if regexm(v1, "d Distribution-Date:")
			replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
			destring v1, replace
			local githubdate = v1[1]
		}


	// Restore original data
	restore

	noi di in yellow "`sscdate2'"	
		
	if `sscdate2' == `sscdate' {
		noi di in yellow "SSC version: `sscdate' (installed)"
		local ssctxt "(installed)"
	}
	
	if `githubdate' > `sscdate' {
		di as txt "SSC   : `sscdate' `ssctxt'"
		di as txt "GitHub: `githubdate' (latest)" 
	}
	else if `sscdate' > `githubdate'  {
		di as txt "SSC   : `sscdate' (latest) `ssctxt'" 
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
