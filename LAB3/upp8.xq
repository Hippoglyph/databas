(:Show a list of country name and projected populations in 10, 25,50 and 100 years if current demographic trends continue unabated:)

declare function local:pow($x as xs:double, $n as xs:double) as xs:double
{
	if($n < 1)
	then 1
	else if ($n > 1)
	then $x*local:pow($x,($n - 1))
	else $x
};

<root>{
let $root := doc("mondial.xml")/mondial

for $country in $root/country
let $ppl := data($country/population[@year = max($country/population/@year)])
let $pplG := data($country/population_growth) div 100 + 1
return 
<country id="{$country/@car_code}">{
		$country/name,
		if(empty($pplG))
		then ()
		else
			for $n in (0, 10, 25, 50, 100)
			return <year in="{$n}">{round($ppl * local:pow($pplG, $n))}</year>
	}</country>
}</root>