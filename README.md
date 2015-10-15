safeappend 
==========

Stata command to _append, force_ without destroying data

## Description 
__safeappend__ acts like __append, force__ except that it does
_NOT_ destroy information if the variable in _master_ has a different 
type than _using_. Instead, in the case of a string-numeric conflict, __tostring, replace__ is called on the numeric variable, whether it is in _master_ or _using_.

## Syntax
__safeappend__ using _filename_

## Installation
Use __sysdir__ to find your personal ado folder. Move _safeappend.do_ to that folder.

