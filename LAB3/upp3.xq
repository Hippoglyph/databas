(:Generate a table of all the mountain ranges that contain at least 3 mountains and the number of countries each range touches:)

let $root := doc("mondial.xml")/mondial

let $ranges := distinct-values(
for $mountain in $root/mountain
where count(
	for $mountain2 in $root/mountain
	where $mountain/mountains = $mountain2/mountains
	return $mountain2
	) >= 3
return $mountain/mountains
)

return <ranges>{
	for $range in $ranges
	return 
	<range>{
		<name>{$range}</name>,
		<countryTouches>{  
		count(
			distinct-values(
				for $mountain in $root/mountain
				where data($mountain/mountains) = $range
				return tokenize($mountain/@country, "\s")
			)
		)
		}</countryTouches>
	}</range>
}</ranges>