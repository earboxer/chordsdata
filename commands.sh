# Sorts csv files, pipes through tojson.pl to create json and js files
# Run like ./commands.sh
# Author: Zach DeCook

for filename in chords ukulelechords; do

if [ "$(uname)" == "Darwin" ]; then
	# sed on macos doesn't like \t, needs verbatim tab
	cat -n "$filename.csv" | sed 's/^ *\([0-9]*\)	/\1,/g' |
	 sort -t',' -k2,2 -k1,1 | sed "s/[^,]*,\([^,]*,.*\)/\1/" |
	 uniq | perl tojson.pl > "$filename.json"
else
	# sed on unix (gnu-sed) is fine with \t
	cat -n "$filename.csv" | sed 's/^ *\([0-9]*\)\t/\1,/g' |
	 sort -t',' -k2,2 -k1,1 | sed "s/[^,]*,\([^,]*,.*\)/\1/" |
	 uniq | perl tojson.pl > "$filename.json"
fi
echo -n "var $filename" > "$filename.js"
echo "Dict = " >> "$filename.js"
cat "$filename.json" >> "$filename.js"

done
