//////////////////////////////////////////////
//	
//	Calcular o numero de ocupados e rendimento médio por setores na Amazonia
//	
//////////////////////////////////////////////


******************************
**	Amazônia Legal Jovem	**
******************************

global area_geografica = "Amazônia Legal"

forvalues yr = 2012(7)2019{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	* sample 1
	* run code
	do "$code_dir\_definicoes_pnadcontinua_trimestral"
	* keep individuals with age 18 to 29
	keep if faixa_etaria2 == 1 | faixa_etaria3 == 1
	* run code
	do "$code_dir\_numero_ocupados_por_setor"
	* save as temporary
	save "$tmp_dir\_temp_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(7)2019{
	* call data
	append using "$tmp_dir\_temp_PNADC`yr'.dta"
}

* save in the output directory
compress
save "$output_dir\_amz_jovem_numero_ocupados_por_setor.dta", replace

//////////////////////////////////////////////
//	
//	Calcular o numero de ocupados e rendimento médio por tipo de ocupação na Amazonia
//	
//////////////////////////////////////////////

******************************
**	Amazônia Legal Jovem	**
******************************

global area_geografica = "Amazônia Legal"

forvalues yr = 2012(7)2019{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	* sample 1
	* run code
	do "$code_dir\_definicoes_pnadcontinua_trimestral"
	* keep individuals with age 18 to 29
	keep if faixa_etaria2 == 1 | faixa_etaria3 == 1
	* run code
	do "$code_dir\_numero_ocupados_por_ocupacao"
	* save as temporary
	save "$tmp_dir\_temp_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(7)2019{
	* call data
	append using "$tmp_dir\_temp_PNADC`yr'.dta"
}

* save in the output directory
compress
save "$output_dir\_amz_jovem_numero_ocupados_por_ocupacao.dta", replace

//////////////////////////////////////////////
//	
//	Calcular o numero de ocupados e rendimento médio por atividade na Amazonia
//	
//////////////////////////////////////////////

******************************
**	Amazônia Legal Jovem	**
******************************

global area_geografica = "Amazônia Legal"

forvalues yr = 2012(7)2019{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	* sample 1
	* run code
	do "$code_dir\_definicoes_pnadcontinua_trimestral"
	* keep individuals with age 18 to 29
	keep if faixa_etaria2 == 1 | faixa_etaria3 == 1
	* run code
	do "$code_dir\_numero_ocupados_por_atividade"
	* save as temporary
	save "$tmp_dir\_temp_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(7)2019{
	* call data
	append using "$tmp_dir\_temp_PNADC`yr'.dta"
}

* save in the output directory
compress
save "$output_dir\_amz_jovem_numero_ocupados_por_atividade.dta", replace


//////////////////////////////////////////////
//	
//	Calcular o numero de ocupados e rendimento médio por tipo de ocupação na Amazonia
//	(COD de 2 digitos)
//	
//////////////////////////////////////////////

******************************
**	Amazônia Legal Jovem	**
******************************

global area_geografica = "Amazônia Legal"

forvalues yr = 2012(7)2019{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	 * sample 1
	* run code
	do "$code_dir\_definicoes_pnadcontinua_trimestral"
	* keep individuals with age 18 to 29
	keep if faixa_etaria2 == 1 | faixa_etaria3 == 1	
	* run code
	do "$code_dir\_numero_ocupados_por_ocupacao_2digitos"
	* save as temporary
	save "$tmp_dir\_temp_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(7)2019{
	* call data
	append using "$tmp_dir\_temp_PNADC`yr'.dta"
}

* save in the output directory
compress
save "$output_dir\_amz_jovem_numero_ocupados_por_ocupacao_2digitos.dta", replace

//////////////////////////////////////////////
//	
//	Calcular o numero de ocupados e rendimento médio por atividade na Amazonia
//	(CNAE de 2 digitos)
//	
//////////////////////////////////////////////

******************************
**	Amazônia Legal Jovem	**
******************************

global area_geografica = "Amazônia Legal"

forvalues yr = 2012(7)2019{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	 * sample 1
	* run code
	do "$code_dir\_definicoes_pnadcontinua_trimestral"
	* keep individuals with age 18 to 29
	keep if faixa_etaria2 == 1 | faixa_etaria3 == 1	
	* run code
	do "$code_dir\_numero_ocupados_por_atividade_2digitos"
	* save as temporary
	save "$tmp_dir\_temp_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(7)2019{
	* call data
	append using "$tmp_dir\_temp_PNADC`yr'.dta"
}

* save in the output directory
compress
save "$output_dir\_amz_jovem_numero_ocupados_por_atividade_2digitos.dta", replace