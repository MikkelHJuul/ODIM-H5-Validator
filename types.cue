package odim_hdf5

import "time"

#Date: string & time.Format("20060102")
#Time: string & time.Format("150405")

#simpleArrayOfDoubles: string & =~"^(|-)[0-9]+(.[0-9]+)(,(|-)[0-9]+(.[0-9]+))*$" | float //also some sequences
#sequenceOfPairs:      string & =~"^(|-)[0-9]+(.[0-9]+):(|-)[0-9]+(.[0-9]+)(,(|-)[0-9]+(.[0-9]+):(|-)[0-9]+(.[0-9]+))*$"

#sequence: string

//nodes are the radar names... the enum is too large, and not bounded, I will not contemplate it currently
#sequenceOfNodes: =~"[a-z]{5}(,[a-z]{5})*"

