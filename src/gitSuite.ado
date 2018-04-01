* gitSuite

* gitReady: check installs and set global (master dofile)

	cap prog drop gitReady
	prog def gitReady

	syntax anything

		* Setup

			! git --version 				// <-- check Git install
			global git `anything' 	// <-- Set output directory

		* Install rendering luacode: user must set engine to LuaTeX in Overleaf

			cap confirm file "${git}/csv.lua"
			if _rc != 0 ///
				cap copy "https://gist.githubusercontent.com/bbdaniels/089fa74cb312eac2694fbe683b9a9dc8/raw/d3416242d10ec3551e17253fa924cdf6bdf1677b/csv.lua" ///
				"${git}/csv.lua" , replace

	end

* gitSet: pull current Overleaf remote (beginning of dofile)

	cap prog drop gitSet
	prog def gitSet

	syntax [anything]

		cd "${git}" // <-- point Stata working directory at Git location
		! git pull  // <-- sync from remote (necessary for Overleaf)

	end

* gitGo: push all changes to Overleaf remote (end of dofile)

	cap prog drop gitGo
	prog def gitGo

	syntax [anything]

			cd "${git}" // <-- point Stata working directory at Git location
			! git add -A
			! git commit -m "Updated from Stata at $S_DATE $S_TIME: `anything'"
			! git push

	end

* Have a lovely day!
