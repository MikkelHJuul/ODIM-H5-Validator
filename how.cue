package odim_hdf5

import "list"

#polarizations: "unset" | "mixed" | "h" | "v" | "horizontal" | "vertical"
_polarization: *"unset" | #polarizations @tag(polarization)

#How: {
	if _polarization == "mixed" {
		close({for h in _hows if list.Contains(h.versions, _v) {h.keys}})
	}
	if _polarization == "unset" {
		close({for h in _hows if list.Contains(h.versions, _v) && list.Contains(h.groups, "h") {h.keys}}) | //horizontal or vertical hows!
		close({for h in _hows if list.Contains(h.versions, _v) && list.Contains(h.groups, "v") {h.keys}})
	}
		if _polarization == "h" || _polarization == "horizontal" {
		close({for h in _hows if list.Contains(h.versions, _v) && list.Contains(h.groups, "h") {h.keys}})
	}
		if _polarization == "v" || _polarization == "vertical"  {
		close({for h in _hows if list.Contains(h.versions, _v) && list.Contains(h.groups, "v") {h.keys}})
	}
}


_howGroups: ["h", "v"]
#allowedHowGroups: or(_howGroups)
#HowVersionObject: #VersionObject & {
	groups: *_howGroups | [...#allowedHowGroups]
}

#method: or([ for m in _methods if list.Contains(m.versions, _v) {m.name}])

_singleSite: bool | *false @tag(single_site, type=bool)

#SingleSiteObject: #HowVersionObject & {
	versions: _from["V2_4"]
}

_hows: [...#HowVersionObject]
_hows: [
	#HowVersionObject & {
		keys: task?: string
		description: "Name of the acquisition task or product generator"
	},
	#HowVersionObject & {
		keys: task_args?: string
		description: "Task arguments"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: beamwidth?: float64 & >=0 & <=360
		description: "The radar’s half-power beamwidth (degrees)"
		versions: ["V2_0", "V2_1", "V2_2", "V2_3", "V2_4"]
		deprecated: ["V2_4"]
	},
	#HowVersionObject & {
		keys: beamwH?: float64 & >=0 & <=360
		description: "Horizontal half-power (-3 dB) beamwidth in degrees"
		versions:    _from["V2_1"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: beamwV?: float64 & >=0 & <=360
		description: "Vertical half-power (-3 dB) beamwidth in degrees"
		versions:    _from["V2_1"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: wavelength?: float64 & >0
		description: "Wavelength in cm"
		versions: ["V2_0", "V2_1", "V2_2", "V2_3", "V2_4"]
		deprecated: ["V2_4"]
	},
	#HowVersionObject & {
		keys: RXbandwidth?: float64 & >0
		description: "Bandwidth in MHz that the receiver is set to when operating the radar with the above mentioned pulsewidth"
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: RXloss?: float64 & >0
		description: "Total loss in dB in the receiving chain, defined as the losses that occur between the feed and the receiver"
		versions: ["V2_0", "V2_1"]
	},
	#HowVersionObject & {
		keys: RXlossH?: float64 & >0
		description: "Total loss in dB in the receiving chain for horizontally-polarized signals, defined as the losses that occur between the antenna reference point and the receiver, inclusive."
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: RXlossV?: float64 & >0
		description: "Total loss in dB in the receiving chain for vertically-polarized signals, defined as the losses that occur between the antenna reference point and the receiver, inclusive."
		versions:    _from["V2_2"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: antgainH?: float64 & >0
		description: "Antenna gain in dB for horizontally-polarized signals"
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: antgainV?: float64 & >0
		description: "Antenna gain in dB for vertically-polarized signals"
		versions:    _from["V2_2"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: radconstH?: float64 & >0
		description: "Radar constant in dB for the horizontal channel. For the precise definition, see Appendix A"
		versions:    _from["V2_1"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: radconstV?: float64 & >0
		description: "Radar constant in dB for the vertical channel. For the precise definition, see Appendix A"
		versions:    _from["V2_1"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: NI?: float64
		description: "Unambiguous velocity (Nyquist) interval in ±m/s"
	},
	#HowVersionObject & {
		keys: scan_index?: uint
		description: "Which scan this is in the temporal sequence (starting with 1) of the total number of scans comprising the volume."
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: scan_count?: uint
		description: "The total number of scans comprising the volume."
		versions:    _from["V2_2"]
	},

	#HowVersionObject & {
		keys: astart?: float64
		description: "Azimuthal offset in degrees (◦) from 0◦ of the start of the first ray in the sweep. This value is positive where the gate starts clockwise after 0◦,and it will be negative if it starts before 0◦ . In either case, the value must be no larger than half a ray’s width."
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: startazA?: #simpleArrayOfDoubles
		description: "Azimuthal start angles (degrees) used for each gate in a scan. The number of values in this array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: stopazA?: #simpleArrayOfDoubles
		description: "Azimuthal stop angles (degrees) used for each gate in a scan. The number of values in this array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: NEZ?: float64
		description: "The total system noise expressed as the reflectivity (dBZ) it would represent at one km distance from the radar."
		versions: ["V2_1"]
	},
	#HowVersionObject & {
		keys: NEZH?: float64
		description: "The total system noise expressed as the horizontally-polarized reflectivity (dBZ) it would represent at one km distance from the radar."
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: NEZV?: float64
		description: "The total system noise expressed as the vertically-polarized reflectivity (dBZ) it would represent at one km distance from the radar."
		versions:    _from["V2_2"]
		groups: ["v"]

	},
	#HowVersionObject & {
		keys: LOG?: float64
		description: "Security distance above mean noise level (dB) threshold value."
	},
	#HowVersionObject & {
		keys: LOG_threshold?: float64
		description: "Security distance above mean noise level (dB) threshold value."
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: extensions?: string
		description: "Name of the extensions of `/what/version`"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: data_origin?: #sequence
		description: "If a quantity or quality field has been modified, the originating quantity or quality field together with the applied quantity or quality field(s) should be provided, e.g. [/datasetM/dataN, /datasetM/dataN/qualityP] or [DBZH, se.smhi.detector.beamblockage]."
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: startepochs?: int
		description: "Seconds after a standard 1970 epoch for which the starting time of the data/product is valid. A compliment to “date” and “time” in Table 1, for those who prefer to calculate times directly in epoch seconds."
		versions: ["V2_0"]
	},
	#HowVersionObject & {
		keys: endepochs?: int
		description: "Seconds after a standard 1970 epoch for which the ending time of the data/product is valid. A compliment to “date” and “time” in Table 1, for those who prefer to calculate times directly in epoch seconds."
		versions: ["V2_0"]
	},
	#HowVersionObject & {
		keys: startepochs?: float64
		description: "Seconds after a standard 1970 epoch for which the starting time of the data/product is valid. A compliment to “date” and “time” in Table 1, for those who prefer to calculate times directly in epoch seconds."
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: endepochs?: float64
		description: "Seconds after a standard 1970 epoch for which the ending time of the data/product is valid. A compliment to “date” and “time” in Table 1, for those who prefer to calculate times directly in epoch seconds."
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: system?: string //allows anything from the specification
		description: "According to Table 11"
	},
	#HowVersionObject & {
		keys: software?: string //can be anything according to the specification
		description: "According to Table 12"
	},
	#HowVersionObject & {
		keys: TXtype?: "magnetron" | "klystron" | "solid state"
		description: "Transmitter type [magnetron; klystron; solid state]"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: sw_version?: string & =~"^([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\\.[0-9A-Za-z-]+)*))?(?:\\+[0-9A-Za-z-]+)?$"
		description: "Software version in string format, e.g. “5.1” or “8.11.6.2”"
	},
	#HowVersionObject & {
		keys: poltype?: "single" | "simultaneous-dual" | "switched-dual"
		description: "Polarization type of the radar [single; simultaneous-dual; switched-dual]"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: polmode?: "LDR-H" | "single-H" | "LDR-V" | "single-V" | "simultaneous-dual" | "switched-dual"
		description: "Current polarity mode [LDR-H; single-H; LDR-V; single-V; simultaneous-dual; switched-dual]"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: zr_a?: float64
		description: "Z-R constant a in Z = a Rb, applicable to any product containing reflectivity or precipitation data"
	},
	#HowVersionObject & {
		keys: zr_b?: float64
		description: "Z-R exponent b in Z = a Rb, applicable to any product containing reflectivity or precipitation data"
	},
	#HowVersionObject & {
		keys: kr_a?: float64
		description: "Kdp-R constant a in R = a Kdp b"
	},
	#HowVersionObject & {
		keys: kr_b?: float64
		description: "Kdp-R exponent b in R = a Kdp b"
	},
	#HowVersionObject & {
		keys: zr_a_A?: #simpleArrayOfDoubles
		description: "Z-R constant a in Z = a Rb, applicable to any product containing reflectivity or precipitation data"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: zr_b_A?: #simpleArrayOfDoubles
		description: "Z-R exponent b in Z = a Rb, applicable to any product containing reflectivity or precipitation data"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: kr_a_A?: #simpleArrayOfDoubles
		description: "Kdp-R constant a in R = a Kdp b"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: kr_b_A?: #simpleArrayOfDoubles
		description: "Kdp-R exponent b in R = a Kdp b"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: simulated?: #ODIMBool
		description: "“True” if data are simulated, otherwise “False”"
	},
	#HowVersionObject & {
		keys: rpm?: float64
		description: "The antenna speed in revolutions per minute, positive for clockwise scanning, negative for counter-clockwise scanning."
		versions: ["V2_0", "V2_1", "V2_2", "V2_3"]
		deprecated: ["V2_3"]
	},
	#HowVersionObject & {
		keys: elevspeed?: float64
		description: "Antenna elevation speed (RHI mode) in degrees/s, positive values ascending, negative values descending."
		versions: ["V2_2", "V2_3"]
		deprecated: ["V2_3"]
	},
	#HowVersionObject & {
		keys: antspeed?: float64
		description: "Antenna speed in degrees/s (positive for clockwise and ascending, negative for counter-clockwise and descending)"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: pulsewidth?: float64 & >0
		description: "Pulsewidth in µs"
		versions: ["V2_0", "V2_1", "V2_2", "V2_3"]
	},
	#HowVersionObject & {
		keys: pulsewidth?: float64 & >0 & <0.1
		description: "seconds - Pulsewidth"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: lowprf?: float64
		description: "Low pulse repetition frequency in Hz"
	},
	#HowVersionObject & {
		keys: midprf?: float64
		description: "Intermediate pulse repetition frequency in Hz"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: highprf?: float64
		description: "High pulse repetition frequency in Hz"
	},
	#HowVersionObject & {
		keys: TXloss?: float64
		description: "Total loss in dB in the transmission chain, defined as the losses that occur between the signal generator and the feed horn"
		versions: ["V2_0", "V2_1"]
	},
	#HowVersionObject & {
		keys: TXlossH?: float64
		description: "Total loss in dB in the transmission chain for horizontallypolarized signals, defined as the losses that occur between the calibration reference plane and the feed horn, inclusive."
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: TXlossV?: float64
		description: "Total loss in dB in the transmission chain for verticallypolarized signals, defined as the losses that occur between the calibration reference plane and the feed horn, inclusive."
		versions:    _from["V2_2"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: injectlossH?: float64
		description: "Total loss in dB between the calibration reference plane and the test signal generator for horizontally-polarized signals."
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: injectlossV?: float64
		description: "Total loss in dB between the calibration reference plane and the test signal generator for vertically-polarized signals."
		versions:    _from["V2_2"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: radomeloss?: float64
		description: "One-way dry radome loss in dB"
		versions: ["V2_1"]
	},
	#HowVersionObject & {
		keys: radomelossH?: float64
		description: "One-way dry radome loss in dB for horizontally-polarized signals"
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: radomelossV?: float64
		description: "One-way dry radome loss in dB for vertically-polarized signals"
		versions:    _from["V2_2"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: gasattn?: float64
		description: "Gaseous specific attenuation in dB/km assumed by the radar processor (zero if no gaseous attenuation is assumed)"
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: nomTXpower?: float64
		description: "Nominal transmitted peak power in kW at the output of the transmitter (magnetron/klystron output flange)"
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: TXpower?: #simpleArrayOfDoubles
		description: "Transmitted peak power in kW at the calibration reference plane. The values given are average powers over all transmitted pulses in each azimuth gate. The number of values in this array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: powerdiff?: float64
		description: "Power difference between transmitted horizontally and vertically-polarized signals in dB at the the feed horn."
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: phasediff?: float64
		description: "Phase difference in degrees between transmitted horizontally and vertically-polarized signals as determined from the first valid range bins"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: Vsamples?: int
		description: "Number of samples used for radial velocity measurements"
		versions:    _from["V2_1"]
	},

	#HowVersionObject & {
		keys: scan_optimized?: #quant
		description: "Scan optimized for quantity [DBZH; VRADH; etc.]"
		versions: [_v]
	},
	#HowVersionObject & {
		keys: azmethod?: #method
		description: "How raw data in azimuth are processed to arrive at the given value, according to Table 13"
		versions: [_v]
	},

	#HowVersionObject & {
		keys: elmethod?: #method
		description: "How raw data in elevation are processed to arrive at the given value, according to Table 13"
		versions: [_v]
	},
	#HowVersionObject & {
		keys: binmethod?: #method
		description: "How raw data in range are processed to arrive at the given value, according to Table 13"
		versions: [_v]
	},
	#HowVersionObject & {
		keys: camethod?: #method
		description: "How cartesian data are processed, according to Table 12/13"
		versions: [_v]
	},

	#HowVersionObject & {
		keys: binmethod_avg?: uint
		description: "How many original data elements in range are averaged to arrive at the given value."
		versions:    _from["V2_3"]
	},

	#HowVersionObject & {
		keys: vpmethod?: #method
		description: "Applied method to derive the vertical profile [VAD; VVP; etc.]"
		versions: [_v]
	},

	#HowVersionObject & {
		keys: elangles?: #simpleArrayOfDoubles
		description: "Elevation angles (degrees above the horizon) used for each azimuth gate in an “intelligent” scan that e.g. follows the horizon. The number of values in this array corresponds with the value of where/nrays for that dataset."
		versions: ["V2_0", "V2_1", "V2_2", "V2_3"]
		deprecated: ["V2_3"]
	},
	#HowVersionObject & {
		keys: azangles?: #sequenceOfPairs
		description: "Azimuthal start and stop angles (degrees) used for each azumith gate in a scan. The format for each start-stop pair of angles is ’start:stop’ and each pair is separated by a comma."
		versions: ["V2_0"]
	},
	#HowVersionObject & {
		keys: aztimes?: #sequenceOfPairs
		description: "Acquisition start and stop times for each azimuth gate in the sector or scan. The format for each start-stop pair of times is ’HHMMSS.sss:HHMMSS.sss’ and each pair is separated by a comma. The required precision is to the millisecond."
		versions: ["V2_0"]
	},

	#HowVersionObject & {
		keys: startazT?: #simpleArrayOfDoubles
		description: "Acquisition start times for each azimuth gate in the sector or scan, in seconds past the 1970 epoch. The number of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond."
		versions: ["V2_1", "V2_2", "V2_3"]
		deprecated: ["V2_3"]
	},

	#HowVersionObject & {
		keys: stopazT?: #simpleArrayOfDoubles
		description: "Acquisition stop times for each azimuth gate in the sector or scan, in seconds past the 1970 epoch. The number of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond."
		versions: ["V2_1", "V2_2", "V2_3"]
		deprecated: ["V2_3"]
	},
	#HowVersionObject & {
		keys: startazA?: #simpleArrayOfDoubles
		description: "Azimuthal start angles (degrees) used for each azimuth gate in a scan. The number of values in this array corresponds with the value of where/nrays for that dataset"
		versions: ["V2_1", "V2_2"]
	},
	#HowVersionObject & {
		keys: stopazA?: #simpleArrayOfDoubles
		description: "Azimuthal stop angles (degrees) used for each azimuth gate in a scan. The number of values in this array corresponds with the value of where/nrays for that dataset."
		versions: ["V2_1", "V2_2"]
	},
	#HowVersionObject & {
		keys: startelA?: #simpleArrayOfDoubles
		description: "Elevational start angles (degrees) used for each gate in a scan. The number of values in this array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: stopelA?: #simpleArrayOfDoubles
		description: "Elevational stop angles (degrees) used for each gate in a scan. The number of values in this array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_2"]
	},

	#HowVersionObject & {
		keys: startelT?: #simpleArrayOfDoubles
		description: "Acquisition start times for each elevation gate in the sector or scan, in seconds past the 1970 epoch. The number of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond."
		versions: ["V2_2", "V2_3"]
		deprecated: ["V2_3"]
	},
	#HowVersionObject & {
		keys: stopelT?: #simpleArrayOfDoubles
		description: "Acquisition stop times for each elevation gate in the sector or scan, in seconds past the 1970 epoch. The number of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond."
		versions: ["V2_2", "V2_3"]
		deprecated: ["V2_3"]
	},
	#HowVersionObject & {
		keys: startT?: #simpleArrayOfDoubles
		description: "Acquisition start times for each gate in the sector or scan, in seconds past the 1970 epoch. The number of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond."
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: stopT?: #simpleArrayOfDoubles
		description: "Acquisition stop times for each gate in the sector or scan, in seconds past the 1970 epoch. The number of values in this array corresponds with the value of where/nrays for that dataset. The required precision is to the millisecond."
		versions:    _from["V2_3"]
	},

	#HowVersionObject & {
		keys: top_heights?: #simpleArrayOfDoubles
		description: "Layer top heights (meter) above mean sea level"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: bottom_heights?: #simpleArrayOfDoubles
		description: "Layer bottom heights (meter) above mean sea level"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: angles?: #simpleArrayOfDoubles
		description: "Elevation angles in the order in which they were acquired, used to generate the product"
	},
	#HowVersionObject & {
		keys: arotation?: #simpleArrayOfDoubles
		description: "Antenna rotation speed in degrees/s (positive for clockwise, negative for counter-clockwise). The number of values in this array corresponds with the values of how/angles described above."
	},
	#HowVersionObject & {
		keys: nodes?: #sequenceOfNodes | =~"[a-z]{3}(,[a-z]{3})*" //list of three letter (no country) nodes, not mixed, allow forward-compatibility
		description: "Radar nodes (Table 10) which have contributed data to the composite, e.g. “’searl’, ’noosl’, ’sease’, ’fikor”’"
		versions: ["V2_0"]
	},
	#HowVersionObject & {
		keys: nodes?: #sequenceOfNodes
		description: "Radar nodes (Table 10) which have contributed data to the composite, e.g. “’searl’, ’noosl’, ’sease’, ’fikor”’"
		versions:    _from["V2_1"]
	},
	#HowVersionObject & {
		keys: ACCnum?: uint
		description: "Number of images used in precipitation accumulation"
	},
	#HowVersionObject & {
		keys: minrange?: float64
		description: "Minimum range at which data is used when generating profile (km)"
	},
	#HowVersionObject & {
		keys: maxrange?: float64
		description: "Maximum range at which data is used when generating profile (km)"
	},
	#HowVersionObject & {
		keys: pointaccEL?: float64
		description: "Antenna pointing accuracy in elevation (degrees). Possible pointing errors in elevation include e.g. tilt of turning level of the head (tilt of pedestal), non-linearities in gears, backlash in gearboxes, and uncertainties in angle adjustment e.g. using the sun."
	},
	#HowVersionObject & {
		keys: pointaccAZ?: float64
		description: "Antenna pointing accuracy in azimuth (degrees). Possible pointing errors in azimuth include e.g. non-linearities in gears, backlash in gearboxes, and uncertainties in angle adjustment e.g. using the sun."
	},
	#HowVersionObject & {
		keys: sample_size?: #simpleArrayOfUInts
		description: "Number of valid data points in a level of a vertical profile. The number of values in this array corresponds with the value of where/levels for that dataset. dealiased boolean “True” if data has been dealiased, “False” if not"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: anglesync?: "azimuth" | "elevation"
		description: "Antenna angle synchronization mode [azimuth; elevation]"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: anglesyncRes?: float64
		description: "Resolution of angle synchronization in degrees"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: malfunc?: #ODIMBool
		description: "Radar malfunction indicator. If a quantity should not be used for any application due to radar hardware and/or software failure, how/malfunc should be “True”, otherwise “False”."
	},
	#HowVersionObject & {
		keys: radar_msg?: string
		description: "Radar malfunction message"
	},
	#HowVersionObject & {
		keys: radhoriz?: float64
		description: "Radar horizon (maximum range in km)"
	},
	#HowVersionObject & {
		keys: OUR?: float64
		description: "Overall uptime reliability (%)"
	},
	#HowVersionObject & {
		keys: Dclutter?: #sequence
		description: "Doppler clutter filters used when collecting data"
	},
	#HowVersionObject & {
		keys: clutterType?: string
		description: "Description of clutter filter used in the signal processor"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: clutterMap?: string
		description: "Filename of clutter map"
		versions:    _from["V2_2"]
	},
	#HowVersionObject & {
		keys: zcalH?: float64
		description: "Calibration offset in dB for the horizontal channel"
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: zcalV?: float64
		description: "Calibration offset in dB for the vertical channel"
		versions:    _from["V2_2"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: zdrcal?: float64
		description: "ZDR calibration offset in dB"
		versions:    _from["V2_3"]
	},
	#HowVersionObject & {
		keys: nsampleH?: float64
		description: "Noise sample in dB for the horizontal channel"
		versions:    _from["V2_2"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: nsampleV?: float64
		description: "Noise sample in dB for the vertical channel"
		versions:    _from["V2_2"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: nsampleH_A?: #simpleArrayOfDoubles
		description: "Noise sample for the horizontal channel. The size of this one-dimensional array corresponds with the value of where/nrays for that dataset"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: nsampleV_A?: #simpleArrayOfDoubles
		description: "Noise sample for the vertical channel. The size of this one-dimensional array corresponds with the value of where/nrays for that dataset"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: comment?: string
		description: "Free text description. Anecdotal quality information"
	},
	#HowVersionObject & {
		keys: SQI?: float64
		description: "Signal Quality Index threshold value"
	},
	#HowVersionObject & {
		keys: CSR?: float64
		description: "Clutter-to-signal ratio threshold value"
	},
	#HowVersionObject & {
		keys: VPRCorr?: #ODIMBool
		description: "“True” if vertical reflectivity profile correction has been applied, otherwise “False”"
	},
	#HowVersionObject & {
		keys: freeze?: float64
		description: "Freezing level (km) above sea level."
		deprecated: ["V2_3"]
		versions: ["V2_0", "V2_1", "V2_2", "V2_3"]
	},
	#HowVersionObject & {
		keys: melting_layer_top?: #simpleArrayOfDoubles
		description: "Melting layer top level (km) above mean sea level"
		versions: ["V2_3"]
	},
	#HowVersionObject & {
		keys: melting_layer_top?: float64
		description: "Melting layer top level (km) above mean sea level"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: melting_layer_top_A?: #simpleArrayOfDoubles
		description: "Melting layer top height above mean sea level. The size of this two-dimensional array corresponds with the values of where/nrays and where/nbins for that dataset."
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: melting_layer_bottom?: #simpleArrayOfDoubles
		description: "Melting layer bottom level (km) above mean sea level"
		versions: ["V2_3"]
	},
	#HowVersionObject & {
		keys: melting_layer_bottom?: float64
		description: "Melting layer bottom level (km) above mean sea level"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: melting_layer_bottom_A?: #simpleArrayOfDoubles
		description: "Melting layer bottom height above mean sea level. The size of this two-dimensional array corresponds with the values of where/nrays and where/nbins for that dataset"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: min?: float64
		description: "Minimum value for continuous quality data"
	},
	#HowVersionObject & {
		keys: max?: float64
		description: "Maximum value for continuous quality data"
	},
	#HowVersionObject & {
		keys: step?: float64
		description: "Step value for continuous quality data"
	},
	#HowVersionObject & {
		keys: levels?: uint
		description: "Number of levels in discrete data legend"
	},
	#HowVersionObject & {
		keys: levels?: uint
		description: "Number of levels in discrete data legend"
	},
	#HowVersionObject & {
		keys: peakpwr?: float64
		description: "Peak power (kW)"
	},
	#HowVersionObject & {
		keys: avgpwr?: float64
		description: "Average power (W)"
	},
	#HowVersionObject & {
		keys: dynrange?: float64
		description: "Dynamic range (dB)"
	},
	#HowVersionObject & {
		keys: RAC?: float64
		description: "Range attenuation correction (dBm)"
	},
	#HowVersionObject & {
		keys: BBC?: #ODIMBool
		description: "“True” if bright-band correction applied, otherwise “False”"
	},
	#HowVersionObject & {
		keys: PAC?: float64
		description: "Precipitation attenuation correction (dBm)"
	},
	#HowVersionObject & {
		keys: S2N?: float64
		description: "Signal-to-noise ratio (dB) threshold value."
		deprecated: ["V2_3"]
		versions: ["V2_0", "V2_1", "V2_2", "V2_3"]
	},
	#HowVersionObject & {
		keys: SNRT?: float64
		description: "Signal-to-noise ratio (dB) threshold"
		deprecated: ["V2_4"]
		versions: ["V2_3", "V2_4"]
	},
	#HowVersionObject & {
		keys: SNR_threshold?: float64
		description: "Signal-to-noise ratio (dB) threshold"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: SNRHCT?: float64
		description: "Signal-to-noise ratio (dB) co-polar H threshold"
		deprecated: ["V2_4"]
		versions: ["V2_3", "V2_4"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: SNRHXT?: float64
		description: "Signal-to-noise ratio (dB) cross-polar H threshold"
		deprecated: ["V2_4"]
		versions: ["V2_3", "V2_4"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: SNRVCT?: float64
		description: "Signal-to-noise ratio (dB) co-polar V threshold"
		deprecated: ["V2_4"]
		versions: ["V2_3", "V2_4"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: SNRVXT?: float64
		description: "Signal to noise ratio (dB) cross polar V threshold"
		deprecated: ["V2_4"]
		versions: ["V2_3", "V2_4"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: SNRHC_threshold?: float64
		description: "Signal-to-noise ratio (dB) co-polar H threshold"
		versions:    _from["V2_4"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: SNRHX_threshold?: float64
		description: "Signal-to-noise ratio (dB) cross-polar H threshold"
		versions:    _from["V2_4"]
		groups: ["h"]
	},
	#HowVersionObject & {
		keys: SNRVC_threshold?: float64
		description: "Signal-to-noise ratio (dB) co-polar V threshold"
		versions:    _from["V2_4"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: SNRVX_threshold?: float64
		description: "Signal to noise ratio (dB) cross polar V threshold"
		versions:    _from["V2_4"]
		groups: ["v"]
	},
	#HowVersionObject & {
		keys: polarization?: "H" | "V"
		description: "Type of polarization (H, V) transmitted by the radar"
	},
	#HowVersionObject & {
		keys: MDS?: float64
		description: "Minimum detectable signal (dBZ) at one km distance from the radar"
	},
	#HowVersionObject & {
		keys: smoothed_PHIDP?: #ODIMBool
		description: "“True” if PHIDP or UPHIDP has been smoothed, “False” if not"
		versions:    _from["V2_3"]
	},

	#HowVersionObject & {
		keys: dealiased?: #ODIMBool
		description: "– “True” if data has been dealiased, “False” if not"
	},

	#HowVersionObject & {
		keys: base_1km_hc?: float64
		description: "dBZ Reflectivity at 1 km for SNR = 0 dB noise-corrected H co-polar channel"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: base_1km_vc?: float64
		description: "dBZ Reflectivity at 1 km for SNR = 0 dB noise-corrected V co-polar channel"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: altitude_agl?: float64
		description: "meters Altitude of the center of rotation of the antenna above ground level"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: NEZV_A?: #simpleArrayOfDoubles
		description: "dBZ The total system noise expressed as the vertically-polarized reflectivity it would represent at one km distance from the radar. The size of this one-dimensional array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: NEZH_A?: #simpleArrayOfDoubles
		description: "dBZ The total system noise expressed as the horizontally-polarized reflectivity it would represent at one km distance from the radar. The size of this one-dimensional array corresponds with the value of where/nrays for that dataset"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: prt_ratio?: #simpleArrayOfDoubles
		description: "– Ratio of prt/prt2. For dual/staggered prt mode. The size of this one-dimensional array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: prt?: #simpleArrayOfDoubles
		description: "seconds Pulse repetition time. For staggered prt, also see prt_ratio. The size of this one-dimensional array corresponds with the value of where/nrays for that dataset."
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: frequency?: float64
		description: "Hz Radar frequency"
		versions:    _from["V2_4"]
	},
	#HowVersionObject & {
		keys: platform_type?: "fixed" | "vehicle" | "ship" | "aircraft" | "aircraft_fore”,“aircraft_aft" | "aircraft_tail" | "aircraft_belly" | "aircraft_roof" | "aircraft_nose" | "satellite_orbit" | "satellite_geostat"
		description: "– Options are: “fixed”, “vehicle”, “ship”, “aircraft”, “aircraft_fore”,“aircraft_aft”, “aircraft_tail”, “aircraft_belly”, “aircraft_roof”, “aircraft_nose”, “satellite_orbit”, “satellite_geostat”. Assumed “fixed” if missing."
		versions:    _from["V2_4"]
	},

		// Nyquist Interval can be omitted if no radial velocity data are available ie. not included as mandatory!
	if _singleSite {
		#SingleSiteObject & {
			keys: simulated: #ODIMBool
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: wavelength: float64 & >0
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: frequency: float64 & >0
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: pulsewidth: float64
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: RXlossH: float64 & >0
			groups: ["h"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: RXlossV: float64 & >0
			groups: ["v"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: antgainH: float64 & >0
			groups: ["h"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: antgainV: float64 & >0
			groups: ["v"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: beamwH: float64 & >=0 & <=360
			groups: ["h"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: beamwV: float64 & >=0 & <=360
			groups: ["v"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: radconstH: float64 & >0
			groups: ["h"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: radconstV: float64 & >0
			groups: ["v"]
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: startazA: #simpleArrayOfDoubles
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: stopazA: #simpleArrayOfDoubles
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: scan_index: uint
		}
	},
	if _singleSite {
		#SingleSiteObject & {
			keys: scan_count: uint
		}
	},

]

_methods: [
	#VersionEnum & {
		name:        "NEAREST"
		description: "Nearest neighbour or closest radar"
	},
	#VersionEnum & {
		name:        "INTERPOL"
		description: "Interpolation"
	},
	#VersionEnum & {
		name:        "AVERAGE"
		description: "Average of all values"
	},
	#VersionEnum & {
		name:        "QAVERAGE"
		description: "Quality-weighted average"
		versions:    _from["V2_3"]
	},
	#VersionEnum & {
		name:        "RANDOM"
		description: "Random"
	},
	#VersionEnum & {
		name:        "MDE"
		description: "Minimum distance to earth"
	},
	#VersionEnum & {
		name:        "LATEST"
		description: "Most recent radar"
	},
	#VersionEnum & {
		name:        "MAXIMUM"
		description: "Maximum value"
	},
	#VersionEnum & {
		name:        "QMAXIMUM"
		description: "Maximum quality"
		versions:    _from["V2_3"]
	},
	#VersionEnum & {
		name:        "DOMAIN"
		description: "User-defined compositing"
	},
	#VersionEnum & {
		name:        "VAD"
		description: "Velocity azimuth display"
	},
	#VersionEnum & {
		name:        "VVP"
		description: "Volume velocity processing"
	},
	#VersionEnum & {
		name:        "RGA"
		description: "Gauge-adjustment"
	},
]
