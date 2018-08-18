# What size of square should the end result be?
$instagram_image_size=2000

# Where should the go?  By default this is relative to the current set, but you could put all IG images 
# from all sets to somewhere specific,  by doing something like:
# $instagram_image_directory = '/home/fred/Desktop/All-my-Instagram-Versions-of-Images'
$instagram_image_directory = 'instagram-versions'

# Add something to the start of the filename so e.g. image.jpg becomes IG-image.jpg
$instagram_suffix = "IG-"

# If you use the POST options in TOG you can make it automatically generate the instagram images as it moves
# images to the final directory
$autocreate_instagram_when_moving_to_finals = "yes"

# Skip image create if the Instagram version already exists
$instagram_skip_if_exists = "yes"

