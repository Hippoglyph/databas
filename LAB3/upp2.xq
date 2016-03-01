(:Give the name and area of the world's northernmost desert:)

let $root := doc("mondial.xml")/mondial

let $nDesert := (
	for $x in $root/desert
	order by $x/latitude descending
	return $x
	)[1]

return <veryNorth>{
	$nDesert/name, 
	$nDesert/area
	}</veryNorth>