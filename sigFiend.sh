#!/bin/bash

#Name: sigFiend
#Purpose: Find common embedded files in files and extract them 
#Author: Mellouemeeko
#Date: 03/27/2024

#Read in user-input for input file
#Test image:"hiddenpng.jpg"
read -p "Please Enter File Name: " inputFile 

# Define an array of file signatures (default respectively: png (1), gif (1), jpg (3))
fileSignatures=("89504e470d0a1a0a" "47494638" "ffd8ffe1" "ffd8ffee" "ffd8ffe0")
foundSignatures=()

# Define variables
outputFile="_extracted"
counter=0
currentdirectory="$PWD"

# Loop through each file signature
for signature in "${fileSignatures[@]}"; do
	# Search for the file signature in the binary file
	position=$(hexdump -ve '/1 "%.2x"' "$currentdirectory/$inputFile" | grep -b -o "$signature" | cut -d ":" -f 1)
	foundSignatures+=($position)
done

# To prevent the program extracting the input file
if [ "${#fileSignatures[@]}" -ge 1 ]; then
	#Creates directory to append hidden files to
	if [ ! -d "Extracted_$inputFile" ]
	then
		mkdir "Extracted_$inputFile"
	fi
	for element in "${foundSignatures[@]}"; do
		# Exclude the initial file signature (found at position 0)
		if [ "$element" != 0 ]; then
			# Insert another if statement here to include file sigs and extensions (DO SAME WHEN DD)
			element=$((element / 2))
			printf "File signature found at position: %#x\n" "$element"
			
			# Extract content from the position of the signature
			dd if="$currentdirectory/$inputFile" of="$currentdirectory/Extracted_$inputFile/$inputFile$outputFile$counter" bs=1 skip="$element" status=none
			echo "File extracted successfully to $inputFile$outputFile$counter"
			((counter++))
		fi	
	done
else
	    printf "No embedded files found in %s" "$inputFile"
fi
