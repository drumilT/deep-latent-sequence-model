CUDA_VISIBLE_DEVICES=2 bash scripts/train_lm.sh iwslt 1
CUDA_VISIBLE_DEVICES=2 bash scripts/train_lm.sh iwslt 0
CUDA_VISIBLE_DEVICES=3 bash ./scripts/train_classifier_iwslt.sh
 CUDA_VISIBLE_DEVICES=2,3 time bash scripts/iwslt/train_iwslt.sh
