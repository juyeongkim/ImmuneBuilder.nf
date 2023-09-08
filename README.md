# ImmuneBuilder Nextflow Pipeline

<!-- badges: start -->
[![docker-build](https://github.com/juyeongkim/ImmuneBuilder.nf/actions/workflows/docker-build.yml/badge.svg)](https://github.com/juyeongkim/ImmuneBuilder.nf/actions/workflows/docker-build.yml)
<!-- badges: end -->

A Nextflow pipeline based on [ImmuneBuilder](https://github.com/brennanaba/ImmuneBuilder).

## Using Docker image locally

### Get Docker image

```sh
# Pull docker image from GitHub
docker pull ghcr.io/juyeongkim/immunebuilder:latest

# Or build docker image
git clone https://github.com/juyeongkim/ImmuneBuilder.nf.git
cd juyeongkim/ImmuneBuilder.nf
docker build -t juyeongkim/immunebuilder:latest .
```

### Initiate a Docker container

```sh
cd /WHERE/YOUR/FASTA/FILES/ARE
docker run --volume $PWD:/data -it juyeongkim/immunebuilder:latest
```

### Run ABodyBuilder2 in Docker container

```sh
cd /data
# your fasta file should have this format: https://github.com/brennanaba/ImmuneBuilder/tree/main#fasta-formatting
ABodyBuilder2 -v --fasta_file yourAntibody.fasta
cat ABodyBuilder2_output.pdb # default outpute file name
```
