csv2json $1 |sed -e's/\[//' -e's/\]//' -e's?},?}\'$'\n?g'
