FROM continuumio/miniconda3:23.5.2-0
# https://github.com/brennanaba/ImmuneBuilder#install
RUN conda install -y -c pytorch pytorch
# https://github.com/openmm/openmm/issues/3943
RUN conda install -y -c conda-forge libstdcxx-ng
RUN conda install -y -c conda-forge openmm pdbfixer
RUN conda install -y -c bioconda anarci
RUN pip install ImmuneBuilder
