source activate qiime1

extract_barcodes.py -f 180626Alm_D18-5868_f.fq.lt -c barcode_in_label --char_delineator '#' --bc1_len 12

source deactivate qiime1
gzip barcodes.fastq 
cp barcodes.fastq.gz 180626Alm_buildings

