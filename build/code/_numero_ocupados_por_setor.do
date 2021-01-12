**************************************************
**	 Calcular numero de ocupacoes por setores	**
**************************************************

/////////////////////////////////////////////////////////
//	Numero de ocupacoes por setores
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if ocupado == 1
by Ano Trimestre VD4010, sort: egen iten2 = total(iten1)
replace iten2 = round(iten2)
gen n_ocu_str = iten2
label variable n_ocu_str "Número de ocupados por setor econômico"
cap drop iten*

/////////////////////////////////////////////////////////
//	numero de ocupados formal por setor econômico
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if ocupado == 1 & formal ==1
by Ano Trimestre VD4010, sort: egen iten2 = total(iten1)
replace iten2 = round(iten2)
gen n_ocu_str_formal = iten2
label variable n_ocu_str_formal "Número de ocupados formal por setor econômico"
cap drop iten*

/////////////////////////////////////////////////////////
//	numero de ocupados informal por setor econômico
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if ocupado == 1 & informal ==1
by Ano Trimestre VD4010, sort: egen iten2 = total(iten1)
replace iten2 = round(iten2)
gen n_ocu_str_informal = iten2
label variable n_ocu_str_informal "Número de ocupados informal por setor econômico"
cap drop iten*


/////////////////////////////////////////////////////////
//	Rendimentos real
/////////////////////////////////////////////////////////

* Merge na base de dados com o deflator
merge m:1 Ano Trimestre UF using "$input_dir\deflatorPNADC_2012.1-2020.3.dta", update force
drop if _merge==2 
drop _merge

* Rendimento medio habitual real dos ocupados total
gen iten1 = ocupado * (VD4019 * Habitual) * V1028
by Ano Trimestre VD4010, sort: egen total_renda_ocupado = total(iten1)
gen renda = (total_renda_ocupado/n_ocu_str)
drop iten*
label variable renda "Rendimento médio habitual real dos ocupados (R$)"

* Rendimento medio habitual real dos ocupados formal total
gen iten1 = ocupado * (VD4019 * Habitual) * V1028 if formal ==1 
by Ano Trimestre VD4010, sort: egen iten2 = total(iten1)
gen renda_formal = (iten2/n_ocu_str_formal)
drop iten*
label variable renda_formal "Rendimento médio habitual real dos ocupados formal (R$)"

* Rendimento medio habitual real dos ocupados informal total
gen iten1 = ocupado * (VD4019 * Habitual) * V1028 if informal ==1 
by Ano Trimestre VD4010, sort: egen iten2 = total(iten1)
gen renda_informal = (iten2/n_ocu_str_informal)
drop iten*
label variable renda_informal "Rendimento médio habitual real dos ocupados informal (R$)"

***********************************************
**	Colapsar ao nível do trimestre e setor	 **
***********************************************

// attach label of variables
local colvar n_* renda_*

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano Trimestre VD4010)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}

gen cod_setor = VD4010
cap tostring cod_setor, replace