package odim_hdf5

import "list"

#DatasetName: =~"dataset[0-9]+"
#DataName:    =~"data[0-9]+"
#QualityName: =~"quality[0-9]+"

#Group: {
	what?: #DataWhat
}

#DatasetGroup: {
	#Group
	[name=#DataName]:    #DataGroup
	[name=#QualityName]: #QualityGroup
}

#DataGroup: {
	#QualityGroup
	[name=#QualityName]: #QualityGroup
}

#QualityGroup: {
	#Group
	data?:    #Data
	palette?: _ // I have no idea what the structure is of this item
	legend?:  _ // I have no idea what the structure is of this item
}

#Root: {
	[name=#DatasetName]: #DatasetGroup
	what: {
		date: #Date
		time: #Time
	}
}

#VersionItems: close({
	Conventions: string
	what: version: string
})

versionTexts: [name=supportedVersions]: #VersionItems

versionTexts: {
	"V2_4": #VersionItems & {
		Conventions: "ODIM_H5/V2_4"
		what: version: "H5rad 2.4"
	}
	"V2_3": #VersionItems & {
		Conventions: "ODIM_H5/V2_3"
		what: version: "H5rad 2.3"
	}
	"V2_2": #VersionItems & {
		Conventions: "ODIM_H5/V2_2"
		what: version: "H5rad 2.2"
	}
	"V2_1": #VersionItems & {
		Conventions: "ODIM_H5/V2_1"
		what: version: "H5rad 2.1"
	}
	"V2_0": #VersionItems & {
		Conventions: "ODIM_H5/V2_0"
		what: version: "H5rad 2.0"
	}
}
v: *vs[len(vs)-1] | string @tag(version)

quant: or([ for q in quantities if list.Contains(q.versions, v) {q.name}])

prod: or([ for p in product if list.Contains(p.versions, v) {p.name}])

whereGroups: {
	for w in whereObjects if list.Contains(w.versions, v) {
		for l in w.locations {
			"\(l)": {
				for g in w.groups {
					"\(g)": {
						w.keys
					}
				}
			}
		}
	}
}

mixedPol: *false | bool @tag(mixed_polarization)

#VersionDataWhat: #DataWhat & {
	quantity?: quant
	product?:  prod
}
root: {
	versionTexts[v]
	#Root
	what: {
		source: =~whatSourceRegex
		object: or([ for o in objects if list.Contains(o.versions, v) {o.name}])
	}
	if mixedPol {
		#how: close({for h in Hows if list.Contains(h.versions, v) {h.keys}})
	}
	if !mixedPol {
		#how: close({for h in Hows if list.Contains(h.versions, v) && list.Contains(h.groups, "h") {h.keys}}) | //horizontal or vertical hows!
			close({for h in Hows if list.Contains(h.versions, v) && list.Contains(h.groups, "v") {h.keys}})
	}
	how?: #how
	[name=#DatasetName]: how?: #how
	[name=#DatasetName]: [name=#DataName]: how?:    #how
	[name=#DatasetName]: [name=#QualityName]: how?: #how

	where?: topWhere
	[name=#DatasetName]: where?: datasetWhere
	[name=#DatasetName]: [name=#DataName]: where?:    dataWhere
	[name=#DatasetName]: [name=#QualityName]: where?: dataWhere

	[name=#DatasetName]: what?: #VersionDataWhat
	[name=#DatasetName]: [name=#DataName]: what?:    #VersionDataWhat
	[name=#DatasetName]: [name=#QualityName]: what?: #VersionDataWhat
	[name=#DatasetName]: [name=#DataName]: [name=#QualityName]: what?: #VersionDataWhat
}
