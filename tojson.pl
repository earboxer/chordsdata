# Parse sorted csv (key,value) into (json 'key' : ['value1', 'value2'],)
# Author: Zach DeCook

# previous name
$ln = "firstrun";

print "{";

# Read from stdin or from file passed as argument
while(<>){
	($name, $tab) = /([^,]*),([^,\n]*)/g;
	if ( $name ne $ln ){
		if ( $ln ne "firstrun" ){
			print "],\n";
		}
		print "'$name' : ['$tab'";
	}
	else {
		print ", '$tab'";
	}
	$ln = $name;
}

if ( $ln ne "firstrun" ){
	print "]"
}

print "}\n";
