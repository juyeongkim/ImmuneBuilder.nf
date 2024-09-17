#!/usr/bin/env nextflow
nextflow.enable.dsl=2

FASTA = Channel.fromPath("${params.input}/*.fasta").map {[it.name, it]}

process ImmuneBuilder {
  publishDir "${params.output}", mode: 'copy'

  input:
  tuple val(sample_id), path(fasta_file)

  output:
  path "*.pdb"

  script:
  """
  #!/bin/bash
  echo ${task.cpus}
  num_lines=\$(wc -l < ${sample_id})
  if [[ \$num_lines == 2 ]]; then
    NanoBodyBuilder2 -v --n_threads ${task.cpus} --fasta_file ${sample_id} --output ${sample_id}.pdb
  elif [[ \$num_lines == 4 ]]; then
    first_line=\$(head -n 1 ${sample_id})
    if [[ \$first_line == ">H" ]]; then
      ABodyBuilder2 -v --n_threads ${task.cpus} --fasta_file ${sample_id} --output ${sample_id}.pdb
    elif [[ \$first_line == ">A" ]]; then
      TCRBuilder2 -v --n_threads ${task.cpus} --fasta_file ${sample_id} --output ${sample_id}.pdb
    else
      echo "Invalid FASTA file"
      exit 1
    fi
  else
    echo "Invalid FASTA file"
    exit 1
  fi
  """
}

workflow {
  ImmuneBuilder(FASTA)
}
