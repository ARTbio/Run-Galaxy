### Mouse Genetics Training: Command lines

```
ll

gunzip GKG-13.fastq.gz

ll

more GKG-13.fastq

wc -l  GKG-13.fastq

grep -c -e "^@" GKG-13.fastq

python

cat  GKG-13.fastq | grep CTGTAGG | wc -l

grep -c "CTGTAGG" GKG-13.fastq

cat  GKG-13.fastq | grep ATCTCGT| wc -l

cat GKG-13.fastq | perl -ne 'print if /^[ATGCN]{22}CTGTAGG/' | wc -l

cat GKG-13.fastq | perl -ne 'if (/^(.+CTGTAGG)/) {print "$1\n"}' | more

cat GKG-13.fastq | perl -ne 'if (/^([GATC]{18,})CTGTAGG/) {$count++; print ">$count\n"; print "$1\n"}' > clipped_GKG13.fasta

bowtie-build ../dmel/Dmel_r5.49.fa Dmel_r5.49

bowtie ../dmel/Dmel_r5.49 -f clipped_GKG13.fasta -v 1 -k 1 -p 6 --al droso_matched_GKG-13.fa --un unmatched_GKG13.fa -S > GKG13_bowtie_output.sam

samtools view -Sb GKG13_bowtie_output.sam > GKG13_bowtie_output.bam

samtools view -Sb GKG13_bowtie_output.sam | samtools sort -@ 4 - GKG13_bowtie_output_sorted

```
