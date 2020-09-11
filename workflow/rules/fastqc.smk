rule fastqc:
    input:
        ["../../fastq/{sample}_1.fastq.gz", "../../fastq/{sample}_2.fastq.gz"]
    output:
        html = "../results/qc/fastqc/{sample}.html",
        zip = "../results/qc/fastqc/{sample}_fastqc.zip"
    params: ""
    log:
        "logs/fastqc/{sample}.log"
    benchmark:
        repeat("benchmarks/fastqc/{sample}.tsv", 3)
    message:
        "Undertaking quality control checks on raw sequence data for {input}"
    threads: 32
    wrapper:
        "0.64.0/bio/fastqc"