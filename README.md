# overleaf-stata-tools
Stata tools for using Overleaf for dynamic documents

This repo contains several utilities for using Overleaf as a dynamic documents processor. Specifically, it contains:

1. gitSuite, a wrapper for Git shell commands that:
    1. Checks installations and sets a `${git}` global pointing to your Overleaf local clone
    1. Pulls the Overleaf remote
    1. Pushes the Overleaf local to remote
1. mat2csv, which takes an arbitrary Stata matrix with NAME (and, optionally, an identically-sized matrix called NAME_STARS) and writes a well-formatted CSV
    1. This CSV can be read by Caleb Reister's csv.lua script for immediate translation into a TeX table. ([source](https://github.com/calebreister/TeX-Utilities))
1. reg2csv, which takes an arbitrary set of Stata regressions in memory and produces a regression table with the estimates, standard errors, and estimation statistics in the above format.
    1. Syntax and code base are substantially thanks to Michael Lokshin and Zurab Sajaia's excellent [xml_tab](http://ageconsearch.umn.edu/bitstream/122600/2/sjart_dm0037.pdf).
