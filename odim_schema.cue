import (
	"time"
	"list"
)

#_Root: {
	[name=#DatasetName]: #DatasetGroup
	what:                #TopWhat //it is unclear if any of the top-level what/where/how groups are required
	how:                 #How
	where:               #Where
}

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

#Date: string & time.Format("20060102")
#Time: string & time.Format("150405")

#TopWhat: {
	//mandatory Top-level what attributes: table 1
	object: #Objects
	date:   #Date
	time:   #Time
	source: string
	//TODO source validation via table 3??
}

#DatasetWhat: {
	product?:  #Product //- According to Table 15
	prodname?: string   //- Product name
	//TODO prodpar
	prodpar?:   string    // - According to Table 16 for products. Only used for cartesian products.
	startdate?: #Date     //Starting YYYYMMDD Year, Month, and Day for the product
	starttime?: #Time     //Hour, Minute, and Second for the product
	enddate?:   #Date     // Year, Month, and Day for the product
	endtime?:   #Time     // Hour, Minute, and Second for the product
	gain?:      float     //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 1.0.
	offset?:    float     //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 0.0.
	nodata?:    float     //- Raw value used to denote areas void of data (never radiated). Note that this Attribute is always a float even if the data in question is in another format.
	undetect?:  float     //- Raw value used to denote areas below the measurement detection threshold (radiated but nothing detected). Note that this Attribute is always a float even if the data in question is in another format.
}

#Where: #TopLevelPolarWhere | #SectorPolarWhere | #DatasetPolarWhere | #GeoImageWhere | #CrossSectionWhere | #VerticalWhere | #RHICrossSectionWhere

//table 4
#TopLevelPolarWhere: {
	lat:    float
	lon:    float
	height: float
}

//table 4
#SectorPolarWhere: {
	elangle: float      //Antenna elevation angle (degrees) above the horizon.
	elangle: >=0 & <=90 //everything else just doesnt make sense (90 doesn't really either)
	nbins:   int        //Number of range bins in each ray
	rstart:  float      //The range (km) of the start of the first range bin
	rscale:  float      //The distance in meters between two successive range bins
	nrays:   int        //Number of azimuth or elevation gates (rays) in the object
	a1gate:  int        //Index of the first azimuth gate radiated in the scan
}

//table 4
#DatasetPolarWhere: {
	startaz: float & >=0 & <=360 //The azimuth angle of the start of the first gate in the sector (degrees)
	stopaz:  float & >=0 & <=360 //The azimuth angle of the end of the last gate in the sector (degrees)
	startel: float & >=0 & <=360 //The elevation angle of the start of the first gate in the sector (degrees)
	stopel:  float & >=0 & <=360 //The elevation angle of the end of the last gate in the sector (degrees)
}

//TODO only the containing group of an image data type...??
//table 5
#GeoImageWhere: {
	projdef: string //The projection definition arguments, described above, which can be
	//used with PROJ.4. See the PROJ.4 documentation for usage.
	//Longitude/Latitude coordinates are normalized to the WGS-84 ellipsoid and
	//geodetic datum.
	xsize:  int & >0   //Number of pixels in the X dimension
	ysize:  int & >0   //Number of pixels in the Y dimension
	zsize:  int & >0   //Number of pixels in the Z dimension
	zstart: float      //Height in meters above mean sea level of the lowest pixel in the Z dimension
	xscale: float & >0 //Pizel size in the X dimension, in projection-specific coordinates (often meters)
	yscale: float & >0 //Pixel size in the Y dimension, in projection-specific coordinates (often meters)
	zscale: float & >0 //Pixel size in the Z dimension (meters)
	LL_lon: float      //Longitude of the lower left corner of the lower left pixel
	LL_lat: float      //Latitude of the lower left corner of the lower left pixel
	UL_lon: float      //Longitude of the upper left corner of the upper left pixel
	UL_lat: float      //Latitude of the upper left corner of the upper left pixel
	UR_lon: float      //Longitude of the upper right corner of the upper right pixel
	UR_lat: float      //Latitude of the upper right corner of the upper right pixel
	LR_lon: float      //Longitude of the lower right corner of the lower right pixel
	LR_lat: float      //Latitude of the lower right corner of the lower right pixel
}

#simpleArrayOfDoubles: string & =~"^(|-)[0-9]+(.[0-9]+)(,(|-)[0-9]+(.[0-9]+))*$" | float //also some sequences
#sequenceOfPairs:      string & =~"^(|-)[0-9]+(.[0-9]+):(|-)[0-9]+(.[0-9]+)(,(|-)[0-9]+(.[0-9]+):(|-)[0-9]+(.[0-9]+))*$"

//table 6
#CrossSectionWhere: {
	xsize:     int & >0   //Number of pixels in the horizontal dimension
	ysize:     int & >0   //Number of pixels in the vertical dimension
	xscale:    float & >0 //Horizontal resolution in m
	yscale:    float & >0 //Vertical resolution in m
	minheight: float      //Minimum height in meters above mean sea level
	maxheight: float      //Maximum height in meters above mean sea level
}

#RHICrossSectionWhere: {
	lon:      float //Longitude position of the radar antenna (degrees). Fractions of a degree are given in decimal notation.
	lat:      float //Latitude position of the radar antenna (degrees). Fractions of a degree are given in decimal notation.
	az_angle: float //Azimuth angle
	range:    float //Maximum range in km

	//Deprecation trigger allow not there
	//Marked for DEPRECATION.
	angles?: #simpleArrayOfDoubles //Elevation angles, in degrees, in the order of acquisition.
}

//table 7
#VerticalWhere: {
	#TopLevelPolarWhere

	//Height of the centre of the antenna in meters above mean sea level.
	interval:  float    //Vertical distance (m) between height intervals, or 0.0 if variable
	minheight: float    //Minimum height in meters above mean sea level
	maxheight: float    //Maximum height in meters above mean sea level
	levels:    int & >0 //Number of points in the profile
}

#sequence: string

//nodes are the radar names... the enum is too large, and not bounded, I will not contemplate it currently
#sequenceOfNodes: =~"[a-z]{5}(,[a-z]{5})*"

#Software: string //it is too open

#System:           string // it is too open to reduce
#Transmitter:      "magnetron" | "klystron" | "solid state"
#PolarizationType: "single" | "simultaneous-dual" | "switched-dual"
#PolarizationMode: "LDR-H" | "single-H" | "LDR-V" | "single-V" | "simultaneous-dual" | "switched-dual"

#How: {
	#DesirableCommonHow
	#DesirablePolarHow
	#DesirableQualityHow
	#RecommendedCommonHow
	#RecommendedIndividualHow
	#RecommendedPolarHow
	#RecommendedCartesianImageHow
	#RecommendedVerticalProfileHow
	#RecommendedQualityHow
}

#DesirableCommonHow: {
	beamwidth?:   float & >=0 & <=360 //The radar’s half-power beamwidth (degrees)
	beamwH?:      float & >=0 & <=360 //Horizontal half-power (-3 dB) beamwidth in degrees
	beamwV?:      float & >=0 & <=360 //Vertical half-power (-3 dB) beamwidth in degrees
	wavelength?:  float & >0          //Wavelength in cm
	RXbandwidth?: float & >0          //Bandwidth in MHz that the receiver is set to when operating the radar with the above mentioned pulsewidth
	RXlossH?:     float & >0          //Total loss in dB in the receiving chain for horizontally-polarized signals, defined as the losses that occur between the antenna reference point and the receiver, inclusive.
	RXlossV?:     float & >0          //Total loss in dB in the receiving chain for vertically-polarized signals, defined as the losses that occur between the antenna reference point and the receiver, inclusive.
	antgainH?:    float & >0          //Antenna gain in dB for horizontally-polarized signals
	antgainV?:    float & >0          //Antenna gain in dB for vertically-polarized signals
	radconstH?:   float & >0          //Radar constant in dB for the horizontal channel. For the precise definition, see Appendix A
	radconstV?:   float & >0          //Radar constant in dB for the vertical channel. For the precise definition, see Appendix A
	NI?:          float               //Unambiguous velocity (Nyquist) interval in ±m/s
}

#DesirablePolarHow: {
	scan_index?: uint                  //Which scan this is in the temporal sequence (starting with 1) of the total float of scans comprising the volume.
	scan_count?: uint                  //The total number of scans comprising the volume.
	astart?:     float                 //Azimuthal offset in degrees (◦) from 0◦ of the start of the first ray in the sweep. This value is positive where the gate starts clockwise after 0◦,and it will be negative if it starts before 0◦ . In either case, the value must be no larger than half a ray’s width.
	startazA?:   #simpleArrayOfDoubles //Azimuthal start angles (degrees) used for each gate in a scan. The float of values in this array corresponds with the value of where/nrays for that dataset.
	stopazA?:    #simpleArrayOfDoubles //Azimuthal stop angles (degrees) used for each gate in a scan. The float of values in this array corresponds with the value of where/nrays for that dataset.
}
#DesirableQualityHow: {
	NEZH?: float //The total system noise expressed as the horizontally-polarized reflectivity (dBZ) it would represent at one km distance from the radar.
	NEZV?: float //The total system noise expressed as the vertically-polarized reflectivity (dBZ) it would represent at one km distance from the radar.
	LOG?:  float //Security distance above mean noise level (dB) threshold value.
}
#RecommendedCommonHow: {
	extensions?:  string    //Name of the extensions of `/what/version`
	task?:        string    //Name of the acquisition task or product generator
	task_args?:   string    //Task arguments
	data_origin?: #sequence //If a quantity or quality field has been modified, the originating quantity or quality field together with the applied quantity or quality field(s) should be provided, e.g. [/datasetM/dataN, /datasetM/dataN/qualityP] or [DBZH, se.smhi.detector.beamblockage].
	//TODO rules regarding this time wrt. root levet time
	startepochs?: float //Seconds after a standard 1970 epoch for which the starting time of the data/product is valid. A compliment to “date” and “time” in Table 1, for those who prefer to calculate times directly in epoch seconds.
	//TODO rules regarding this time wrt. root levet time
	endepochs?:  float             //Seconds after a standard 1970 epoch for which the ending time of the data/product is valid. A compliment to “date” and “time” in Table 1, for those who prefer to calculate times directly in epoch seconds.
	system?:     #System           //According to Table 11
	TXtype?:     #Transmitter      //Transmitter type [magnetron; klystron; solid state]
	poltype?:    #PolarizationType //Polarization type of the radar [single; simultaneous-dual; switched-dual]
	polmode?:    #PolarizationMode //Current polarity mode [LDR-H; single-H; LDR-V; single-V; simultaneous-dual; switched-dual]
	software?:   #Software         //According to Table 12
	sw_version?: string            //Software version in string format, e.g. “5.1” or “8.11.6.2”
	//https://gist.github.com/jhorsman/62eeea161a13b80e39f5249281e17c39 << semver regex from here
	sw_version?: =~"^([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\\.[0-9A-Za-z-]+)*))?(?:\\+[0-9A-Za-z-]+)?$" //Software version in string format, e.g. “5.1” or “8.11.6.2”
	zr_a?:       float                                                                                               //Z-R constant a in Z = a Rb, applicable to any product containing reflectivity or precipitation data
	zr_b?:       float                                                                                               //Z-R exponent b in Z = a Rb, applicable to any product containing reflectivity or precipitation data
	zr_a_A?:     #simpleArrayOfDoubles                                                                               //Z-R constant a in Z = a Rb, applicable to any product containing reflectivity or precipitation data
	zr_b_A?:     #simpleArrayOfDoubles                                                                               //Z-R exponent b in Z = a Rb, applicable to any product containing reflectivity or precipitation data
	kr_a?:       float                                                                                               //Kdp-R constant a in R = a Kdp b
	kr_b?:       float                                                                                               //Kdp-R exponent b in R = a Kdp b
	kr_a_A?:     #simpleArrayOfDoubles                                                                               //Kdp-R constant a in R = a Kdp b
	kr_b_A?:     #simpleArrayOfDoubles                                                                               //Kdp-R exponent b in R = a Kdp b
	simulated?:  bool                                                                                                //“True” if data are simulated, otherwise “False”
}

//TODO bounds
#RecommendedIndividualHow: {
	//Marked for DEPRECATION.
	rpm?: float //The antenna speed in revolutions per minute, positive for clockwise scanning, negative for counter-clockwise scanning. 
	//Marked for DEPRECATION.
	elevspeed?:   float                 //Antenna elevation speed (RHI mode) in degrees/s, positive values ascending, negative values descending. 
	antspeed?:    float                 //Antenna speed in degrees/s (positive for clockwise and ascending, negative for counter-clockwise and descending)
	pulsewidth?:  float                 //Pulsewidth in µs
	lowprf?:      float                 //Low pulse repetition frequency in Hz
	midprf?:      float                 //Intermediate pulse repetition frequency in Hz
	highprf?:     float                 //High pulse repetition frequency in Hz
	TXlossH?:     float                 //Total loss in dB in the transmission chain for horizontallypolarized signals, defined as the losses that occur between the calibration reference plane and the feed horn, inclusive.
	TXlossV?:     float                 //Total loss in dB in the transmission chain for verticallypolarized signals, defined as the losses that occur between the calibration reference plane and the feed horn, inclusive.
	injectlossH?: float                 //Total loss in dB between the calibration reference plane and the test signal generator for horizontally-polarized signals.
	injectlossV?: float                 //Total loss in dB between the calibration reference plane and the test signal generator for vertically-polarized signals.
	radomelossH?: float                 //One-way dry radome loss in dB for horizontally-polarized signals
	radomelossV?: float                 //One-way dry radome loss in dB for vertically-polarized signals
	gasattn?:     float                 //Gaseous specific attenuation in dB/km assumed by the radar processor (zero if no gaseous attenuation is assumed)
	nomTXpower?:  float                 //Nominal transmitted peak power in kW at the output of the transmitter (magnetron/klystron output flange)
	TXpower?:     #simpleArrayOfDoubles //Transmitted peak power in kW at the calibration reference plane. The values given are average powers over all transmitted pulses in each azimuth gate. The float of values in this array corresponds with the value of where/nrays for that dataset.
	powerdiff?:   float                 //Power difference between transmitted horizontally and vertically-polarized signals in dB at the the feed horn.
	phasediff?:   float                 //Phase difference in degrees between transmitted horizontally and vertically-polarized signals as determined from the first valid range bins
	Vsamples?:    int                   //Number of samples used for radial velocity measurements
}

#RecommendedPolarHow: {
	scan_optimized?: string  //Scan optimized for quantity [DBZH; VRADH; etc.]
	azmethod?:       #Method //How raw data in azimuth are processed to arrive at the given value, according to Table 13
	elmethod?:       #Method //How raw data in elevation are processed to arrive at the given value, according to Table 13
	binmethod?:      #Method //How raw data in range are processed to arrive at the given value, according to Table 13
	binmethod_avg?:  uint    //How many original data elements in range are averaged to arrive at the given value.
	//Marked for DEPRECATION.
	elangles?: #simpleArrayOfDoubles //Elevation angles (degrees above the horizon) used for each azimuth gate in an “intelligent” scan that e.g. follows the horizon. The float of values in this array corresponds with the value of where/nrays for that dataset.
	//Marked for DEPRECATION.
	startazT?: #simpleArrayOfDoubles //Acquisition start times for each azimuth gate in the sector or scan, in seconds past the 1970 epoch. The float of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond.
	//Marked for DEPRECATION.
	stopazT?:  #simpleArrayOfDoubles //Acquisition stop times for each azimuth gate in the sector or scan, in seconds past the 1970 epoch. The float of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond.
	startelA?: #simpleArrayOfDoubles //Elevational start angles (degrees) used for each gate in a scan. The float of values in this array corresponds with the value of where/nrays for that dataset.
	stopelA?:  #simpleArrayOfDoubles //Elevational stop angles (degrees) used for each gate in a scan. The float of values in this array corresponds with the value of where/nrays for that dataset.
	//Marked for DEPRECATION.
	startelT?: #simpleArrayOfDoubles //Acquisition start times for each elevation gate in the sector or scan, in seconds past the 1970 epoch. The float of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond.
	//Marked for DEPRECATION.
	stopelT?: #simpleArrayOfDoubles //Acquisition stop times for each elevation gate in the sector or scan, in seconds past the 1970 epoch. The float of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond.
	startT?:  #simpleArrayOfDoubles //Acquisition start times for each gate in the sector or scan, in seconds past the 1970 epoch. The float of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond.
	stopT?:   #simpleArrayOfDoubles //Acquisition stop times for each gate in the sector or scan, in seconds past the 1970 epoch. The float of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond.
}
#RecommendedCartesianImageHow: {
	top_heights?:    #simpleArrayOfDoubles //Layer top heights (meter) above mean sea level
	bottom_heights?: #simpleArrayOfDoubles //Layer bottom heights (meter) above mean sea level
	angles?:         #simpleArrayOfDoubles //Elevation angles in the order in which they were acquired, used to generate the product
	arotation?:      #simpleArrayOfDoubles //Antenna rotation speed in degrees/s (positive for clockwise, negative for counter-clockwise). The float of values in this array corresponds with the values of how/angles described above.
	camethod?:       string                //How cartesian data are processed, according to Table 13
	nodes?:          #sequenceOfNodes      //Radar nodes (Table 10) which have contributed data to the composite, e.g. “’searl’, ’noosl’, ’sease’, ’fikor”’
	ACCnum?:         uint                  //Number of images used in precipitation accumulation
}
#RecommendedVerticalProfileHow: {
	minrange?:    float                 //Minimum range at which data is used when generating profile (km)
	maxrange?:    float                 //Maximum range at which data is used when generating profile (km)
	sample_size?: #simpleArrayOfDoubles //Number of valid data points in a level of a vertical profile. The float of values in this array corresponds with the value of where/levels for that dataset. dealiased boolean “True” if data has been dealiased, “False” if not
}
#RecommendedQualityHow: {
	pointaccEL?:   float      //Antenna pointing accuracy in elevation (degrees). Possible pointing errors in elevation include e.g. tilt of turning level of the head (tilt of pedestal), non-linearities in gears, backlash in gearboxes, and uncertainties in angle adjustment e.g. using the sun.
	pointaccAZ?:   float      //Antenna pointing accuracy in azimuth (degrees). Possible pointing errors in azimuth include e.g. non-linearities in gears, backlash in gearboxes, and uncertainties in angle adjustment e.g. using the sun.
	anglesync?:    #anglesync //Antenna angle synchronization mode [azimuth; elevation]
	anglesyncRes?: float      //Resolution of angle synchronization in degrees
	malfunc?:      bool       //Radar malfunction indicator. If a quantity should not be used for any application due to radar hardware and/or software failure, how/malfunc should be “True”, otherwise “False”.
	radar_msg?:    string     //Radar malfunction message
	radhoriz?:     float      //Radar horizon (maximum range in km)
	OUR?:          float      //Overall uptime reliability (%)
	Dclutter?:     #sequence  //Doppler clutter filters used when collecting data
	clutterType?:  string     //Description of clutter filter used in the signal processor
	clutterMap?:   string     //Filename of clutter map
	zcalH?:        float      //Calibration offset in dB for the horizontal channel
	zcalV?:        float      //Calibration offset in dB for the vertical channel
	zdrcal?:       float      //ZDR calibration offset in dB
	nsampleH?:     float      //Noise sample in dB for the horizontal channel
	nsampleV?:     float      //Noise sample in dB for the vertical channel
	comment?:      string     //Free text description. Anecdotal quality information
	SQI?:          float      //Signal Quality Index threshold value
	CSR?:          float      //Clutter-to-signal ratio threshold value
	VPRCorr?:      bool       //“True” if vertical reflectivity profile correction has been applied, otherwise “False”
	//Marked for DEPRECATION.
	freeze?:               float                 //Freezing level (km) above sea level. 
	melting_layer_top?:    #simpleArrayOfDoubles //Melting layer top level (km) above mean sea level
	melting_layer_bottom?: #simpleArrayOfDoubles //Melting layer bottom level (km) above mean sea level
	min?:                  float                 //Minimum value for continuous quality data
	max?:                  float                 //Maximum value for continuous quality data
	step?:                 float                 //Step value for continuous quality data
	levels?:               uint                  //Number of levels in discrete data legend
	levels?:               uint                  //Number of levels in discrete data legend
	peakpwr?:              float                 //Peak power (kW)
	avgpwr?:               float                 //Average power (W)
	dynrange?:             float                 //Dynamic range (dB)
	RAC?:                  float                 //Range attenuation correction (dBm)
	BBC?:                  bool                  //“True” if bright-band correction applied, otherwise “False”
	PAC?:                  float                 //Precipitation attenuation correction (dBm)
	//Marked for DEPRECATION.
	S2N?:            float  //Signal-to-noise ratio (dB) threshold value. 
	SNRT?:           float  //Signal-to-noise ratio (dB) threshold
	SNRHCT?:         float  //Signal-to-noise ratio (dB) co-polar H threshold
	SNRHXT?:         float  //Signal-to-noise ratio (dB) cross-polar H threshold
	SNRVCT?:         float  //Signal-to-noise ratio (dB) co-polar V threshold
	SNRVXT?:         float  //Signal to noise ratio (dB) cross polar V threshold
	polarization?:   string //Type of polarization (H, V) transmitted by the radar
	MDS?:            float  //Minimum detectable signal (dBZ) at one km distance from the radar
	smoothed_PHIDP?: bool   //“True” if PHIDP or UPHIDP has been smoothed, “False” if not
}

#anglesync: "azimuth" | "elevation"

#Method: {
	"NEAREST"//Nearest neighbour or closest radar
} | {
	"INTERPOL"//Interpolation
} | {
	"AVERAGE"//Average of all values
} | {
	"QAVERAGE"//Quality-weighted average //TODO only V2.3
} | {
	"RANDOM"//Random
} | {
	"MDE"//Minimum distance to earth
} | {
	"LATEST"//Most recent radar
} | {
	"MAXIMUM"//Maximum value
} | {
	"QMAXIMUM"//Maximum quality //TODO only V2.3
} | {
	"DOMAIN"//User-defined compositing
} | {
	"VAD"//Velocity azimuth display
} | {
	"VVP"//Volume velocity processing
} | {
	"RGA"//Gauge-adjustment
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

#supportedVersions: "V20" | "V21" | "V22" | "V23"

#Quantity: close({
	name:        string
	description: string
	versions: [...#supportedVersions]
})

#Quantities: [...#Quantity]

#Quantities: [
	#Quantity & {
		name:        "SQI"
		description: "Signal quality index"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "dbz"
		description: "[dBZ] Logged radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "dbz_dev"
		description: "[dBZ] Variability of logged radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "z"
		description: "[Z] Linear radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "z_dev"
		description: "[Z] Variability of linear radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "chi2"
		description: "Chi-square value of wind profile fit"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "rhohv"
		description: "ρhv [0-1] Correlation between Zh and Zv"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "VRAD"
		description: "[m/s] Radial velocity"
		versions: ["V20", "V21", "V22"]
	},
	#Quantity & {
		name:        "WRAD"
		description: "[m/s] Spectral width of radial velocity"
		versions: ["V20", "V21", "V22"]
	},
	#Quantity & {
		name:        "ZDR"
		description: "ZDR [dB] Logged differential reflectivity"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "RHOHV"
		description: "ρhv [0-1] Correlation between Zh and Zv"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "LDR"
		description: "Ldr [dB] Linear depolarization ratio"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "PHIDP"
		description: "φdp [degrees] Differential phase"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "KDP"
		description: "Kdp [degrees/km] Specific differential phase"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "RATE"
		description: "RR [mm/h] Rain rate"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "ACRR"
		description: "RRaccum. [mm] Accumulated precipitation"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "HGHT"
		description: "H [km] Height above mean sea level"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "VIL"
		description: "VIL [kg/m2] Vertical Integrated Liquid water"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "UWND"
		description: "U [m/s] Component of wind in x-direction"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "VWND"
		description: "V [m/s] Component of wind in y-direction"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "w"
		description: "[m/s] Vertical velocity (positive upwards)"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "w_dev"
		description: "[m/s] Vertical velocity variability"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "div"
		description: "[s−1] Divergence"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "div_dev"
		description: "[s−1] Divergence variation"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "def"
		description: "[s−1] Deformation"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "def_dev"
		description: "[s−1] Deformation variation"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "ad"
		description: "[degrees] Axis of dialation (0-360)"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "ad_dev"
		description: "[degrees] Variability of axis of dialation (0-360)"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "rhohv_dev"
		description: "ρhv [0-1] ρhv variation"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "QIND"
		description: "Quality [0-1] Spatially analyzed quality indicator, according to OPERA II, normalized to between 0 (poorest quality) to 1 (best quality)"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "CLASS"
		description: "Classification Indicates that data are classified and that the classes are specified according to the associated legend object (Section 6.2) whichmust be present."
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "ff"
		description: "[m/s] Mean horizontal wind velocity"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "dd"
		description: "[degrees] Mean horizontal wind direction (degrees)"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "ff_dev"
		description: "[m/s] Velocity variability"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "dd_dev"
		description: "[m/s] Direction variability"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "n"
		description: "– Sample size. Marked for DEPRECATION."
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "BRDR"
		description: "0 or 1 1 denotes a border where data from two or more radars meet incomposites, otherwise 0"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "DBZH"
		description: "Zh [dBZ] Logged horizontally-polarized (corrected) reflectivity factor"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "DBZV"
		description: "Zv [dBZ] Logged vertically-polarized (corrected) reflectivity factor"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "TH"
		description: "Th [dBZ] Logged horizontally-polarized total (uncorrected) reflectivity factor"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "TV"
		description: "Tv [dBZ] Logged vertically-polarized total (uncorrected) reflectivity factor"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "SNR"
		description: "SNR [dB] Signal-to-noise ratio"
		versions: ["V20", "V21", "V22", "V23"]
	},
	#Quantity & {
		name:        "SQIH"
		description: "SQIh [0-1] Signal quality index - horizontally-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "USQIH"
		description: "SQIh [0-1] Signal quality index - horizontally-polarized - that has not been subject to a Doppler filter"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SQIV"
		description: "SQIv [0-1] Signal quality index - vertically-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "USQIV"
		description: "SQIv [0-1] Signal quality index - vertically-polarized - that has not been subject to a Doppler filter"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRH"
		description: "SNRh [0-1] Normalized signal-to-noise ratio - horizontally-polarized. Marked for DEPRECATION."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "SNRV"
		description: "SNRv [0-1] Normalized signal-to-noise ratio - vertically-polarized. Marked for DEPRECATION."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "SNRHC"
		description: "SNRh,c [dB] Signal-to-noise ratio co-polar H"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRHX"
		description: "SNRh,x [dB] Signal-to-noise ratio cross-polar H"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRVC"
		description: "SNRv,c [dB] Signal-to-noise ratio co-polar V"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRVX"
		description: "SNRv,x [dB] Signal to noise ratio cross polar V"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "CCORH"
		description: "CCh [dB] Clutter correction - horizontally-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "CCORV"
		description: "CCv [dB] Clutter correction - vertically-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "VRADH"
		description: "Vrad,h [m/s] Radial velocity - horizontally-polarized. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UVRADH"
		description: "Vrad,h [m/s] Radial velocity - horizontally-polarized - that has not been subject to any filter or correction. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V23"]
	},
	#Quantity & {
		name:        "VRADV"
		description: "Vrad,v [m/s] Radial velocity - vertically-polarized. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UVRADV"
		description: "Vrad,v [m/s] Radial velocity - vertically-polarized - that has not been subject to any filter or correction. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V23"]
	},
	#Quantity & {
		name:        "VRADDH"
		description: "Vrad,d [m/s] Dealiased horizontally-polarized radial velocity"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "VRADDV"
		description: "Vrad,d [m/s] Dealiased vertically-polarized radial velocity"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "WRADH"
		description: "Wrad,h [m/s] Spectral width of radial velocity - horizontally-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UWRADH"
		description: "Wrad,h [m/s] Spectral width of radial velocity - horizontally-polarized - that has not been subject to any filter or correction"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "WRADV"
		description: "Wrad,v [m/s] Spectral width of radial velocity - vertically-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UWRADV"
		description: "Wrad,v [m/s] Spectral width of radial velocity - vertically-polarized - that has not been subject to any filter or correction"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "PSPH"
		description: "PSP [dBm] Power spectrum peak - horizontally-polarized"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "PSPV"
		description: "PSP [dBm] Power spectrum peak - vertically-polarized"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "UPSPH"
		description: "PSP [dBm] Power spectrum peak - horizontally-polarized - that has not been subject to any filter or correction"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "UPSPV"
		description: "PSP [dBm] Power spectrum peak - vertically-polarized - that has not been subject to any filter or correction"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "DBZH_dev"
		description: "[dBZ] Variability of logged horizontally-polarized (corrected) reflectivity factor"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "DBZV_dev"
		description: "[dBZ] Variability of logged vertically-polarized (corrected) reflectivity factor"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UZDR"
		description: "ZDR [dB] Logged differential reflectivity that has not been subject to a Doppler filter"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "URHOHV"
		description: "ρhv [0-1] Correlation between Zh and Zv that has not been subject to any filter or correction"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "ULDR"
		description: "Ldr [dB] Linear depolarization ratio that has not been subject to a Doppler filter"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "UPHIDP"
		description: "φdp [degrees] Differential phase that has not been subject to any filter or correction"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "PIA"
		description: "PIA [dB] Path Integrated Attenuation"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "UKDP"
		description: "Kdp [degrees/km] Specific differential phase that has not been subject to any filter or correction"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "CPA"
		description: "CPA [0-1] Clutter phase alignment (0: low probability of clutter, 1: high probability of clutter)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "URATE"
		description: "URR [mm/h] Uncorrected rain rate"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "POR"
		description: "POR [0-1] Probability of rain (0: low probability, 1: high probability)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "HI"
		description: "HI [dBZ] Hail intensity"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "HP"
		description: "HP [%] Hail probability. Marked for DEPRECATION."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "POH"
		description: "POH [0-1] Probability of hail (0: low probability, 1: high probability)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "POSH"
		description: "POSH [0-1] Probability of severe hail (0: low probability, 1: high probability)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "MESH"
		description: "MESH [cm] Maximum expected severe hail size"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "RSHR"
		description: "SHRr [m/s km] Radial shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "ASHR"
		description: "SHRa [m/s km] Azimuthal shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "CSHR"
		description: "SHRc [m/s km] Range-azimuthal shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "ESHR"
		description: "SHRe [m/s km] Elevation shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "OSHR"
		description: "SHRo [m/s km] Range-elevation shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "HSHR"
		description: "SHRh [m/s km] Horizontal shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "VSHR"
		description: "SHRv [m/s km] Vertical shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "TSHR"
		description: "SHRt [m/s km] Three-dimensional shear"
		versions: ["V22", "V23"]
	},
]

#QuantityV20: or([ for q in #Quantities if list.Contains(q.versions, "V20") {q.name}])
#QuantityV21: or([ for q in #Quantities if list.Contains(q.versions, "V21") {q.name}])
#QuantityV22: or([ for q in #Quantities if list.Contains(q.versions, "V22") {q.name}])
#QuantityV23: or([ for q in #Quantities if list.Contains(q.versions, "V23") {q.name}])
