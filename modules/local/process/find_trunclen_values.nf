// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
def options    = initOptions(params.options)

process FIND_TRUNCLEN_VALUES {
    //tag "$meta"
    label 'process_low'

    conda (params.enable_conda ? "pandas=1.1.5--py39ha9443f7_0" : null)
    if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
        container "https://depot.galaxyproject.org/singularity/pandas:1.1.5"
    } else {
        container "quay.io/biocontainers/pandas:1.1.5"
    }

    input:
    tuple val(meta), path(qual_stats)
    
    output:
    tuple val(meta), stdout

    script:
    """
    find_trunclen_values.py $qual_stats $options.args
    """
}