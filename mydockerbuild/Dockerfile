FROM ubuntu:14.04
MAINTAINER Spencer Dodd <sdodd@broadinstitute.org>
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --force-yes \
    curl \
    g++ \
    make \
    python \
    libboost-dev \
    libboost-thread-dev \
    libboost-system-dev \
    zlib1g-dev \
    ncurses-dev \
    unzip \
    gzip \
    bzip2 \
    libxml2-dev \
    libxslt-dev \
    python-pip \
    python-dev \
    git \
    s3cmd \
    time \
    wget \
    python-virtualenv \
    default-jre \
    default-jdk

RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo && echo "ubuntu    ALL=(ALL)   NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu
ENV HOME /home/ubuntu
USER ubuntu
RUN mkdir ${HOME}/bin
WORKDIR ${HOME}/bin

#install STAR 2.4.0f1
RUN wget https://github.com/alexdobin/STAR/archive/STAR_2.4.0f1.tar.gz && tar xzvf STAR_2.4.0f1.tar.gz 

#download Samtools 1.1
RUN wget http://sourceforge.net/projects/samtools/files/samtools/1.1/samtools-1.1.tar.bz2 && tar xf samtools-1.1.tar.bz2 && mv samtools-1.1 samtools
WORKDIR ${HOME}/bin/samtools/
RUN make
WORKDIR ${HOME}/bin

#remove the compressed files
RUN rm *.gz *.bz2

USER ubuntu

ENV PATH ${PATH}:${HOME}/bin/FastQC:${HOME}/bin/STAR-STAR_2.4.0f1/bin/Linux_x86_64:${HOME}/bin/biobambam/bin:${HOME}/bin/samtools/:${HOME}/bin/cufflinks-2.2.1.Linux_x86_64/
USER root

RUN pip install lxml
RUN pip install s3cmd --user
ENV rna_seq_star_cuff 1.7
WORKDIR ${HOME}

# Set up our RNA seq env
RUN mkdir annotated_genome
RUN curl -O ftp://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz
RUN curl -O ftp://ftp.ensembl.org/pub/release-75/gtf/homo_sapiens/Homo_sapiens.GRCh37.75.gtf.gz

# Decompress our genome and annotations
RUN gzip -d *.gz

# make result dir 'indices'
RUN mkdir indices

# make shell script that runs the annotation automation
RUN echo STAR --runMode genomeGenerate --genomeDir /home/ubuntu/annotated_genome/indices \
--genomeFastaFiles /home/ubuntu/annotated_genome/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa \
--sjdbGTFfile /home/ubuntu/annotated_genome/Homo_sapiens.GRCh37.75.gtf \
--sjdbOverhang -1 \
--runThreadN 12 >> run_star.sh
RUN chmod +x run_star.sh

# move everything to the right place
RUN mv Homo_sapiens.GRCh37.75.dna.primary_assembly.fa annotated_genome
RUN mv Homo_sapiens.GRCh37.75.gtf annotated_genome
RUN mv indices annotated_genome
RUN mv run_star.sh annotated_genome

# change all permissions to write
RUN chmod -R +wrx annotated_genome













