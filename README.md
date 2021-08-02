# ODIM HDF5 Validator
[ODIM](https://www.eumetnet.eu/glossary/odim/) ([OPERA](https://www.eumetnet.eu/glossary/opera/) Data Information Model) is a specification for how to store Radar data in an HDF5 file (and BUFR).
This project has a mapping routine in python and a write-up of the ODIM specification in [CUE](http://cuelang.org/).


## Scripts 
The Python script has been tested using python 3.9. I believe any python3 will do.

The Python script maps the internal hdf5 tree as a json-object, aggregating "parent" values of `how` and `where` attribute groups.

The command
```shell
> python3 hdf5_json.py <my_hdf5_file.h5> [-- <attribute keys to ignore>]
```
maps the hdf5 file metadata to stdout. 
Pipe that to a file and read using `cue`:
```shell
> cue vet [--ignore] <my_output_file_from_python_script> ./*.cue 
        -t version=<version> [-t single_site=true] [-t mixed_polarization=true]
```
This validates the output file vs. the data-specification with entry in the `root` object in [`odim_schema.cue`](odim_schema.cue).

The project has a wrapping script that handles versions and allow overwriting the version to validate against (if one wish to validate a current file vs. another version than it actually has)
```shell
> validate_odim_h5 [-as <version> | -single-site | --polarization <mixed|horizontal|vertical>] 
            <file> [-- <ignore fields>]
```
The script is purely to tie the two other products together (in the container).

## Docker container
The docker container collect the dependencies, and use the `validate_odim_h5` bash script as entrypoint.

Usage:
```shell
> docker run -v </path/to/file.h5>:</file/in/container.h5> <containerId> 
           <same input as validate_odim_h5 script; use earlier stated in-container path>
```
## Mapped specifications
 - [v2.01](https://www.eumetnet.eu/wp-content/uploads/2019/05/OPERA-ODIM_H5-v2.01.pdf)
 - [v2.1](https://www.eumetnet.eu/wp-content/uploads/2019/05/OPERA-ODIM_H5-v2.1.pdf)
 - [v2.2](https://www.eumetnet.eu/wp-content/uploads/2019/05/OPERA-ODIM_H5-v2.2.pdf)
 - [v2.3](https://www.eumetnet.eu/wp-content/uploads/2019/01/ODIM_H5_v23.pdf)
 - [v2.4](https://www.eumetnet.eu/wp-content/uploads/2021/07/ODIM_H5_v2.4.pdf)

## V2.4 Mandatory Single Site data
The addition of mandatory `how`-attributes and `/what/source: NOD` prompted a change for the validation leaving me to revisit the way `*H` and `*V` attributes were handled.

I have now interpreted values to not be allowed to mix both `*H` and `*V` attributes in a single `how`-group. This behavior can be controlled by the feature-flag `--mixed-polarization`; allowing mixing of the two in the same `how`-attribute group.

## Known bugs/limitations/interpretation/notes
 - The v2.01 specification is used, the v2.0 specification is fully disregarded.
 - While not expressly stated in the specification, this script expect that datasets, data groups and quality groups are called `dataset[n]`, `data[n]` and `quality[n]` respectively, they are never referenced in any other way.
 - deprecations in the specification do not trigger warnings/errors
 - `/what/source` is validated through regex that allow defining the same key multiple times in the string without triggering an error
 - the data type `simpleArrayOfDoubles` is used for validation of `sequence`-types for versions before it was introduced, as it really is a subset of the sequence type but with more specificity, this way it is used to validate the v2.01 specification objects where a sequence was expected to follow the more specific syntax of `simple array [of doubles]`.
 - `where`-objects are interpreted to require all the stated keys, deprecated members are allowed to be missing (RHI specific member `angles`, at v2.3)
 - `how` can in version 2.3 and up have allowed subgroups; generally the specification allow additional fields. The validation here does not! filter these using the python program's filter-mechanism. (this is safer than allowing anything, as the developer will then be required to double-check their errors; this weeds out spelling mistakes and earlier defined keys that were removed in the specification, requiring your validation to be specific about which fields to ignore)
 - the `dataset` (and `data` group) `what` object has no specifically "required" attributes; allowed attributes are all allowed to be missing independently of all other sibling attributes.
 - This project does not offer validation of cross-cutting terms like: adding "vertical" only `where`-attributes at `dataset` group level encompassing data that is not of type: "vertical". It is not clear to me if this is even wrong in the first place. This may however be buggy as inheritance would combine into undefined objects.
 - only `how` and `where`-attribute groups inherit from their "parents".
 - v2.4 `how/pulsewidth` changed from µs to s. I have tried guarding this by validating the v2.4 pulsewidth to be between 0 s and 0.1 s, as pulsewidths are in the µs range (a very wide pulse, above 100 µs probably, would shadow echoes, see [wiki](https://en.wikipedia.org/wiki/Radar_signal_characteristics#Pulse_width)), if you try to express a value in µs after v2.4 you should correct this to seconds. 
 - because of a limitation in `cue`(language) [(validation of a range of structs where one struct is a subset of another)](https://github.com/cue-lang/cue/discussions/1163) the object `/where` can validate as any object between the top level "polar" `where` group and the top level "vertical" `where` group

## TODO
 - possibly create `cue` modules
 - tests for `cue` -- structure/rules
 - tests on an array of hdf5 files, or at least pre-compiled json-trees?
 - Docker container @ dockerhub
 - more data validation (double/int/string ranges)
