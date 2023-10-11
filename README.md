# wg-project

 Pre-processing files with both bash and R-code chuncks stored in RMarkdown format. These are not intended to be knitted to pdf- or html-files, but to be run as code blocks (chunks), either interactively one at a time when testing, or in a single run.

-  pre_processing_step1.Rmd for bcftools sort, concat and filter of the autosome chromosomes of each sample to only include SNPs. Output is one reheaded and renamed autosome vcf-file per sample containing only SNPs and it should only by run one time for a set of samples.
-  sample1.txt, ..., sample8.txt text-files containing sample ID's used in the reheading of the samples.

-  pre_processing_step2.Rmd for processing and filtering of single samples and merged samples with bcftools and PLINK. This code file should be run one time for each filtering criteria (the user selects between two pre-defined criteria or defines his own criteria). The output is quality-filtered single-sample and merged sample vcf's as well as their PLINK filesets for further filtering e.g., for missing genotypes with PLINK.
  

 Analysis files with R-code chuncks stored in RMarkdown format. These are intended to be knitted to pdf-files in a single run, or to be run as code blocks (chunks) interactively one at a time when testing. They require input files from the output of pre_processing_step2.Rmd (or similar).
 
 - Addfile1.Rmd, ..., Addfile11.Rmd generate the output files Addfile1.pdf, ..., Addfile11.pdf that are submitted as additional files and described in the main manuscript.
 - Figure1.Rmd is a plot code file that generates the Figure 1 in the main manuscript. The Figure 2 and Figure 3 are generated from Addfile2.Rmd.
 - summary_functions.R is a R script file with own functions called from within the Addfile1-11.Rmd to minimize the repetition of code.
 - Broad Institute reference panel including both country names (pop) and regions (super_pop) downloaded with wget from https://personal.broadinstitute.org/armartin/ginger/integrated_call_samples_v3.20130502.ALL.panel.txt. It is used together with KGref.bed (too large to include here, KGref.bim, KGref.fam) as reference files for the MDS-PC analysis described in the main manuscript. This is because the popref_data from the mds-projection using KGref.bed as a reference only includes FID IID Population.
