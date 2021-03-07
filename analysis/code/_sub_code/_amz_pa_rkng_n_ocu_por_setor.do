******************************************************
**	 Rankings de variação absoluta de ocupações	**
******************************************************

* call data 
use "$input_dir\_amz_pa_numero_ocupados_por_setor.dta", clear

gen id = cod_setor
sort Ano Trimestre cod_setor id

* generate variable of quartely date
	tostring Ano, replace
	tostring Trimestre, replace
	gen iten1 = Ano + "." + Trimestre
	gen  trim = quarterly(iten1, "YQ")
	drop iten*
		
* edit format
cap destring id, replace
tsset id trim, quarterly 
format %tqCCYY trim	


******************************************************************
**	crescimento da media dos trimestres de 2012 a media 2019	**	
******************************************************************

* preserve
*preserve

keep if Ano == "2019" | Ano == "2012"

collapse (mean) n_ocu_str, by (cod_setor Ano)

drop if cod_setor=="."

sort cod_setor Ano

by cod_setor, sort: gen delta_n = (n_ocu_str[_n] - n_ocu_str[_n-1])

collapse (mean) delta_n, by (cod_setor)
gsort -delta_n


gen cod_setor_label = ""

replace	cod_setor_label = "Agricultura, pecuária, produção florestal, pesca e aquicultura"  if cod_setor == "1"
replace	cod_setor_label = "Indústria geral" if cod_setor == "2"
replace	cod_setor_label = "Construção" if cod_setor == "3"
replace	cod_setor_label = "Comércio, reparação de veículos automotores e motocicletas" if cod_setor == "4"
replace	cod_setor_label = "Transporte, armazenagem e correio"  if cod_setor == "5"
replace	cod_setor_label = "Alojamento e alimentação"  if cod_setor == "6"
replace	cod_setor_label = "Informação, comunicação e atividades financeiras, imobiliárias, profissionais e administrativas" if cod_setor == "7"
replace cod_setor_label = "Administração pública, defesa e seguridade social" if cod_setor == "8"
replace cod_setor_label = "Educação, saúde humana e serviços sociais" if cod_setor == "9"
replace cod_setor_label = "Outros Serviços" if cod_setor == "10"
replace cod_setor_label = "Serviços domésticos" if cod_setor == "11"
replace cod_setor_label = "Atividades mal definidas" if cod_setor == "12"

* format
format delta_n %16,0fc

*gen iten1 = string(tx_crescimento, "%8.2f") + "%"
*cap drop tx_crescimento
*rename iten1 delta_n

* drop irrelevant variables
* cap drop cod_setor
tostring cod_setor, replace
destring delta_n, replace

// transforma data em matrix
mkmat delta_n, matrix(A) rownames(cod_setor)

* local notes
local ttitle "Variação absoluta do número ocupações por setor econômico entre 2012 e 2019"
local tnotes "Fonte: com base nos dados da PNAD Contínua, IBGE"


#delim ;    
esttab matrix(A, fmt(%16,0fc)) using "$output_dir\amzparkngnocuporsetor.tex", 
	replace 
	collabels("Variação")
    prehead(
        "\begin{table}[H]"
        "\centering"
		"\label{amzparkngnocuporsetor}"
		"\scalebox{0.70}{"
        "\begin{threeparttable}"
        "\caption{`ttitle'}"		
        "\begin{tabular}{l*{@span}{r}}"
        "\midrule \midrule"
    )
    postfoot(
        "\bottomrule"
        "\end{tabular}"		
        "\begin{tablenotes}"
        "\item \scriptsize{`tnotes'}"
        "\end{tablenotes}"
        "\end{threeparttable}"
		"}"
        "\end{table}"
    )    
	label
    unstack 
	noobs 
	nonumber 
	nomtitle
        coeflabels(
        1 "Agricultura, pecuária, produção florestal, pesca e aquicultura" 
        2 "Indústria geral"
        3 "Construção" 
        4 "Comércio, reparação de veículos automotores e motocicletas"
        5 "Transporte, armazenagem e correio"
        6 "Alojamento e alimentação"
        7 "Informação, comunicação e atividades financeiras, imobiliárias, profissionais e administrativas"
        8 "Administração pública, defesa e seguridade social"
        9 "Educação, saúde humana e serviços sociais"
        10 "Outros Serviços"
        11 "Serviços domésticos"
        12 "Atividades mal definidas"
    ) 
    ;
#delim cr
