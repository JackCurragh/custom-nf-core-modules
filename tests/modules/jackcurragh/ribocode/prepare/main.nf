#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { RIBOCODE_PREPARE } from '../../../../../modules/jackcurragh/ribocode/prepare/main.nf'

workflow test_ribocode_prepare {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    RIBOCODE_PREPARE ( input )
}
