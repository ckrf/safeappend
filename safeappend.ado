*
* safeappend.ado: append whenever varnames match, but don't delete data
*

program define safeappend 
    version 12
    syntax using [, List DRYrun]

quietly { // no output from intermediate commands

* -- save current state -- *
tempfile master
save `master', emptyok

/*  -------------------------
    Loop over master dataset and post varnames and types
    ------------------------- */
* postfile config 
tempname postvars
tempfile mastervars 
postfile `postvars' str32 varname str7 mastertype using `mastervars'

* loop and post
use `master'
local mastertype "" // string or numeric
foreach var of varlist _all {
    capture confirm numeric variable `var'
    if _rc { // string
        local mastertype "string"
    }
    else { //numeric
        local mastertype "numeric"
    }
    post `postvars' ("`var'") ("`mastertype'")
}

* wrap up
postclose `postvars'
clear

use `mastervars'

/*  -------------------------
    Loop over using dataset and post varnames and types
    ------------------------- */

* postfile config 
tempfile usingvars 
postfile `postvars' str32 varname str7 usingtype using `usingvars'

* loop and post
use `using'
local usingtype "" // string or numeric
foreach var of varlist _all {
    capture confirm numeric variable `var'
    if _rc { // string
        local usingtype "string"
    }
    else { //numeric
        local usingtype "numeric"
    }
    post `postvars' ("`var'") ("`usingtype'")
}

* wrap up
postclose `postvars'
clear

/*  -------------------------
    Merge posted variable type lists for using and master
    ------------------------- */
use `mastervars' 
merge 1:1 varname using `usingvars', keep(match) 
    // TODO: preserve order of variable names
drop _merge

* list differences if requested
if !missing("`list'") {
noisily {
    di
    di "Variables with string/numeric conflict:"
    list if usingtype != mastertype, noobs ab(10)
}
}

* dummy variables if tostringing needed
gen num_master_only = 1 if mastertype == "numeric" & usingtype == "string"
gen num_using_only = 1 if usingtype == "numeric" & mastertype == "string"

/*  -------------------------
    "write" programs to tostring master, using, then run those programs on each
    dataset 
    ------------------------- */

tempfile tostring_using tostring_master
gen cmd = "tostring " + varname + ", replace"
outsheet cmd using `tostring_master' if !missing(num_master_only), noq non
outsheet cmd using `tostring_using' if !missing(num_using_only), noq non

tempfile master_safe
use `master', clear
do `tostring_master'
save `master_safe', emptyok

tempfile using_safe
use `using', clear
do `tostring_using'
save `using_safe', emptyok

/*  -------------------------
    Actually append
    ------------------------- */
if missing("`dryrun'") {
    use `master_safe'
    append using `using_safe'
}
else {
    * restore initial dataset
    use `master'
}

} // quietly
end
