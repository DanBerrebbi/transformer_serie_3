#!/bin/bash


josep=/nfs/RESEARCH/crego/projects/PrimingNMT-2/

vocab=$PWD/minmt-vocab.py
setup=$PWD/minmt-setup.py
train=$PWD/minmt-train.py
avrge=$PWD/minmt-average.py
trans=$PWD/minmt-translate.py

tokenizer=$josep/MiNMT/tools/tokenizer.py
data=$josep/data
stovec=$josep/stovec

    dir=$josep/minmt_base
    dnet=$PWD/model_serie



rm -r data_corpus
mkdir "data_corpus"

	for corpus in ECB EMEA Europarl GNOME JRC-Acquis KDE4 news-commentary-v14 TED2013 Wikipedia; do
	    echo $corpus
      echo train ...
	    fsrc=$stovec/clean.$corpus.en-fr.en.trn.bpe.vec.max_sim0.5_k5_n0_t0.8.src
      ftgt=$stovec/clean.$corpus.en-fr.en.trn.bpe.vec.max_sim0.5_k5_n0_t0.8.tgt
	    fsim=$stovec/clean.$corpus.en-fr.en.trn.bpe.vec.max_sim0.5_k5_n0_t0.8.sim
	    fpre=$stovec/clean.$corpus.en-fr.en.trn.bpe.vec.max_sim0.5_k5_n0_t0.8.pre
	    cat $fsrc >> data_corpus/trn_src
	    cat $ftgt >> data_corpus/trn_tgt
	    cat $fsim >> data_corpus/trn_sim
	    cat $fpre >> data_corpus/trn_pre
	    echo train ok

	    echo val ...
	    fsrc=$stovec/clean.$corpus.en-fr.en.val.bpe.vec.sim0.5_k5_n0_t0.8.src
	    ftgt=$stovec/clean.$corpus.en-fr.en.val.bpe.vec.sim0.5_k5_n0_t0.8.tgt
	    fsim=$stovec/clean.$corpus.en-fr.en.val.bpe.vec.sim0.5_k5_n0_t0.8.sim
	    fpre=$stovec/clean.$corpus.en-fr.en.val.bpe.vec.sim0.5_k5_n0_t0.8.pre
	    cat $fsrc >> data_corpus/val_src
	    cat $ftgt >> data_corpus/val_tgt
	    cat $fsim >> data_corpus/val_sim
	    cat $fpre >> data_corpus/val_pre
	    echo val ok

   echo corpus suivant :

done


echo nettoyage des lignes avec sim vide ...

python3 remove_empty_lines.py

rm data_corpus/trn_src data_corpus/trn_sim data_corpus/trn_pre data_corpus/trn_tgt data_corpus/val_src data_corpus/val_sim data_corpus/val_pre data_corpus/val_tgt