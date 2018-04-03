* Write matrix and matrix_STARS to csv

cap prog drop mat2csv
prog def mat2csv

syntax ///
  anything        /// name of matrix
  using           /// location of file
  ,               /// options
  [colnames(string asis)] /// column titles
  [rownames(string asis)] /// row titles
  [dec(integer 2)] /// number of decimal places

* Load matrix into Stata

  preserve
  clear
  qui svmat `anything'
  qui tostring * , force replace

* Decimal places and assorted cleaning

	local zeroes "."
	qui forvalues i = 1/`dec' {
		local zeroes "`zeroes'0"
		}
	qui foreach var of varlist * {
		replace `var' = "0`zeroes'" if regexm(`var',"e-")
    replace `var' = `var' + "`zeroes'" if strpos(`var',".") == 0
		replace `var' = substr(`var',1,strpos(`var',".")+`dec') if strpos(`var',".")
		replace `var' = "0" + `var' if strpos(`var',".") == 1
		replace `var' = subinstr(`var',"-.","-0.",1) if strpos(`var',"-.") == 1
		replace `var' = "`zeroes'" if `var' == "0"
    replace `var' = "" if regexm(`var',"z")
		}

* Stars into text

  cap confirm matrix `anything'_STARS
	qui	if _rc == 0 {

				qui count
				local nrows = `r(N)'
				local c = 0

				foreach var of varlist * {
					local ++c
					local r = 0
					forvalues i = 1/`r(N)' {
						local ++r
						local pv = `anything'_STARS[`r',`c']
						replace `var' = `var' + "*" in `r' if `pv' >= 1
						replace `var' = `var' + "*" in `r' if `pv' >= 2
						replace `var' = `var' + "*" in `r' if `pv' >= 3
					  }
				  }

				foreach var of varlist * {
					replace `var' = `var' + `"\phantom{***}"'
					replace `var' = subinstr(`var',`"***\phantom{***}"',"***",.)
					replace `var' = subinstr(`var',`"**\phantom{***}"',"**\phantom{*}",.)
					replace `var' = subinstr(`var',`"*\phantom{***}"',"*\phantom{**}",.)
				  }
	}

* Column names

  qui if `"`colnames'"' != "" {
    qui count
    set obs `=`r(N)' + 1'
    tempvar sort
      gen `sort' = _n
      replace `sort' = 0 if (_n == _N)
      gsort + `sort'
      drop `sort'

    local col = 0
    foreach var of varlist * {
      local ++ col
      local theName : word `col' of `colnames'
      replace `var' = "{\bf `theName'\phantom{***}}" in 1
      }
    }

* Row names

  qui if `"`rownames'"' != "" {
    local rownames `""" `rownames'"'
    gen a = ""
    order a , first
    qui count
    forvalues row = 1/`r(N)' {
      local theName : word `row' of `rownames'
      replace a = "{\bf `theName'}" in `row'
    }
  }

* Write

outsheet `using' , c replace noq non

end

* Have a lovely day!
