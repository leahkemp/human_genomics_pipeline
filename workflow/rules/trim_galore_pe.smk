rule trim_galore_pe:
    input:
        ["../../fastq/{sample}_1.fastq.gz", "../../fastq/{sample}_2.fastq.gz"]
    output:
        temp("../results/trimmed/{sample}_1_val_1.fq.gz"),
        "../results/trimmed/{sample}_1.fastq.gz_trimming_report.txt",
        temp("../results/trimmed/{sample}_2_val_2.fq.gz"),
        "../results/trimmed/{sample}_2.fastq.gz_trimming_report.txt"
    params:
        adapters = expand("{adapters}", adapters = config['TRIMMING']['ADAPTERS']),
        other = "-q 20 --paired"
    log:
        "logs/trim_galore/{sample}.log"
    benchmark:
        repeat("benchmarks/trim_galore_pe/{sample}.tsv", 3)
    conda:
        "../envs/trim_galore.yaml"
    threads: 32
    message:
        "Applying quality and adapter trimming to input fastq files: {input}"
    shell:
        "trim_galore {input} -o ../results/trimmed/ {params.adapters} {params.other} -j {threads}"
