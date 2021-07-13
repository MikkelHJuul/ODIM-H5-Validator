package odim_hdf5

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

#Software: string //it is too open

#System:           string // it is too open to reduce
#Transmitter:      "magnetron" | "klystron" | "solid state"
#PolarizationType: "single" | "simultaneous-dual" | "switched-dual"
#PolarizationMode: "LDR-H" | "single-H" | "LDR-V" | "single-V" | "simultaneous-dual" | "switched-dual"
