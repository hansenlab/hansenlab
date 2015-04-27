# Some tips and tricks for efficient alignments 


Jp: Here is how I align my reads for Hi-C data (separately for each end):

	bowtie -p 10 --best --suppress 5,6,7,8 --chunkmbs 250 -m 1 ~/hg19/hg19 -q <(zcat myfile.fastq.gz) myfile.sam

I use `-p NN` to use NN core (note that this will be useful only if you requested a node with 10 cores `qrsh -pe NN`). For my specific dataset, I use `--best` to keep only the best alignmnent for each read and I allow only one mismatch by specifying `-m 1`. Then I provide the path of my genome index `~/hg19/hg19`, and specify what is my input file with `-q <(zcat myfile.fastq.gz)`. Because Bowtie does not handle gzipped files, I use `zcat`, which is equivalent to `gunzip -c`, to unzip the file and feed it to Bowtie; this will ensure that your original zipped file will not be modifed. Then I provide my outpuf filename (a text file) with `myfile.sam`. 




