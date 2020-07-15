#Life line data and MIT data alignmen is 1-175 matches to 24-198 
#Trim off first 23 bases, then trim such that the whole file is 175bp 
cutadapt -u 23 -l 175 -o 180626Alm_D18-5868_f.fq.lt 180626Alm_D18-5868_phiX_bestmap.qsort_01.fq
#for reverse reads, the MIT reads starts aligning at bp 21, but maybe b/c quality is bad, the end bps does ont seem to algin well with anything (most can get to is 158 bp but full length is still 175 bp
cutadapt -u 20 -l 175 -o 180626Alm_D18-5868_r.fq.lt 180626Alm_D18-5868_phiX_bestmap.qsort_02.fq
