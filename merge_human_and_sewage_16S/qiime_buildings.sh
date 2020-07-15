module load seas-anaconda3
source activate /project/linglab/envs/qiime2-2019.10
mkdir /project/linglab/users/xy43/tmp
export TMPDIR='/project/linglab/users/xy43/tmp'
echo $TMPDIR


#remember to use the EMP format, the forward file has to be called forward.fastq.gz, reverse file has to be called reversse.fastq.gz, barcode has to be called barcode.fastq.gz
gzip 180626Alm_D18-5868_f.fq.lt
gzip 180626Alm_D18-5868_r.fq.lt
cp 180626Alm_D18-5868_f.fq.lt.gz 180626Alm_buildings/forward.fastq.gz
cp 180626Alm_D18-5868_r.fq.lt.gz 180626Alm_buildings/reverse.fastq.gz
 
#1. Make qiime 'artifact'
qiime tools import \
  --type EMPPairedEndSequences \
  --input-path 180626Alm_buildings \
  --output-path buildings.qza

#2. 
qiime demux emp-paired \
  --m-barcodes-file buildings_barcodes.txt \
  --m-barcodes-column barcode-sequence \
  --p-no-golay-error-correction \
  --i-seqs buildings.qza \
  --o-per-sample-sequences demux_buildings.qza \
  --o-error-correction-details demux_buildings_details.qza

qiime demux summarize \
  --i-data demux_buildings.qza \
  --o-visualization demux_buildings.qzv

#3.Dada2 denoising, to keep consistent with lifelines data, use no forward trim but trim reverse to 155
#qiime dada2 denoise-paired \
  --i-demultiplexed-seqs demux_buildings.qza \
  --p-trim-left-f 0 \
  --p-trim-left-r 0 \
  --p-trunc-len-f 175 \
  --p-trunc-len-r 155 \
  --o-table buildings-table.qza \
  --o-representative-sequences buildings-rep-seqs.qza \
  --o-denoising-stats buildings-denoising-stats.qza \
  --p-n-threads 12

qiime feature-table summarize \
  --i-table buildings-table.qza \
  --o-visualization buildings-table.qzv \
#  --m-sample-metadata-file buildings-metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data buildings-rep-seqs.qza \
  --o-visualization buildings-rep-seqs.qzv

qiime tools export \
  --input-path buildings-table.qza \
  --output-path buildings-table

qiime tools export \
  --input-path buildings-rep-seqs.qza \
  --output-path buildings-rep-seqs

qiime tools export \
  --input-path buildings-denoising-stats.qza \
  --output-path buildings-denoising-stats

qiime vsearch cluster-features-de-novo \
  --i-table buildings-table.qza \
  --i-sequences buildings-rep-seqs.qza \
  --p-perc-identity 0.99 \
  --o-clustered-table buildings-table-dn-99.qza \
  --o-clustered-sequences buildings-rep-seqs-dn-99.qza

qiime tools export \
  --input-path buildings-rep-seqs-dn-99.qza \
  --output-path buildings-rep-seqs-dn-99

qiime tools export \
  --input-path buildings-table-dn-99.qza \
  --output-path buildings-table-dn-99

