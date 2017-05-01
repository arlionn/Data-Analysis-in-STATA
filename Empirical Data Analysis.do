use "/Users/jerry_hsieh/Desktop/m1998-m2007.unbalance.dta", clear

gen Reg=substr(b056,1,2)

gen Reg2=real(Reg)

drop Reg

destring b07 ,replace force

gen Ind2=int(b07/100)

gen Ind3=int(b07/10)

gen Ind4=b07



gen output_2= output_2digit/100 

gen input_2= input_2digit/100 

gen Y=v207/output_2 

gen Sale=v209/output_2 

gen S0 = ln(Sale)

gen L=v210

gen lp=ln(Y/L)

gen K=f309/input_2 

gen k=ln(K)

gen M=f356/input_2

gen m=ln(M)

gen V = Y - M 

gen v = ln(V)

gen l=ln(L)

gen exvalue = v213 /output_2


gen EXratio=(v213/v209)

drop if L < 10

drop if M < 0  | V < 0 | K < 0 | L<0  | Y  < 0 | EXratio < 0 | EXratio == .  | M == . | V == . | K == . | L == .  | Y ==.  

gen exp = 1 if EXratio != 0 & EXratio != .

replace exp = 0 if exp == . & EXratio != . 

sort ID year

by ID: gen always = 1 if exp == 1 & exp[_n+1] != 0 & exp[_n+2] != 0 & exp[_n+3] != 0 & exp[_n+4] != 0 & exp[_n+5] != 0 & exp[_n+6] != 0 & exp[_n+7] != 0 & exp[_n+8] != 0 & exp[_n+9] != 0 & exp[_n-1] != 0 & exp[_n-2] != 0 & exp[_n-3] != 0 & exp[_n-4] != 0 & exp[_n-5] != 0 & exp[_n-6] != 0 & exp[_n-7] != 0 & exp[_n-8] != 0 & exp[_n-9] != 0
replace always = 0 if always == . & EXratio != .


by ID: gen starter = 1 if exp[_n-1] != 1 & exp[_n-2] != 1 & exp[_n-3] != 1 & exp[_n-4] != 1 & exp[_n-5] != 1 & exp[_n-6] != 1 & exp[_n-7] != 1  & exp[_n-8] != 1 & exp[_n-9] != 1 & exp == 1 & exp[_n+1] != 0 & exp[_n+2] != 0 & exp[_n+3] != 0 & exp[_n+4] != 0 & exp[_n+5] != 0 & exp[_n+6] != 0 & exp[_n+7] != 0 & exp[_n+8] != 0 & exp[_n+9] != 0 & always != 1
replace starter = 0 if starter == . & EXratio != .


by ID: gen never = 1 if exp == 0 & exp[_n+1] != 1 & exp[_n+2] != 1 & exp[_n+3] != 1 & exp[_n+4] != 1 & exp[_n+5] != 1 & exp[_n+6] != 1 & exp[_n+7] != 1 & exp[_n+8] != 1 & exp[_n+9] != 1 & exp[_n-1] != 1 & exp[_n-2] != 1 & exp[_n-3] != 1 & exp[_n-4] != 1 & exp[_n-5] != 1 & exp[_n-6] != 1 & exp[_n-7] != 1 & exp[_n-8] != 1 & exp[_n-9] != 1
replace never = 0 if never == . & EXratio != .


by ID: gen quitter = 1 if exp[_n-1] != 0 & exp[_n-2] != 0 & exp[_n-3] != 0 & exp[_n-4] != 0 & exp[_n-5] != 0 & exp[_n-6] != 0 & exp[_n-7] != 0 & exp[_n-8] != 0 & exp[_n-9] != 0 & exp == 0 & exp[_n+1] != 1 & exp[_n+2] != 1 & exp[_n+3] != 1 & exp[_n+4] != 1 & exp[_n+5] != 1 & exp[_n+6] != 1 & exp[_n+7] != 1 & exp[_n+8] != 1 & exp[_n+9] != 1 & never != 1  
replace quitter = 0 if quitter == . & EXratio != .


gen test = starter + never + always + quitter
by ID: gen mix = 1 if test[_n-1] != 1 & test[_n-2] != 1 & test[_n-3] != 1 & test[_n-4] != 1 & test[_n-5] != 1 & test[_n-6] != 1 & test[_n-7] != 1 & test[_n-8] != 1 & test[_n-9] != 1 & test != 1 & test[_n+1] != 1 & test[_n+2] != 1 & test[_n+3] != 1 & test[_n+4] != 1 & test[_n+5] != 1 & test[_n+6] != 1 & test[_n+7] != 1 & test[_n+8] != 1 & test[_n+9] != 1 & exp != .
replace mix = 0 if mix == . & EXratio != .
drop test


gen starterdum = starter

gen quitterdum = quitter


by ID: replace starter = 1 if starter[_n+1] == 1

by ID: replace starter = 1 if starter[_n+2] == 1

by ID: replace starter = 1 if starter[_n+3] == 1

by ID: replace starter = 1 if starter[_n+4] == 1

by ID: replace starter = 1 if starter[_n+5] == 1

by ID: replace starter = 1 if starter[_n+6] == 1

by ID: replace starter = 1 if starter[_n+7] == 1

by ID: replace starter = 1 if starter[_n+8] == 1

by ID: replace starter = 1 if starter[_n+9] == 1

by ID: replace starter = 1 if starter[_n-1 ] == 1

by ID: replace quitter = 1 if quitter[_n+1] == 1

by ID: replace quitter = 1 if quitter[_n+2] == 1

by ID: replace quitter = 1 if quitter[_n+3] == 1

by ID: replace quitter = 1 if quitter[_n+4] == 1

by ID: replace quitter = 1 if quitter[_n+5] == 1

by ID: replace quitter = 1 if quitter[_n+6] == 1

by ID: replace quitter = 1 if quitter[_n+7] == 1

by ID: replace quitter = 1 if quitter[_n+8] == 1

by ID: replace quitter = 1 if quitter[_n+9] == 1

by ID: replace quitter = 1 if quitter[_n-1 ] == 1

gen test = starter + never + always + mix + quitter 

drop if test == 0 


by ID: gen n = _n
gen nn = n if starterdum == 1
by ID: replace nn = nn[_n+1] if nn == .
by ID: replace nn = nn[_n+2] if nn == .
by ID: replace nn = nn[_n+3] if nn == .
by ID: replace nn = nn[_n+4] if nn == .
by ID: replace nn = nn[_n+5] if nn == .
by ID: replace nn = nn[_n+6] if nn == .
by ID: replace nn = nn[_n+7] if nn == .
by ID: replace nn = nn[_n+8] if nn == .
by ID: replace nn = nn[_n+9] if nn == .
by ID: replace nn = nn[_n-1] if nn == .
gen time = n - nn


by ID: gen nnn = n if quitterdum == 1 
by ID: replace nnn = nnn[_n+1] if nnn == .
by ID: replace nnn = nnn[_n+2] if nnn == .
by ID: replace nnn = nnn[_n+3] if nnn == .
by ID: replace nnn = nnn[_n+4] if nnn == .
by ID: replace nnn = nnn[_n+5] if nnn == .
by ID: replace nnn = nnn[_n+6] if nnn == .
by ID: replace nnn = nnn[_n+7] if nnn == .
by ID: replace nnn = nnn[_n+8] if nnn == .
by ID: replace nnn = nnn[_n+9] if nnn == .
by ID: replace nnn = nnn[_n-1] if nnn == .
gen time1 = n - nnn
drop nnn

by ID: gen nnn = _N if mix == 1 
gen f = (nnn+1)/2
gen ff = int(f)
gen time2 = n - ff
drop nnn f ff

by ID: gen nnn = _N if never == 1 
gen f = (nnn+1)/2
gen ff = int(f)
gen time3 = n - ff
drop nnn f ff

by ID: gen nnn = _N if always == 1 
gen f = (nnn+1)/2
gen ff = int(f)
gen time4 = n - ff
drop nnn f ff

gen s = .
replace s = time if time != .
replace s = time1 if time1 !=.
replace s = time2 if time2 !=.
replace s = time3 if time3 !=.
replace s = time4 if time4 !=.


drop if Ind2 == 25 | Ind2 == 38 | Ind2 == 16

egen g = group(Ind2)

xtset ID year

gen TFP = .

forvalues x = 13/15{
disp `x'
levpet v if Ind2== `x' , free(l) proxy(m) capital(k) valueadded reps(50) 
predict tfp`x'  if Ind2 == `x' , omega
replace TFP = tfp`x' if Ind2 == `x'
}

forvalues x = 17/24{
disp `x'
levpet v if Ind2== `x' , free(l) proxy(m) capital(k) valueadded reps(50) 
predict tfp`x'  if Ind2 == `x' , omega
replace TFP = tfp`x' if Ind2 == `x'
use "/Users/jerry_hsieh/Desktop/prod.dta", replace
}

forvalues x = 26/37{
disp `x'
levpet v if Ind2== `x' , free(l) proxy(m) capital(k) valueadded reps(50) 
predict tfp`x'  if Ind2 == `x' , omega
replace TFP = tfp`x' if Ind2 == `x'
}

forvalues x = 39/42{
disp `x'
levpet v if Ind2== `x' , free(l) proxy(m) capital(k) valueadded reps(50) 
predict tfp`x'  if Ind2 == `x' , omega
replace TFP = tfp`x' if Ind2 == `x'
}

gen tfp = ln(TFP)
rename tfp prod0


save "/Users/jerry_hsieh/Desktop/prod.dta", replace

xtset ID s

drop owner

gen owner = .

replace owner =1 if starter ==1

replace owner =2 if quitter ==1

replace owner =3 if always ==1 

replace owner =4 if never == 1 

replace owner = 5 if mix == 1

collapse (mean) prod0 if Ind2 == 13, by(owner s) 


gen starter = prod0 if owner == 1

gen quitter = prod0 if owner == 2 

gen always = prod0 if owner == 3 

gen never = prod0 if owner == 4

gen mix = prod0 if owner == 5

collapse starter quitter always never mix, by(s)

twoway(line starter quitter always never mix s) if tin(-4, 5)


use "/Users/jerry_hsieh/Desktop/prod.dta", replace

drop if alway == 1 
drop if mix == 1 

gen foreign = 0
gen jv = 0
gen frate = (f395+f303)/f301
replace foreign = 1 if frate == 1
replace jv = 1 if frate > 0 & frate != 1 
gen srate = f302/f301
gen soe = 0
replace soe = 1 if srate == 1
drop frate srate 
gen nonsoe = 0
replace nonsoe = 1 if foreign == 0 & soe == 0 & jv == 0
gen Other = 0
replace Other = 1 if foreign == 0 & soe == 0

by ID: gen lagl = v210[_n-1]
replace lagl = 0 if lagl == .
gen lagprod = .
replace lagprod = prod0[_n-1] if ID[_n] == ID[_n-1]
gen lagprod_2 = lagprod^2
by ID: gen lagk = k[_n-1]

gen lagkl = lagl*lagk
gen lagkl_2 = lagkl^2
gen lagprodkl = lagprod*lagkl


by ID: gen lagm = m[_n-1]
gen m_growth = m - lagm

by ID: gen lagsoe = soe[_n-1]
by ID: gen lagforeign = foreign[_n-1]
by ID: gen lagjv = jv[_n-1]
by ID: gen lagnonsoe = nonsoe[_n-1]
by ID: gen lagOther = Other[_n-1]

gen lagprodk = lagprod*lagk
gen lagnonsoejv = lagnonsoe*lagjv

gen lagprodsoe = lagprod*lagsoe
gen lagprodOther = lagprod*lagOther

gen d99 =1 if year == 1999
gen d00 = 1 if year == 2000
gen d01 = 1 if year == 2001
gen d02 = 1 if year == 2002 
gen d03 = 1 if year == 2003
gen d04 = 1 if year == 2004
gen d05 =1 if year == 2005
gen d06 =1 if year == 2006
gen d07 =1 if year ==2007

replace d99 = 0 if d99 ==.
replace d00 = 0 if d00 == .
replace d01 = 0 if d01 == .
replace d02 = 0 if d02 == . 
replace d03 = 0 if d03 == .
replace d04 =0 if d04 == .
replace d05 =0 if d05 == .
replace d06 =0 if d06==.
replace d07 =0 if d07==.

gen ps = .


forvalues j = 13/15{
disp `j'
pscore starterdum lagprod lagk lagl lagsoe lagOther d99 d00 d01 d02 d03 d04 d05 d06 d07 if  Ind2== `j' ,  pscore(ps`j')
replace ps = ps`j' if Ind2 == `j'
}
forvalues j = 17/24{
disp `j'
pscore starterdum lagprod lagk lagl lagsoe lagOther d99 d00 d01 d02 d03 d04 d05 d06 d07  if  Ind2== `j' ,  pscore(ps`j')
replace ps = ps`j' if Ind2 == `j'
}
forvalues j = 26/37{
disp `j'
pscore starterdum lagprod lagk lagl lagsoe lagOther d99 d00 d01 d02 d03 d04 d05 d06 d07 if Ind2== `j' ,  pscore(ps`j')
replace ps = ps`j' if Ind2 == `j'
}
forvalues j = 39/42{
disp `j'
pscore starterdum lagprod lagk lagl lagsoe lagOther d99 d00 d01 d02 d03 d04 d05 d06 d07 if Ind2== `j' , pscore(ps`j')
replace ps = ps`j' if Ind2 == `j'
}




sort ID time2

gen prod1 = .
gen prod2 = .
gen prod3 = .
gen prod4 = .
gen prod5 = . 
gen prod6 = .
gen prod7 = .
replace prod1 = prod0[_n+1] if ID[_n] == ID[_n+1]
replace prod2 = prod0[_n+2] if ID[_n] == ID[_n+2]
replace prod3 = prod0[_n+3] if ID[_n] == ID[_n+3]
replace prod4 = prod0[_n+4] if ID[_n] == ID[_n+4]
replace prod5 = prod0[_n+5] if ID[_n] == ID[_n+5]
replace prod6 = prod0[_n+6] if ID[_n] == ID[_n+6]
replace prod7 = prod0[_n+7] if ID[_n] == ID[_n+7]

save "/Users/jerry_hsieh/Desktop/retested pscore.dta", replace


forvalues t= 0/5 {
clear 
use "/Users/jerry_hsieh/Desktop/retested pscore.dta"
drop if s >= 1

qui gen att`t' =.
gen treat`t' =.
qui levelsof g, l(gr)
qui foreach j of local gr {
capture psmatch2 starterdum if prod`t' !=. & g==`j' , out(prod`t') p(ps) neighbor(10)
replace att`t' = r(att) if g == `j' & prod`t' != .
replace treat`t' =_treated if g== `j'  
}
keep if treat`t' !=.
bs m = r(mean), reps(250): sum att`t'  if att`t' !=. 
sum att`t'  if att`t'  != .
}

forvalues t= 0/5 {
clear
use "/Users/jerry_hsieh/Desktop/retested pscore.dta"

keep if foreign == 1 

drop if s >= 1

qui gen att`t' =.
gen treat`t' =.
qui levelsof g, l(gr)
qui foreach j of local gr {
capture psmatch2 starterdum if prod`t' !=. & g==`j' , out(prod`t') p(ps) neighbor(10)
replace att`t' = r(att) if g == `j' & prod`t' != .
replace treat`t' =_treated if g== `j'  
}
keep if treat`t' !=.
bs m = r(mean), reps(250): sum att`t'  if att`t' !=. 
sum att`t'  if att`t'  != .
}

forvalues t= 0/5 {
clear
use "/Users/jerry_hsieh/Desktop/pscore.dta"

keep if soe == 1 

drop if s >= 1

qui gen att`t' =.
gen treat`t' =.
qui levelsof g, l(gr)
qui foreach j of local gr {
capture psmatch2 starterdum if prod`t' !=. & g==`j' , out(prod`t') p(ps) neighbor(10)
replace att`t' = r(att) if g == `j' & prod`t' != .
replace treat`t' =_treated if g== `j'  
}
keep if treat`t' !=.
bs m = r(mean), reps(250): sum att`t'  if att`t' !=. 
sum att`t'  if att`t'  != .
}

forvalues t= 0/5 {
clear
use "/Users/jerry_hsieh/Desktop/pscore.dta"

keep if Other == 1 

drop if s >= 1

qui gen att`t' =.
gen treat`t' =.
qui levelsof g, l(gr)
qui foreach j of local gr {
capture psmatch2 starterdum if prod`t' !=. & g==`j' , out(prod`t') p(ps) neighbor(10)
replace att`t' = r(att) if g == `j' & prod`t' != .
replace treat`t' =_treated if g== `j'  
}
keep if treat`t' !=.
bs m = r(mean), reps(250): sum att`t'  if att`t' !=. 
sum att`t'  if att`t'  != .
}

forvalues t= 0/5 {
clear
use "/Users/jerry_hsieh/Desktop/pscore.dta"

keep if L < 50 

drop if s >= 1

qui gen att`t' =.
gen treat`t' =.
qui levelsof g, l(gr)
qui foreach j of local gr {
capture psmatch2 starterdum if prod`t' !=. & g==`j' , out(prod`t') p(ps) neighbor(10)
replace att`t' = r(att) if g == `j' & prod`t' != .
replace treat`t' =_treated if g== `j'  
}
keep if treat`t' !=.
bs m = r(mean), reps(250): sum att`t'  if att`t' !=. 
sum att`t'  if att`t'  != .
}

forvalues t= 0/5 {
clear
use "/Users/jerry_hsieh/Desktop/pscore.dta"

keep if L>= 50 & L < 250 

drop if s >= 1

qui gen att`t' =.
gen treat`t' =.
qui levelsof g, l(gr)
qui foreach j of local gr {
capture psmatch2 starterdum if prod`t' !=. & g==`j' , out(prod`t') p(ps) neighbor(10)
replace att`t' = r(att) if g == `j' & prod`t' != .
replace treat`t' =_treated if g== `j'  
}
keep if treat`t' !=.
bs m = r(mean), reps(250): sum att`t'  if att`t' !=. 
sum att`t'  if att`t'  != .
}

forvalues t= 0/5 {
clear
use "/Users/jerry_hsieh/Desktop/pscore.dta"

keep if L>=250 

drop if s >= 1

qui gen att`t' =.
gen treat`t' =.
qui levelsof g, l(gr)
qui foreach j of local gr {
capture psmatch2 starterdum if prod`t' !=. & g==`j' , out(prod`t') p(ps) neighbor(10)
replace att`t' = r(att) if g == `j' & prod`t' != .
replace treat`t' =_treated if g== `j'  
}
keep if treat`t' !=.
bs m = r(mean), reps(250): sum att`t'  if att`t' !=. 
sum att`t'  if att`t'  != .
}


