(:Give names of all the countries (recursively) reachable from Sweden via borders:)

declare function local:getAllNeighbor($visited, $root)
{
	let $newC := distinct-values(
		for $country in $root
		return (
			for $vc in $visited/country
			where $vc = $country/@car_code
			return $country/border/@country
			)
	)

	let $allCV := distinct-values(((
		for $c in $visited/country
		return data($c)),
		 $newC))

	let $newVisited := 
		<visited>{
		for $c in $allCV
		return <country>{$c}</country>
		}</visited>

	return 
	if($visited eq $newVisited)
	then $visited
	else local:getAllNeighbor($newVisited, $root)
};

<visited>{

let $root := doc("mondial.xml")/mondial/country
let $visited_ := <visited><country>S</country></visited>
let $visited := local:getAllNeighbor($visited_, $root)


for $c in $visited/country
let $cN := $root[@car_code = $c]/name
return <country>{data($cN)}</country>
}</visited>