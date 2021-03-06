split -l $[ $(wc -l data.dis|cut -d" " -f1) * 70 / 100 ] data.dis dis
split -l $[ $(wc -l data.flu|cut -d" " -f1) * 70 / 100 ] data.flu flu  
#split -l 154174 data.dis dis
#split -l 154174 data.flu flu
mv disaa train_0.txt
mv fluaa train_1.txt
split -l $[ $(wc -l disab|cut -d" " -f1) * 50 / 100 ] disab dis2
split -l $[ $(wc -l fluab|cut -d" " -f1) * 50 / 100 ] fluab flu2
#split -l 19272 disab dis2
#split -l 19272 fluab flu2
mv dis2aa dev_0.txt
mv dis2ab test_0.txt
mv flu2aa dev_1.txt
mv flu2ab test_1.txt
cat train_0.txt > train.txt
cat train_1.txt >> train.txt
cat dev_0.txt > dev.txt
cat dev_1.txt >> dev.txt
cat dev_1.txt > dev_ref.txt
cat dev_0.txt >> dev_ref.txt
cat test_0.txt > test.txt
cat test_1.txt >>test.txt
cat test_1.txt > test_ref.txt
cat test_0.txt >>test_ref.txt
sed -r "s/.*/disfluent/g" dev_0.txt > dev_0.attr
sed -r "s/.*/disfluent/g" train_0.txt > train_0.attr
sed -r "s/.*/disfluent/g" test_0.txt > test_0.attr 
sed -r "s/.*/fluent/g" dev_1.txt > dev_1.attr
sed -r "s/.*/fluent/g" train_1.txt > train_1.attr
sed -r "s/.*/fluent/g" test_1.txt > test_1.attr 
cat test_0.attr > test.attr
cat test_1.attr >> test.attr
cat dev_0.attr > dev.attr
cat dev_1.attr >> dev.attr
cat train_0.attr > train.attr
cat train_1.attr >> train.attr
echo "fluent" > attr.vocab
echo "disfluent" >> attr.vocab
echo "<unk>" > text.vocab
echo "<pad>" >> text.vocab
echo "<s>" >> text.vocab
echo "</s>" >> text.vocab
#grep -o -E '\w+' data.dis | sort -u -f > temp
#grep -o -E '\w+' data.flu | sort -u -f >> temp
cat data.dis | tr " " "\n" | sort -u > temp2
cat data.flu | tr " " "\n" | sort -u >> temp2
sort -u  temp2 >> text.vocab
rm dis*a* flu*a*
rm temp
