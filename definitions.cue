package odim_hdf5

import "list"

#DatasetName: =~"dataset[0-9]+"
#DataName:    =~"data[0-9]+"
#QualityName: =~"quality[0-9]+"

#Group: {
	what?: #What
	how?: #How
}

#DatasetGroup: {
	#Group
	[Name=#DataName]:    #DataGroup
	[Name=#QualityName]: #QualityGroup
	where?: #DatasetWhere
}

#DataGroup: {
	#QualityGroup
	[Name=#QualityName]: #QualityGroup
}

#QualityGroup: {
	#Group
where?: #DataWhere
	data?:    #Data
	palette?: _ // I have no idea what the structure is of this item
	legend?:  _ // I have no idea what the structure is of this item
}

#quant: or([ for q in _quantities if list.Contains(q.versions, _v) {q.name}])

#prod: or([ for p in _products if list.Contains(p.versions, _v) {p.name}])

#What: {
	product?:   #prod //- According to Table 15
	prodname?:  string //- Product name
	quantity?:  #quant
	prodpar?:   string  // - According to Table 16 for products. Only used for cartesian products.
	startdate?: #Date   //Starting YYYYMMDD Year, Month, and Day for the product
	starttime?: #Time   //Hour, Minute, and Second for the product
	enddate?:   #Date   // Year, Month, and Day for the product
	endtime?:   #Time   // Hour, Minute, and Second for the product
	gain?:      float64 //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 1.0.
	offset?:    float64 //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 0.0.
	nodata?:    float64 //- Raw value used to denote areas void of data (never radiated). Note that this Attribute is always a float64 even if the data in question is in another format.
	undetect?:  float64 //- Raw value used to denote areas below the measurement detection threshold (radiated but nothing detected). Note that this Attribute is always a float64 even if the data in question is in another format.
}

_mixedPol: bool | *false  @tag(mixed_polarization, type=bool)

#How: {
		if _mixedPol {
			close({for h in _hows if list.Contains(h.versions, _v) {h.keys}})
		}
		if !_mixedPol {
			 close({for h in _hows if list.Contains(h.versions, _v) && list.Contains(h.groups, "h") {h.keys}}) | //horizontal or vertical hows!
				close({for h in _hows if list.Contains(h.versions, _v) && list.Contains(h.groups, "v") {h.keys}})
		}
}
