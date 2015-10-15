safeappend 
==========

Stata command to _append, force_ without destroying data

## Description 
__safeappend__ acts like {hi:append, force} except that it does
{it:NOT} destroy information if the variable in {it:master} has a different 
type than {it:using}. Instead, in the case of a string-numeric conflict, 
the numeric variable is {help tostring}ed.

## Syntax
__safeappend__ using _filename_

## Installation
Use __sysdir__ to find your personal ado folder. Move _safeappend.do_ to that folder.

