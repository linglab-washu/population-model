module load seas-anaconda3
source activate /project/linglab/envs/qiime2-2019.10
export TMPDIR='/project/linglab/users/xy43/tmp'
echo $TMPDIR

qiime feature-classifier classify-sklearn \
  --i-reads ./buildings-rep-seqs.qza \
  --i-classifier ../silva-132-99-515-806-nb-classifier.qza \
  --o-classification ./buildings-taxonomy.qza

#qiime feature-classifier classify-sklearn \
#  --i-reads ./buildings-rep-seqs-dn-99.qza \
#  --i-classifier ../silva-132-99-515-806-nb-classifier.qza \
#  --o-classification ./buildings-taxonomy-dn-99.qza

qiime tools export \
  --input-path buildings-taxonomy-dn-99.qza \
  --output-path buildings-taxonomy-dn-99

qiime tools export \
  --input-path buildings-taxonomy.qza \
  --output-path buildings-taxonomy
