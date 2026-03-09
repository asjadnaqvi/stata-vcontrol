clear

local package tidytuesday
local firstletter = substr("`package'", 1, 1)

// we pick up information from a file on GitHub:
// this currently has manual dates entered but can be automated as well.
import delim using "https://raw.githubusercontent.com/asjadnaqvi/stata-tidytuesday/refs/heads/main/version.txt", delim(";")

local sscdate = v2[1]
local githubdate = v2[2]

di "Online SSC date 	= `sscdate'"
di "Online GitHub date 	= `githubdate'"


// question is how we can check the local file version?
// in my own programs there is a distribution date in the ado
// these are stored in sysdir plus

sysdir

display "$S_ADO"

display "`c(sysdir_plus)'"

*findfile tidytuesday.ado
*return list
*di "`r(fn)'"





import delim using `c(sysdir_plus)'/stata.trk, clear delim("***") case(lower)
drop v2 // just contains junk

gen _tracker = .

local firstletter = substr("tidytuesday", 1, 1)
di "`firstletter'"

replace _tracker = 0 if v1=="e"
*replace _tracker = 1 if regexm(v1, "^S http://fmwww\.bc\.edu/repec/bocode/t$")==1
replace _tracker = 1 if regexm(v1, "^N tidytuesday.pkg$")==1

carryforward _tracker, replace
keep if _tracker==1


keep if regexm(v1, "d Distribution-Date:")
replace v1 = ustrregexra(v1, "d Distribution-Date: ", "")
destring v1, replace

summ v1, meanonly
local localdate = `r(max)'
	
	
di "Local installation: `localdate'"	

