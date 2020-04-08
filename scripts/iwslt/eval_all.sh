# export CUDA_VISIBLE_DEVICES=0

SCRIPT=./scripts/iwslt
printf "\ntranslate iwslt to mordern\n"
$SCRIPT/translate_iwslt.sh $1 data/iwslt/test_0.txt data/iwslt/test_0.attr transfer_modern.txt

printf "\niwslt -> modern bleu\n\n"
path=$1transfer_modern.txt
./multi-bleu.perl data/iwslt/test_1.txt < $path

printf "\ntranslate modern to iwslt\n"
$SCRIPT/translate_iwslt.sh $1 data/iwslt/test_1.txt data/iwslt/test_1.attr transfer_iwslt.txt

printf "\nmodern -> iwslt bleu\n\n"
path=$1transfer_iwslt.txt
./multi-bleu.perl data/iwslt/test_0.txt < $path

path0=$1transfer_modern.txt
path1=$1transfer_iwslt.txt
printf "\nLM test_1\n\n"
$SCRIPT/eval_lm.sh 0 pretrained_lm/iwslt_style0/model.pt $path1 data/iwslt/test_1.attr
printf "\nLM test_0\n\n"
$SCRIPT/eval_lm.sh 1 pretrained_lm/iwslt_style1/model.pt $path0 data/iwslt/test_0.attr

printf "\ntranslate entire test\n\n"
$SCRIPT/translate_iwslt.sh $1 data/iwslt/test.txt data/iwslt/test.attr transfer_entire_test.txt

path=$1transfer_entire_test.txt
printf "\entire test self BLEU score\n\n"
./multi-bleu.perl data/iwslt/test.txt < $path

printf "\nentire test classification\n\n"
$SCRIPT/iwslt_classify_test.sh $path data/iwslt/test.attr
