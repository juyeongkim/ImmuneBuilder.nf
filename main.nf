#!/usr/bin/env nextflow
nextflow.enable.dsl=2

FASTA = Channel.fromPath("${params.input}/*.fasta").map {[it.name, it]}

process ABODYBUILDER2 {
  publishDir "${params.output}", mode: 'copy'

  input:
  tuple val(sample_id), path(fasta_file)

  output:
  path "*.pdb"

  script:
  """
  ABodyBuilder2 -v --fasta_file ${sample_id} --output ${sample_id}.pdb
  """
}

workflow {
  ABODYBUILDER2(FASTA)
}
