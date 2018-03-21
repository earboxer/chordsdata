# Sorts chords.csv, pipes through tojson.pl
# Run like ./commands.sh > chords.json
# Author: Zach DeCook

if [ "$(uname)" == "Darwin" ]; then
	# sed on macos doesn't like \t, needs verbatim tab
	cat -n chords.csv | sed 's/^ *\([0-9]*\)	/\1,/g' |
	 sort -t',' -k2,2 -k1,1 | sed "s/[^,]*,\([^,]*,.*\)/\1/" |
	 uniq | perl tojson.pl
else
	# sed on unix (gnu-sed) is fine with \t
	cat -n chords.csv | sed 's/^ *\([0-9]*\)\t/\1,/g' |
	 sort -t',' -k2,2 -k1,1 | sed "s/[^,]*,\([^,]*,.*\)/\1/" |
	 uniq | perl tojson.pl
fi
