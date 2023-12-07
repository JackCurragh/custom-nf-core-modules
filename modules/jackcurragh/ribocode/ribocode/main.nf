process RIBOCODE_RIBOCODE {
    tag "$meta.id"
    label 'process_single'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/ribocode:1.2.15--pyhfa5458b_0':
        'biocontainers/ribocode:1.2.15--pyhfa5458b_0' }"

    input:
    tuple val(meta), path(bam)
    path annotation
    tuple val(meta3), path(config)

    output:

    tuple val(meta), path("*ORFs.bed")             , emit: orf_bed, optional: true
    tuple val(meta), path("*ORFs_collapsed.bed")   , emit: orf_bed_collapsed, optional: true
    tuple val(meta), path("*ORFs_collapsed.gtf")   , emit: orf_gtf_collapsed, optional: true
    tuple val(meta), path("*ORFs_collapsed.txt")   , emit: orf_txt_collapsed
    tuple val(meta), path("*ORFs.gtf")             , emit: orf_gtf, optional: true
    tuple val(meta), path("*ORFs.txt")             , emit: orf_txt
    path "versions.yml"          , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    """
    RiboCode \\
        -a $annotation \\
        -c $config \\
        -o ORFs \\
        $args 2>&1 || test -s ORFs.txt

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        RiboCode: \$(RiboCode --version 2>&1)
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    
    """
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        RiboCode: \$(RiboCode --version)
    END_VERSIONS
    """
}
