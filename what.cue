package odim_hdf5

#TopWhat: {
	//mandatory Top-level what attributes: table 1
	object: #Objects
	date:   #Date
	time:   #Time
	//source and version added at Roots
}

//?? generate ??
#SourceV20: =~"^(WMO|RAD|ORG|PLC|CTY|CMT):([^,]+)(,(WMO|RAD|ORG|PLC|CTY|CMT):([^,]+))*$"
#SourceV21: =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+))*$"
#SourceV22: =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+))*$"
#SourceV23: =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+))*$"

#DatasetWhat: {
	product?:  #Product //- According to Table 15
	prodname?: string   //- Product name
	//TODO prodpar
	prodpar?:   string // - According to Table 16 for products. Only used for cartesian products.
	startdate?: #Date  //Starting YYYYMMDD Year, Month, and Day for the product
	starttime?: #Time  //Hour, Minute, and Second for the product
	enddate?:   #Date  // Year, Month, and Day for the product
	endtime?:   #Time  // Hour, Minute, and Second for the product
	gain?:      float  //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 1.0.
	offset?:    float  //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 0.0.
	nodata?:    float  //- Raw value used to denote areas void of data (never radiated). Note that this Attribute is always a float even if the data in question is in another format.
	undetect?:  float  //- Raw value used to denote areas below the measurement detection threshold (radiated but nothing detected). Note that this Attribute is always a float even if the data in question is in another format.
}

//Table 2
#Objects: {
	"PVOL"//Polar volume
} | {
	"CVOL"//Cartesian volume
} | {
	"SCAN"//Polar scan
} | {
	"RAY"//Single polar ray
} | {
	"AZIM"//Azimuthal object
} | {
	"ELEV"//Elevational object //TODO from v2.2
} | {
	"IMAGE"//2-D cartesian image
} | {
	"COMP"//Cartesian composite image(s)
} | {
	"XSEC"//2-D vertical cross section(s)
} | {
	"VP"//1-D vertical profile
} | {
	"PIC"//Embedded graphical image
}

#Product: {
	"SCAN"//A scan of polar data
} | {
	"PPI"//Plan position indicator (cartesian)
} | {
	"CAPPI"//Constant altitude PPI
} | {
	"PCAPPI"//Pseudo-CAPPI
} | {
	"ETOP"//Echo top
} | {
	"EBASE"//Echo base
} | {
	"MAX"//Maximum
} | {
	"RR"//Accumulation
} | {
	"VIL"//Vertically integrated liquid water
} | {
	"SURF"//Information valid at the Earth’s surface
} | {
	"COMP"//Composite
} | {
	"VP"//Vertical profile
} | {
	"RHI"//Range height indicator
} | {
	"XSEC"//Arbitrary vertical slice
} | {
	"VSP"//Vertical side panel
} | {
	"HSP"//Horizontal side panel
} | {
	"RAY"//Ray
} | {
	"AZIM"//Azimuthal type product
} | {
	"QUAL"//Quality metric
}
