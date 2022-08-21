#!/bin/bash

# peak files and tissue/cell type input
# no header line is expected
hg19_H3K27ac_data="$1" #e.g. hg19_ac_large_intestine_embryo_ENCFF906VKA.bed, downloaded from https://www.encodeproject.org/ experiment ID: ENCFF906VKA
hg19_open_data="$2" #e.g. hg19_open_large_intestine_embryo_ENCFF276FKY.bed, downloaded from https://www.encodeproject.org/ experiment ID: ENCFF276FKY
tissue="$3" #e.g. hg19_large_intestine_embryo

# specify the location where the liftover is installed. The liftOver command line tool could be downloaded from https://genome-store.ucsc.edu/
${liftover_path}="liftover_path"

# intersect the H3K27ac peaks and paired chromatin highly accessible peaks. 	Bedtools could be downloaded from https://bedtools.readthedocs.io/en/latest/content/installation.html
bedtools intersect -a ${hg19_H3K27ac_data} -b ${hg19_open_data} -wa -u | sort -k1,1 -k2,2n > ${tissue}_ac_open.bed

# Only keep the location info of these open H3K27ac peaks 
awk 'BEGIN{OFS="\t"} {print $1,$2,$3,$1":"$2":"$3}' ${tissue}_ac_open.bed > input_${tissue}_ac_open.bed

# with liftOver, map these open H3K27ac peak sequences in human to mouse genome to obtain the sequence-conserved active regulatory elements between these two species
# hg19ToMm10.over.chain.gz file could be downloaded from https://hgdownload.soe.ucsc.edu/gbdb/hg19/liftOver/
# put hg19ToMm10.over.chain.gz file in the current folder
# -minMatch thresholds: 0.1, 0.5 and 0.9
${liftover_path}/liftOver -minMatch=0.1 input_${tissue}_ac_open.bed   hg19ToMm10.over.chain.gz hg19tomm10_01_${tissue}_ac_open.bed unmap_hg19tomm10_01_${tissue}_ac_open.bed
${liftover_path}/liftOver -minMatch=0.5 input_${tissue}_ac_open.bed   hg19ToMm10.over.chain.gz hg19tomm10_05_${tissue}_ac_open.bed unmap_hg19tomm10_05_${tissue}_ac_open.bed
${liftover_path}/liftOver -minMatch=0.9 input_${tissue}_ac_open.bed   hg19ToMm10.over.chain.gz hg19tomm10_09_${tissue}_ac_open.bed unmap_hg19tomm10_09_${tissue}_ac_open.bed

# extract the human sequences with of highly (0.9), moderately (0.5) and lowly (0.1) sequence-conserved regulatory regions
# output files: hg19_mm10_01/05/09_${tissue}_ac_open.bed
cut -f 4 hg19tomm10_01_${tissue}_ac_open.bed > hg19_mm10_01_${tissue}_ac_open.bed
cut -f 4 hg19tomm10_05_${tissue}_ac_open.bed > hg19_mm10_05_${tissue}_ac_open.bed
cut -f 4 hg19tomm10_09_${tissue}_ac_open.bed > hg19_mm10_09_${tissue}_ac_open.bed
sed -i "s/:/\t/g" hg19_mm10_01_${tissue}_ac_open.bed
sed -i "s/:/\t/g" hg19_mm10_05_${tissue}_ac_open.bed
sed -i "s/:/\t/g" hg19_mm10_09_${tissue}_ac_open.bed


