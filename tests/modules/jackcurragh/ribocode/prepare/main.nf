#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { RIBOCODE_PREPARE } from '../../../../../modules/jackcurragh/ribocode/prepare/main.nf'

workflow test_ribocode_prepare_custom {
    
    fasta = [
        [ id:'test_fasta' ], // meta map
        [ file(params.test_data['custom']['genome']['chr12_subset_fasta'], checkIfExists: true) ]
    ]
    gtf = [
        [ id:'test_fasta_gtf' ], // meta map
        [ file(params.test_data['custom']['genome']['chr12_subset_gtf'], checkIfExists: true) ]
    ]
    RIBOCODE_PREPARE ( fasta[1], gtf[1] )
}
