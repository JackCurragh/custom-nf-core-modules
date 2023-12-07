#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { RIBOCODE_METAPLOTS } from '../../../../../modules/jackcurragh/ribocode/metaplots/main.nf'
include { RIBOCODE_PREPARE } from '../../../../../modules/jackcurragh/ribocode/prepare/main.nf'



workflow test_ribocode_metaplots {
    
    input = [ [ id:'test', single_end:true ], // meta map
                [   file(params.test_data['homo_sapiens']['illumina']['test_rnaseq_1_fastq_gz'], checkIfExists: true),
            ]
    ]
    fasta = [
        [ id:'test_fasta' ], // meta map
        [ file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true) ]
    ]
    fai = [
        [ id:'test_fai' ], // meta map
        [ file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true) ]
    ]
    gtf = [
        [ id:'test_fasta_gtf' ], // meta map
        [ file(params.test_data['homo_sapiens']['genome']['genome_gtf'], checkIfExists: true) ]
    ]

    RIBOCODE_PREPARE( fasta[1], gtf[1] )
    RIBOCODE_METAPLOTS( , RIBOCODE_PREPARE.out.annotation )
}
