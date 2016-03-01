(:Give the name of the capitals of all the countries that border the Baltic Sea.:)

let $root := doc("mondial.xml")/mondial

for $sc in $root/sea[name = "Baltic Sea"]/located
let $country := $root/country[@car_code = $sc/@country]
return data($country/name)