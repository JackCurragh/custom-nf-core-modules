#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { RIBOCODE_METAPLOTS } from '../../../../../modules/jackcurragh/ribocode/metaplots/main.nf'
include { RIBOCODE_PREPARE } from '../../../../../modules/jackcurragh/ribocode/prepare/main.nf'
include { RIBOCODE_RIBOCODE } from '../../../../../modules/jackcurragh/ribocode/ribocode/main.nf'

workflow test_ribocode_ribocode {
    
    input = [ [ id:'test', single_end:true ], // meta map
                [   file(params.test_data['custom']['homo_sapiens']['HEK_riboseq_transcriptomic_bam'], checkIfExists: true),
            ]
    ]
    fasta = [
        [ id:'test_fasta' ], // meta map
        [ file(params.test_data['custom']['genome']['chr22_fasta'], checkIfExists: true) ]
    ]
    fai = [
        [ id:'test_fai' ], // meta map
        [ file(params.test_data['custom']['genome']['chr22_fai'], checkIfExists: true) ]
    ]
    gtf = [
        [ id:'test_fasta_gtf' ], // meta map
        [ file(params.test_data['custom']['genome']['chr22_gtf'], checkIfExists: true) ]
    ]
    config = [
        [id:'test_config'],
        [file(params.test_data['custom']['ribocode']['HEK_riboseq_transcriptomic_config'], checkIfExists: true) ]
    ]

    RIBOCODE_PREPARE( fasta[1], gtf[1] )
    RIBOCODE_RIBOCODE ( input, RIBOCODE_PREPARE.out.annotation, config )
}
