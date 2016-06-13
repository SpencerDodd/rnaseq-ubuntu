for f in `cat files`; do STAR --genomeDir /Users/sdodd/Data/R_practice/GRCh38 \
--readFilesIn fastq/$f\_1.fastq fastq/$f\_2.fastq \
--runThreadN 12 --outFileNamePrefix aligned/$f.; done
