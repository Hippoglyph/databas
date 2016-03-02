(:Generate the continent names and the number of cities on each continent that are situated no more than 35 degrees from the Equator, for those continents that have an land area above 9000000 sq km:)
<root>{
let $root := doc("mondial.xml")/mondial

for $cont in $root/continent[area >9000000]
return (
	<continent>{
		$cont/name,
		<noCities>{
			count(
				for $country in $root/country
				where $country/encompassed/@continent = $cont/@id
				return $country/city[latitude <= 35 and latitude >= -35]
			)
		}</noCities>
	}</continent>
)
}</root>