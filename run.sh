#!/bin/bash

TABLE=0
dir=0
loop=0
temp=0
while [ $loop -le 1 ]
do
	row=1
	while [ $row -le 12 ]
	do
		if [ $row -eq 1 ]
		then
			if [ $(($((TABLE - 1)) % 100)) -eq 0 ]
			then
				dir=$((dir + 1))
				temp=$((TABLE))
				mkdir 0x$((temp))-$((dir * 100))
			fi
		fi
		echo "$TABLE * $row = $((TABLE * row))" >> ./0x$((temp))-$((dir * 100))/Table_$((TABLE)).txt
		row=$((row + 1))
	done
	git add -A
	git commit -m "Compute TABLE_$((TABLE))"
	if [ $((TABLE % 200)) -eq 0 ]
	then
		git push
	fi

	if [ $? -eq 0 ]
	then
		echo "Done::::::::: Table_$((TABLE))"
	else
		echo "Error:::::::: Unable to push"
		exit -1
	fi
	TABLE=$((TABLE + 1))
done
