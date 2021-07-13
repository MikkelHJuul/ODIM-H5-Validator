package odim_hdf5

#_Root: {
	[name=#DatasetName]: #DatasetGroup
	what:                #TopWhat //it is unclear if any of the top-level what/where/how groups are required
	how:                 #How
	where:               #Where
}

vs: ["V20", "V21", "V22", "V23"]
#supportedVersions: or(vs)

#RootV23: {
	#_Root
	Conventions: "ODIM_H5/V2_3"
	what: version: "H5rad 2.3"
	[name=#DatasetName]: [name=#DataName]: what: quantity: #QuantityV23 //could this appear at other levels? quality: what: quantity??
}

#RootV22: {
	#_Root
	Conventions: "ODIM_H5/V2_2"
	what: version: "H5rad 2.2"
	[name=#DatasetName]: [name=#DataName]: what: quantity: #QuantityV22 //could this appear at other levels
}

#RootV21: {
	#_Root
	Conventions: "ODIM_H5/V2_1"
	what: version: "H5rad 2.1"
	[name=#DatasetName]: [name=#DataName]: what: quantity: #QuantityV21     //could this appear at other levels
	[name=#DatasetName]: how: azangles:  #sequenceOfPairs // should this be done more elaborately?
	[name=#DatasetName]: how: aztimes:   #sequenceOfPairs
}

#RootV20: {
	#_Root
	Conventions: "ODIM_H5/V2_0"
	what: version: "H5rad 2.0"
	[name=#DatasetName]: [name=#DataName]: what: quantity: #QuantityV20     //could this appear at other levels
	[name=#DatasetName]: how: azangles:  #sequenceOfPairs // should this be done more elaborately?
	[name=#DatasetName]: how: aztimes:   #sequenceOfPairs
}

#DatasetName: =~ "dataset[0-9]{1,3}" // 1000 are quite a lot, but hey, why not??
#DataName: =~ "data[0-9]{1,3}"
#QualityName: =~ "quality[0-9]{1,3}"

#Group: {
	what?:  #DatasetWhat //it is unclear if any of the top-level what/where/how groups are required
	how?:   #How
	where?: #Where
}

#DatasetGroup: {
	#Group
	[name=#DataName]:    #DataGroup
	[name=#QualityName]: #DataGroup
}

#DataGroup: {
	#Group

	[name=#QualityName]: #DataGroup //this allow for infinitely nested quality groups... YOLO
	data?:               #Data
	palette?:            _ // I have no idea what the structure is of this item
	legend?:             _ // I have no idea what the structure is of this item
}

#Data: close({
	CLASS:         "IMAGE"
	IMAGE_VERSION: "1.2"
})
