#ODIM HDF5 Validator
ODIM is a specification for how to store Radar data in an HDF5 file.
This project has a mapping routine in python and a write-up of the ODIM specification in CUE.

The Python program has been tested using python 3.9. I believe any python3 will do.

The command
```shell
> python3 hdf5_json.py <my_hdf5_file.h5>
```
maps the hdf5 file metadata to out. pipe that to a file and read using cue:
```shell
> cue vet [--ignore] <my_output_file_from_python_script> odim_scema.cue -d '#Root'
```
This validates the output file vs. the data-specification written in [`odim_schema.cue`](odim_schema.cue).