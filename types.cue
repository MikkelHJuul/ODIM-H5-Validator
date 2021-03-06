package odim_hdf5

import (
	"time"
)

#Date: string & time.Format("20060102")
#Time: string & time.Format("150405")

#simpleArrayOfDoubles: string & =~"^(|-)[0-9]+(.[0-9]+)(,(|-)[0-9]+(.[0-9]+))*$" | float64 //also some sequences
#simpleArrayOfUInts:   uint | string & =~"^[0-9]+(,[0-9]+)*$"
#sequenceOfPairs:      string & =~"^(|-)[0-9]+(.[0-9]+):(|-)[0-9]+(.[0-9]+)(,(|-)[0-9]+(.[0-9]+):(|-)[0-9]+(.[0-9]+))*$"

#sequence: string

//nodes are the radar names... the enum is too large, and not bounded, I will not contemplate it currently
#sequenceOfNodes: =~"[a-z]{5}(,[a-z]{5})*"

//this is a bit special, but it's so static that it is deemed fine to keep here
#Data: {
	CLASS:         "IMAGE"
	IMAGE_VERSION: "1.2"
}

#ODIMBool: "True" | "False"

//meta-types start here

//for generating e.g. enum-sets via the "name" attribute
//note, the description is added purely as metadata, I do not expect to ever use it.
//use something like:
//   //someV2_0Enum: or([for e in #SomeEnum if list.Contains(e.versions, "V2_0") { e.name } ])
//example in [quantity](quantity.cue)
#VersionEnum: {
	name:         string
	description?: string
	versions:     [...#supportedVersions] | *_vs
}

_locs: ["top", "dataset", "data"] //quality?
#allowedLocations:                or(_locs)

//for generating object-sets via versions, just like #VersionEnum however for objects:
//usage is pretty much the same, but has the extra added benefit of being able to filter on tags as well:
//  //#someDatasetObjectV2_2: { // < this is a validation object containing "V2_2" and "dataset" objects from the list #SomeObjectList
//  //  for o in #SomeObjectList if list.Contains(o.versions, "V2_2") & list.Contains(o.location, "dataset") {
//  //    o.keys
//  //  }
//  //}
// this structure holds the logic to construct the validation object structure of a versioned root object holding grouped OR-structures
// the keys itself could hold all the data of the group, but splitting this makes the data structure more dynamic and less painful on removal/changes.
#VersionObject: {
	keys:         _
	description?: string
	versions:     [...#supportedVersions] | *_vs
	deprecated?: [...#supportedVersions] //currently unused
	locations:                           [...#allowedLocations] | *_locs
	groups: [...string]
}
