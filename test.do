*
* test.do: simple test cases for safeappend
* 
*          for the moment, tests are by visual inspection
* 

pause on
clear

/*  -------------------------
    First make the datasets that we'll use
    ------------------------- */

capture mkdir demo 

label define yesno 1 "yes" 0 "no", replace

set obs 5
gen id = _n 
gen foo = 1 
gen bar = 3.14
gen baz = "14 July"
gen fizz = (mod(id, 2)==0)
la val fizz yesno	
save demo/master_demo, replace

clear 
set obs 5
gen id = _n + 5
gen foo = "One"
gen bar = 2.17
gen baz = 0714
gen fizz = "true" if (mod(id, 2)==0)
replace fizz = "false" if fizz != "yes"
save demo/using_demo, replace
save "demo/using demo spaces", replace

use demo/master_demo, clear
safeappend using "demo/using_demo", list dry

* test safeappend behavior without spaces in the filename
safeappend using "demo/using_demo", decode
list
pause

* test safeappend behavior with spaces in the filename
safeappend using "demo/using demo spaces", decode
list
pause

