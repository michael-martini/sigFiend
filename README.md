# sigFiend
Simple Bash script to extract basic images hidden using steganography via file signatures

Overview
--------
I wanted to create a simple tool to 1) expand my skills in Bash scripting and 2) provide a straightforward way to extract images (PNG, JPG, GIF) for digital forensic purposes.

The code will read in an input file from the same directory as the script and, if it finds any of the file signatures from the array, it will find the file signatures and take note of how many there are in the image (It will ignore the first image as most images will be fed in as one of the above). Finally, it will go through each of the found images and give the user information on where it found the image and export it to a created directory in the directory of the script. 

Hope you enjoy!
