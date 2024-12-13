# ImmuneBuilder Nextflow Pipeline

<!-- badges: start -->
[![docker-build](https://github.com/juyeongkim/ImmuneBuilder.nf/actions/workflows/docker-build.yml/badge.svg)](https://github.com/juyeongkim/ImmuneBuilder.nf/actions/workflows/docker-build.yml)
<!-- badges: end -->

A Nextflow pipeline based on [ImmuneBuilder](https://github.com/brennanaba/ImmuneBuilder).

## Running Nextflow

### Install Nextflow

Follow this to install Nextflow: https://www.nextflow.io/docs/latest/getstarted.html

### Install Docker (Linux)

Follow the distribution specific installation instructions on the docker site:

https://docs.docker.com/engine/install/

`nf-immunebuilder` requires that the user be added to the docker group. Follow the "Manage Docker as a non-root user" post installation instructions here:

https://docs.docker.com/engine/install/linux-postinstall/

Then optionally pull the docker image:

``` sh
docker pull ghcr.io/juyeongkim/immunebuilder:latest
```

If the docker image is not pulled, it will be pulled when the pipeline is run.

### Pull Nextflow pipeline

```sh
nextflow pull juyeongkim/nf-immunebuilder
```

Downloaded pipeline are stored in the folder `$HOME/.nextflow/assets`.

### Run pipeline

#### Parameters

| Parameter | Description |
| --- | --- |
| `--input` | Input directory with FASTA files (required) |
| `--output` | Output directorty to store PDB files (required) |
| `--max_retries` | Maximum number of time to execute ImmuneBuilder after failing refinement step with OpenMM (optional; default: 5) |
| `--save_embedding` | Save embedding numpy array as npy file (optional; default: false) |

#### A) Locally (requires docker)

```sh
cd /where/you/want/to/store/logs/and/intermediate/files
nextflow pull juyeongkim/nf-immunebuilder
nextflow run juyeongkim/nf-immunebuilder -r main --input /your/input/dir --output /your/output/dir --max_retries 10 --save_embedding true
```

#### B) Cluster

Alternatively, you can run the pipeline on HPC with slurm. First, load the environment modules if they are available. If not, please follow the Apptainer and Nextflow documentation to install them first.

```sh
module load Apptainer/1.1.6 # newer versions might not work!
module load Nextflow
cd /where/you/want/to/store/logs/and/intermediate/files
nextflow pull juyeongkim/nf-immunebuilder
nextflow run juyeongkim/nf-immunebuilder -r main -profile cluster --input /your/input/dir --output /your/output/dir --max_retries 10 --save_embedding true
```

## Using Docker image

### Get Docker image

```sh
# Pull docker image from GitHub
docker pull ghcr.io/juyeongkim/immunebuilder:latest

# Or build docker image
git clone https://github.com/juyeongkim/nf-immunebuilder.git
cd nf-immunebuilder
docker build -t ghcr.io/juyeongkim/immunebuilder:latest .
```

### Initiate a Docker container

```sh
cd /WHERE/YOUR/FASTA/FILES/ARE
docker run --volume $PWD:/data -it ghcr.io/juyeongkim/immunebuilder:latest
```

### Run ABodyBuilder2 in Docker container

```sh
cd /data
# your fasta file should have this format: https://github.com/brennanaba/ImmuneBuilder/tree/main#fasta-formatting
ABodyBuilder2 -v --fasta_file yourAntibody.fasta
cat ABodyBuilder2_output.pdb # default outpute file name
```
