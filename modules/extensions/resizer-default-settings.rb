# What size of square should the end result be?
$resized_image_size="3600x3600"

# Where should the go?  By default this is relative to the current set, but you could put all IG images 
# from all sets to somewhere specific,  by doing something like:
# $instagram_image_directory = '/home/fred/Desktop/All-my-Instagram-Versions-of-Images'
$resized_image_directory = 'resized'

# Add something to the start of the filename so e.g. image.jpg becomes IG-image.jpg
$resized_suffix = "resized-"

# If you use the POST options in TOG you can make it automatically generate the instagram images as it moves
# images to the final directory
$autocreate_resized_when_moving_to_finals = "yes"

# Skip image create if the Instagram version already exists
$resized_skip_if_exists = "yes"

