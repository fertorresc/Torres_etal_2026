Budding Test Pipeline (BEAST 33% HDP)

 Orthofinder

1057 .fasta files

 StarBEAST

input: XML generated with BEAUti

output: 1507 .tree files, each containing 500 trees (STATE)

I create mkdir trearboles and move the old .tre files there, keeping only the new .trees

the bin folders contain repeated trees

I merged all bins into a single file: final_updated_consolidated_starbeast3.xml

I merged all XMLs into one and ran StarBEAST again with
./beast -beagle -threads 40 attached_file.xml

-10%

+LogCombiner

 TreeAnnotator

1507 .tre files with a single tree each

I verify the number of trees in each file with
grep -o "STATE" *.tree | wc -l

I run bash treano.sh

07% HDP will collapse branches with less than 33% posterior probability. There will still be 1507 .tre files, each with a single tree

 PhyParts

 Test paraphyly

To test the code with rbcL
