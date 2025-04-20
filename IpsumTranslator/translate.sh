#!/bin/bash


cat $1 | sed -E 's/catnip/dogchow/g; s/cat/dog/g; s/meow|meowzer/woof/g'

# ./translate.sh kitty_ipsum_1.txt | grep --color -E 'dog[a-z]*|woof[a-z]*' 

#./translate.sh kitty_ipsum_1.txt | grep --color -E 'meow[a-z]*|cat[a-z]*'

./translate.sh kitty_ipsum_1.txt > doggy_ipsum_1.txt

diff kitty_ipsum_1.txt doggy_ipsum_1.txt
diff --color kitty_ipsum_1.txt doggy_ipsum_1.txt

./translate.sh kitty_ipsum_2.txt > doggy_ipsum_2.txt
diff --color kitty_ipsum_2.txt doggy_ipsum_2.txt