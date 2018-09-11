# Where are your shoots on your drive.  
# TOG will not put actual files here.. it will create a directories for every shoot 
$shoots = Dir.home + '/shoots/'
$quicklink = Dir.home + '/current'

# Do you want TOG to add, e.g. 2020-05-05 to any shoot directory it creates for you
$add_date_to_shoot_directories = "yes"

# In a shoot directory, where will the FINAL images be kept.  This is a special location
# as many other modules want to know about your final images.
$raw_file_directory = 'raw-files'
$workflow1_directory = 'working-directory'
$workflow2_directory = ''
$workflow3_directory = ''
$workflow4_directory = ''
$workflow5_directory = ''
$final_image_directory = 'final-images'
$discards_directory = 'discards'

$during_post_actions_overwrite_if_file_already_exists = 'no'

def post1
	move_pics_to_next
end
def post2
	move_pics_to_next
end
def post3
	move_pics_to_next
end
def post4
	move_pics_to_next
end
def post5
	move_pics_to_next
end

# What other directories do you want auto created to keep your workflow clean and tidy.
# The defaults of for raws,  working and discards could be the bare minimum:
# -- raws:     where you put your raw files from the camera
# -- working:  where you export pics from your raw editor and do other work on them before moving them to the final pic directory
# -- discards: where you put pics that you've worked on but are throwing away.
#
# WHY THIS IS IMPORTANT. You can use TOG to move files from one stage to the next.  A more complex strategy could be:
# "1-raws, 2-portraitpro, 3-gimp, discards"
# In this case,  your workflow is exporting from raw editor into 2-portraitpro folder..
#  -- editing in portraitpro then moving the files to the gimp folder
#  -- working on them in gimp and then moving the final pics to the final pic directory
#
# Want any other auto-created directories?  Add them here devided by commas.
# It's ok to create directories and subdirectores,  
# e.g. "discards, discards/pics, discards/other "
$other_shoot_directories = ""


###################################################################################################################33
# Don't touch unless you know what you're doing
# The file that TOG uses to remember what set you are working on.
$current_set_file = Dir.home + '/.tog.txt'
