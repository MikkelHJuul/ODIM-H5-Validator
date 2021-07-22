FROM python:3.9 as cueloader

RUN curl -LO 'https://github.com/cue-lang/cue/releases/download/v0.4.0/cue_v0.4.0_linux_amd64.tar.gz'
RUN tar --extract --file='cue_v0.4.0_linux_amd64.tar.gz' cue

FROM python:3.9

RUN pip install h5py
COPY --from=cueloader cue /usr/local/bin/cue

RUN curl -LO 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64' \
     && mv jq-linux64 /usr/local/bin/jq\
     && chmod +x /usr/local/bin/jq

RUN mkdir validate_odim_h5
WORKDIR validate_odim_h5

COPY *.cue ./
COPY hdf5_json.py hdf5_json.py
COPY validate_odim_h5 .
RUN chmod +x ./validate_odim_h5
ENTRYPOINT ["./validate_odim_h5"]
