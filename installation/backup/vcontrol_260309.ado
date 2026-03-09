*! vcontrol v1.0 (16 Feb 2026)
*! Asjad Naqvi (asjadnaqvi@gmail.com)

* v1.0  (16 Feb 2026): Beta release.        

program define vcontrol
	version 14.0
	syntax anything [, url(string) update replace]
	

	if "`anything'" == "" {
		di as error "A package name is required."
		exit 198
	}

		
	local package `anything'
	local firstletter = substr("`package'", 1, 1)
	local sscurl "http://fmwww.bc.edu/repec/bocode/`firstletter'/`package'.pkg"
	
	if "`url'" == "" {
		local giturl "https://raw.githubusercontent.com/asjadnaqvi/stata-`package'/refs/heads/main/installation"
	}
	else {
		local giturl "`url'"
	}
	
	preserve
		
		// SSC
		quietly {
			import delimited using "`sscurl'", clear case(lower) delim("***")
			keep if regexm(v1, "d Distribution-Date:")
			replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
			destring v1, replace
			local sscdate = v1[1]
		}
		
		// check local version
		/*
		quietly {
			clear
			cap erase ___tempfile.txt
			ssc describe `package', saving(___tempfile.txt, replace)
			import delim using ___tempfile.txt, clear case(lower) delim("***")
			keep if regexm(v1, "Distribution-Date:")
			replace v1 = ustrregexra(v1, "Distribution-Date: ", "")
			destring v1, replace
			local sscdate2 = v1[1]
			erase ___tempfile.txt
		}
		*/

		// GitHub
		quietly {
			import delim "`giturl'/`package'.pkg", clear case(lower) delim("***")
			keep if regexm(v1, "d Distribution-Date:")
			replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
			destring v1, replace
			local githubdate = v1[1]
		}

	restore

	
		
	*if `sscdate2' == `sscdate' local ssctxt "(already installed)"
	*if `sscdate2' == `githubdate' local gittxt "(already installed)"
	
	if `githubdate' > `sscdate' {
		di in yellow "SSC   : `sscdate' `ssctxt'"
		di in yellow "GitHub: `githubdate' (latest) `gittxt'" 
	}
	else if `sscdate' > `githubdate'  {
		di in yellow "SSC   : `sscdate' (latest) `ssctxt'" 
		di in yellow "GitHub: `githubdate' `gittxt'" 
	}
	else {
		di as result "Both versions are identical"
	}
	
	*if "`sscdate'" > "`sscdate2'" | "`githubdate'" > "`sscdate2'" {
		di as smcl "Click here to {stata vcontrol `package', update replace:update}."
	*}

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
