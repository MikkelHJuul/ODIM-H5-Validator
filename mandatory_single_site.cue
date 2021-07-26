singleSite: *false | bool @tag(single_site)

#SingleSourceObject: #HowVersionObject & {
	versions: from["V2_4"]
}
if singleSite {

	// Nyquist Interval can be omitted if no radial velocity data are available ie. not included as mandatory!
	Hows: [
		#SingleSourceObject & {
			keys: simulated: ODIMBool
		},
		#SingleSourceObject & {
			keys: wavelength: float64 & >0
		},
		#SingleSourceObject & {
			keys: frequency: float64 & >0
		},
		#SingleSourceObject & {
			keys: pulsewidth: float64
		},
		#SingleSourceObject & {
			keys: RXlossH: float64 & >0
			groups: ["h"]
		},
		#SingleSourceObject & {
			keys: RXlossV: float64 & >0
			groups: ["v"]
		},
		#SingleSourceObject & {
			keys: antgainH: float64 & >0
			groups: ["h"]
		},
		#SingleSourceObject & {
			keys: antgainV: float64 & >0
			groups: ["v"]
		},
		#SingleSourceObject & {
			keys: beamwH: float64 & >=0 & <=360
			groups: ["h"]
		},
		#SingleSourceObject & {
			keys: beamwV: float64 & >=0 & <=360
			groups: ["v"]
		},
		#SingleSourceObject & {
			keys: radconstH: float64 & >0
			groups: ["h"]
		},
		#SingleSourceObject & {
			keys: radconstV: float64 & >0
			groups: ["v"]
		},
		#SingleSourceObject & {
			keys: startazA: simpleArrayOfDoubles
		},
		#SingleSourceObject & {
			keys: stopazA: simpleArrayOfDoubles
		},
		#SingleSourceObject & {
			keys: scan_index: uint
		},
		#SingleSourceObject & {
			keys: scan_count: uint
		},
	]
	root: what: source: =~".*NOD.*" //MUST contain NOD!
}
