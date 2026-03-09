*! vcontrol v1.0 (16 Feb 2026)
*! Asjad Naqvi (asjadnaqvi@gmail.com)

* v1.0 (16 Feb 2026): Beta release.        

program define vcontrol, rclass
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
		
		// GitHub
		quietly {
			import delim "`giturl'/`package'.pkg", clear case(lower) delim("***")
			keep if regexm(v1, "d Distribution-Date:")
			replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
			destring v1, replace
			local githubdate = v1[1]
		}
		
		
		// local date
		quietly {		
			import delim using `c(sysdir_plus)'/stata.trk, clear delim("***") case(lower)
			drop v2 // just contains junk

			gen _tracker = .

			local firstletter = substr("tidytuesday", 1, 1)
			replace _tracker = 0 if v1=="e"
			replace _tracker = 1 if regexm(v1, "^N tidytuesday.pkg$")==1

			carryforward _tracker, replace
			keep if _tracker==1

			keep if regexm(v1, "d Distribution-Date:")
			replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
			destring v1, replace

			summ v1, meanonly
			local localdate = `r(max)'
		}
		
	restore
	
	if "`update'" == "" { 
		if `localdate' == max(`sscdate', `githubdate') {
			di in yellow "Latest version (`localdate') already installed."
		}
		else {
			if `githubdate' > `sscdate'  {
				di in yellow "SSC   : `sscdate' `ssctxt'"
				di in yellow "GitHub: `githubdate' (latest) `gittxt'" 
			}
			else if `sscdate' > `githubdate' {
				di in yellow "SSC   : `sscdate' (latest) `ssctxt'" 
				di in yellow "GitHub: `githubdate' `gittxt'" 
			}
		
			di as smcl "Click here to {stata vcontrol `package', update replace:install} the latest version."
		}
	}

	

	if "`update'" != "" &`localdate' == max(`sscdate', `githubdate') {
		if `githubdate' > `sscdate' {
			di as result "Updating from GitHub:"
			net install `package', from("`giturl'") `replace'
		}
		else {
			di as result "Updating from SSC:"	
			ssc install `package', `replace'
		}
	}
	
	return local github `githubdate'
	return local ssc	`sscdate'
	return local local  `localdate'
	
	
end
