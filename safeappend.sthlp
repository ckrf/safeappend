{smcl}
{* *! version 0.1.1  15oct2015}{...}
{vieweralsosee "[D] append" "mansection D append"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] append" "help append"}{...}
{viewerjumpto "Syntax" "append##syntax"}{...}
{viewerjumpto "Description" "append##description"}{...}
{viewerjumpto "Options" "append##options"}{...}
{viewerjumpto "Examples" "append##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :safeappend {hline 2}}Force append but keep all data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{hi:safeappend} using {it: {help filename}} [{cmd:,} {opt l:ist} {opt dry:run}]

{marker description}{...}
{title:Description}

{pstd}
{cmd:safeappend} acts like {hi:append, force} except that it does
{it:NOT} destroy information if the variable in {it:master} has a different 
type than {it:using}. Instead, in the case of a string-numeric conflict, 
the numeric variable is {help tostring}ed.


{marker options}{...}
{title:Options}

{phang}
{opt list} displays all variables that conflict and their respective type in {it:master} and {it:using}.

{phang}
{opt dryrun} shows output from running {hi:safeappend} but does not alter the dataset. There is no reason to specify {hi:dryrun} without specifying other options such as {hi:list}.

{marker examples}{...}
{title:Examples}

{pstd} 
See the test "suite" {hi:test.do} in the Github repository

