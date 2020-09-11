rule gatk_GenotypeGVCFs:
    input:
        gvcf = "../results/called/{family}_raw_snps_indels_tmp_combined.g.vcf",
        refgenome = expand("{refgenome}", refgenome = config['REFGENOME'])
    output:
        protected("../results/called/{family}_raw_snps_indels.g.vcf")
    params:
        tdir = expand("{tdir}", tdir = config['TEMPDIR']),
        padding = expand("{padding}", padding = config['WES']['PADDING']),
        intervals = expand("{intervals}", intervals = config['WES']['INTERVALS']),
        other = "-G StandardAnnotation -G AS_StandardAnnotation"
    log:
        "logs/gatk_GenotypeGVCFs/{family}.log"
    benchmark:
        repeat("benchmarks/gatk_GenotypeGVCFs/{family}.tsv", 3)
    conda:
        "../envs/gatk4.yaml"
    threads: 32
    message:
        "Performing joint genotyping on one or more samples pre-called with HaplotypeCaller for {input.gvcf}"
    shell:
        "gatk GenotypeGVCFs -R {input.refgenome} -V {input.gvcf} -O {output} {params.padding} {params.intervals} {params.other} &> {log}"