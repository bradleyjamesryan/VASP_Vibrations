#!/bin/bash

count=1
for f in *; do
    if [ -d "$f" ]; then
		cd $f
		
		rm *.gif


		convert -delay 5 -loop 0 *top* $f"_top.gif";
		convert -delay 5 -loop 0 *side* $f"_side.gif";
		convert -delay 5 -loop 0 *bottom* $f"_bottom.gif";
		gifsicle -i $f"_top.gif" -O3 --colors 128 -o $f"_top_compressed.gif"
		gifsicle -i $f"_side.gif" -O3 --colors 128 -o $f"_side_compressed.gif"
		gifsicle -i $f"_bottom.gif" -O3 --colors 128 -o $f"_bottom_compressed.gif"
		
		rm *_top.gif
		rm *_side.gif
		rm *_bottom.gif
		

		echo $f
	cd ..
	fi
	count=$(($count+1))
done
mkdir CompressedGIFs
find . -name *.gif -exec mv {} CompressedGIFs/. \;

