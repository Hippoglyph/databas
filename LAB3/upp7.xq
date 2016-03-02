(:Names of the organizations in Europe containing the word 'Nuclear', with an unknown date of establishment:)

let $root := doc("mondial.xml")/mondial

for $org in $root/organization
where not(exists($org/established)) and contains($org/name, "Nuclear")
	and (
		for $orgCL in $org/members/@country
		return(
			for $orgC in tokenize($orgCL, "\s")
			return(
				for $cc in $root/country[encompassed/@continent = 'europe']/@car_code
				where $cc = $orgC
				return $cc
			)
		)
	)
return $org/name