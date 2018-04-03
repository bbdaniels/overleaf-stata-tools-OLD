* This is a DEMO

* Master setup

  global directory "/Users/bbdaniels/GitHub/overleaf-stata-demo"

  qui do "${directory}/ado/gitSuite.ado"
  qui do "${directory}/ado/mat2csv.ado"
  qui do "${directory}/ado/reg2csv.ado"

  gitReady "/Users/bbdaniels/GitHub/overleaf-stata-demo"

* Pull repo

  gitSet

* random eps file

  sysuse auto , clear
  scatter price mpg
  graph export "${git}/figure.eps" , replace

* mat2csv

  sysuse auto , clear
  reg price mpg headroom trunk weight
  mat a = r(table)
    mat a_STARS = J(rowsof(a),colsof(a),1)

  mat2csv ///
      a ///
      using "${git}/test.csv" ///
    , rownames("Test A" "b" "c" "d" "e" "f") ///
      colnames("1" "2" "3" "4")

* reg2csv

  sysuse auto, clear
  reg price mpg rep78 headroom
    est sto reg1
  reg price mpg  headroom
    est sto reg2

  reg2csv ///
    reg1 reg2 ///
    using "${git}/regtest.csv" ///
  , stats(N r2)

* Push

  gitGo Comments go here

* Enjoy overleaf-stata-tools!
