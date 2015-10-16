*
* test.do: simple test cases for safeappend
* 
*          for the moment, tests are by visual inspection
* 

pause on

/*  -------------------------
    First make the datasets that we'll use
    ------------------------- */

capture mkdir demo

set obs 5
gen id = _n 
gen foo = 1 
gen bar = 3.14
gen baz = "14 July"
save demo/master_demo, replace

clear 
set obs 5
gen id = _n + 5
gen foo = "One"
gen bar = 2.17
gen baz = 0714
save demo/using_demo, replace
save "demo/using demo spaces", replace

use demo/master_demo, clear
safeappend using "demo/using_demo"
list
pause

safeappend using "demo/using demo spaces"
list
pause

safeappend using "demo/using_demo", list
