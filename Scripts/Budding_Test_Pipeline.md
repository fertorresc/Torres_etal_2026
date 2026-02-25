---

# Budding Speciation Test Pipeline

### Phylogenomic inference using StarBEAST and HDP-based tree filtering

This repository contains the workflow used to test budding speciation signals from multilocus phylogenomic data using **StarBEAST**, posterior filtering, and gene-tree concordance analyses.

---

## Overview

The pipeline reconstructs gene trees from orthologous loci, summarizes posterior distributions, applies posterior probability filtering, and evaluates topological patterns relevant to budding speciation.

Main steps:

1. Ortholog inference
2. StarBEAST phylogenomic reconstruction
3. Run consolidation and burn-in removal
4. Posterior tree summarization
5. HDP filtering (33% posterior threshold)
6. Gene-tree concordance and paraphyly tests

---

## Input data

* **1057 FASTA files** (single-copy ortholog alignments)
* XML files generated with **BEAUti**
* BEAST-compatible configuration files

---

## Step-by-step workflow

### 1. Ortholog inference

Orthologous loci were obtained using **Orthofinder**, producing the FASTA files used as input for StarBEAST.

---

### 2. StarBEAST phylogenomic inference

**Input**

* XML generated with BEAUti

**Output**

* 1507 `.tree` files
* Each file contains **500 posterior trees** (tagged by `STATE`)

---

### 3. File organization

Old tree files are moved to a separate directory:

```bash
mkdir trearboles
```

Only the new `.trees` files are kept in the working directory.

Note: `bin/` folders produced by StarBEAST runs contain duplicated trees.

---

### 4. Run consolidation and re-analysis

Outputs from all bins are merged into a single XML file:

```
final_updated_consolidated_starbeast3.xml
```

All XMLs are combined and StarBEAST is run again:

```bash
./beast -beagle -threads 40 attached_file.xml
```

---

### 5. Burn-in removal and posterior summarization

#### LogCombiner

* Combines runs
* Removes ~10% burn-in

#### TreeAnnotator

Produces:

* **1507 `.tre` files**
* Each containing a **single summarized tree**

---

### 6. Tree verification

Number of posterior trees per file is checked with:

```bash
grep -o "STATE" *.tree | wc -l
```

---

### 7. HDP filtering (33% threshold)

Tree filtering is applied with:

```bash
bash treano.sh
```

**Effect of filtering**

* Collapses branches with posterior probability < 0.33
* Output remains:

  * 1507 `.tre` files
  * One filtered tree per locus

---

### 8. Gene-tree concordance analysis

**PhyParts** is used to evaluate:

* Concordance among loci
* Topological conflict
* Support for alternative relationships

---

### 9. Paraphyly testing

Filtered gene trees are examined to detect:

* Paraphyly patterns
* Signals consistent with budding speciation

---

### 10. Pipeline validation

To verify correct behaviour of the workflow:

* The full pipeline can be tested using **rbcL**
* This allows confirmation of:

  * tree reconstruction
  * filtering behaviour
  * concordance analysis outputs

---

## Software used

* Orthofinder
* BEAST / StarBEAST
* BEAUti
* LogCombiner
* TreeAnnotator
* PhyParts
* Custom Bash scripts

---

## Reproducibility notes

* Tree duplication in bin folders is expected behaviour from independent runs
* Posterior filtering threshold must match the HDP criterion used in the study (33%)
* Burn-in percentage should be kept consistent across runs
* Always verify tree counts before summarization

---

