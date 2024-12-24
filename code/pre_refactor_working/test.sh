#!/bin/bash

genome_file=$1
chmod 777 $genome_file
line_count=$( wc -l < "${genome_file}" )
echo "$line_count"
genome_count=$(bc -l <<< "scale=1; ($line_count / 3)")
echo $genome_count

if [[ $genome_count == ?([-+])+([0-9])?(.*([1-9])) ]]; then
    echo "you must provide the genomes in the following form:
        genome_name
        genome_path
        TRUE or FALSE
            The value of the third line is TRUE if you want your data decuplicated and FALSE if you do not want your data deduplicated"
    exit 1
fi

while read line; do



