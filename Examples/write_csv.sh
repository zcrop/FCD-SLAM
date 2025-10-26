#!/bin/bash

# Input file
input_file="ExecMean.txt"

# Output CSV file
output_file="${1}".csv

# Write the header to the output CSV
echo "Stage,Time (ms)" > "$output_file"

# Extract relevant lines and process them
grep -E "Extraction|Pose Prediction|LM Track|Total Tracking|Total Local Mapping" "$input_file" | while IFS=':' read -r stage value; do
    # Replace any commas in stage names with spaces
    stage=$(echo "$stage" | tr ',' ' ')
    
    # Trim any leading or trailing whitespace
    stage=$(echo "$stage" | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Remove everything after $ in value
    value=$(echo "$value" | sed 's/\$.*//')

    # Trim any leading or trailing whitespace from value
    value=$(echo "$value" | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Write to CSV
    echo "$stage,$value" >> "$output_file"
done

echo "Data extraction complete. Output written to $output_file."

