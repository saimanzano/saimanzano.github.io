---
title: 'Nice phylogenetic trees with ggtree'
date: 2024-02-26
permalink: /posts/2024/02/nice-trees/
tags:
  - dataviz
  - phylogeny
  - R
---

This is a simple tutorial on how to do a good-looking tree in R, using the package `ggtree`. For reference, I will show how to do the Archaeal Tree of Life, as calculated by the [GTDB](https://gtdb.ecogenomic.org/).

![ArchaealTOL](/_posts/ArchaealTree-nopic.png "Archaeal Tree of Life")

## The code 
We will use the following libraries 
```
library(ggtree); library(phytools); library(tidyverse)
```
First we will need to load the tree (Newick format) and the corresponding annotations. The annotations are for all archaeal genomes in GTDB, whereas the tree only contains species representatives, so we will filter the annotations so that only those that are in the tree are kept.

```
tree <- read.newick(treefile)
annotation <- read.csv(annotationfile, sep="\t", header=F, row.names=1)
annotation <- annotation[which(annotation$ID %in% tree$tip.label),]

```
We will also take the chance to clean up the names (removing prefixes) and split the taxonomy into several columns:

```
annotation$Taxonomy <- gsub("[dpcofgs]__", "", annotation$Taxonomy)
annotation <- data.frame(annotation %>% separate_wider_delim(Taxonomy, ";", names = c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species")))
```

The tree has to many tips to plot, which makes the code run longer. One thing we can do is to prune the tree, keeping one tip per genus:

```
annotation <- data.frame(annotation %>% group_by(Genus) %>% sample_n(1))
tree <- drop.tip(tree,tree$tip.label[-which(tree$tip.label %in% annotation$ID)])
```

Since the taxonomic units in GTDB are monophyletic, we can generate a table with the node of the MRCA of each taxonomic unit (in my case, phyla) to aid us with the mapping in ggtree later:

``` 
MRCAs <- data.frame(unlist(sapply(unique(annotation$Phylum), function(x) {findMRCA(tree, tips=annotation[which(annotation$Phylum== x), "ID"])})))
colnames(MRCAs) <- c("Node")
MRCAs$Name <- rownames(MRCAs)
MRCAs$mycols <- hcl.colors(nrow(MRCAs), "Dark3")
```
Finally, we can get to plotting!

```
p <- ggtree(tree, layout= "equal_angle", branch.length = "none") +
geom_hilight(data=MRCAs, mapping= aes(node=Node, fill=mycols), alpha=0.3, extend=2) + 
geom_cladelab(data=MRCAs, mapping=aes(node=Node, label=Name, color=mycols), offset=1.2, barsize=1, align=T) + theme(legend.position = "none") 
```
We can export the plot with cairo_pdf and tweak the resulting PDF (e.g with Inkscape) until we are satisfied with the result:

```
cairo_pdf("Tree.pdf")
p
dev.off()
```
