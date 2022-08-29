# Sequence-conserved Active Enhancer-like Elements

The present repository contains the sequence-conserved active enhancer-like elements (AELEs)
identified in 106 human tissues and cell types and the corresponding source codes. 

If you find any part of this repository useful for your work,
please kindly cite the following research article:

> Zhu, X., Ma, S. & Wong, W.H.
> Genetic effects of sequence-conserved enhancer-like elements on human complex traits.
> *bioRxiv* (2022) <https://doi.org/10.1101/2022.08.19.504589>.

Correspondence should be addressed to X.Z. (`xiangzhu[at]psu.edu`) and W.H.W (`whwong[at]stanford.edu`).

## Source Data

The [data](data) folder provides the source data of this study.
The MD5 hash of each file is provided to help users verify the file integrity.

The `omnibus_bed.zip` file provides the following files.

| Name                       | Description      |
|----------------------------|------------------|
| `merge_human.bed`          | Omnibus AELEs    |
| `merge_human_mouse_01.bed` | LC omnibus AELEs |
| `merge_human_mouse_05.bed` | MC omnibus AELEs |
| `merge_human_mouse_09.bed` | HC omnibus AELEs |

Each row of each BED file in `omnibus_bed.zip` defines an omnibus AELE,
indicated by the chromosome, start and end positions.

```bash
$ head -n 1 omnibus_bed/merge_human_mouse_09.bed
chr1	746181	746729
```

The `context_specific_bed.zip` file provides the following files.

| Name                 | Description               |
|----------------------|---------------------------|
| `human.bed`          | Context-specific AELEs    |
| `human_mouse_01.bed` | LC context-specific AELEs |
| `human_mouse_05.bed` | MC context-specific AELEs |
| `human_mouse_09.bed` | HC context-specific AELEs |

Each row of each BED file in `context_specific_bed.zip` defines
an AELE together with the tissue or cell type from which it is derived.
For example, `chr1:1167581-1168822` shown below is a HC context-specific AELE derived from the A549 cell line.

```bash
$ head -n 1 context_specific_bed/human_mouse_09.bed
chr1	1167581	1168822	A549
```

All the BED files are based on the GRCh37 (hg19) genome assembly. 

## Source Codes
