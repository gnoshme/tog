# EXPERIMENTAL# EXPERIMENTAL# EXPERIMENTAL# EXPERIMENTAL# EXPERIMENTAL# EXPERIMENTAL

# THIS IS DEFINITELY A MORE COMPLEX SETUP THAN MOST OF THE MODULES IN TOG

# THINGS YOU WILL HAVE TO DO:
#
# 1) Install gphoto2 library (see below)
# 2) Install geeqie image viewer (google how)
# 3) Support "say".  Open a terminal and type say "hello". If it doesn't work, google it.


# GPHOTO2 LIBRARY
# =================================================================================
# Tethering is built on the gphoto2 library which you will have to install.  Google how to install gphoto2.  
# You know it works if you connect your camera, and type 
#
# gphoto2 --auto-detect
#
# and it responds with your camera.




# SETTINGS
# =================================================================================

# Use the cameras filename, or a counter.. 0001, 0002 etc.
$use_camera_filename_or_counter = "counter"

# This is the name of the file inside the RAW FILES DIRECTORY that tog will use to keep track of what prefix to use, and the file counter.
# FYI :: If you delete this file, you reset the settings for the tether session.
$tether_set_info_file = 'tog-tether.info' 

# If you say "yes" you'll have to add code to the unmount_camera section below
# Currently it's right for the first user of a ubuntu / linux based system.
$unmount_before_tether = "yes"
def unmount_camera
	if Dir.glob("/run/user/1000/gvfs/*").size > 0
		puts "Unmounting Camera"
		puts
		system("gvfs-mount -u /run/user/1000/gvfs/*")
	end
end


# RECOMMENDED that you use geeqie but basicaly any viewer that works on raw files that AUTO UPDATES IF THE FILE CHANGES!
# That last bit is important.  Tog copys each new file to preview.XXX (depending on your file extension).  geeqie is great in that
# it "just works" and will continually refresh itself as that file is changed at every shot.
# You also need a way for tog to know if the image viewer is also running.  The code below is correct for linux as far as I know.. 
# could be fine for Mac too.
$command_to_launch_image_viewer = 'geeqie'
def true_if_image_viewer_is_already_running
	if File.exists?(Dir.home + '/.config/geeqie/.command')
		return true
	else
		return false
	end
end

# This is a nice little feature.. tog will beep at you if your camera connection is lost.
# This is correct for linux 
$make_sound_on_disconnect = "yes"
def disconnect_sound
	system( 'say "Beeeeeeeep awawaaaaaa - Camera Disconnected. Fix it! "')
	#system("speaker-test -t sine -f 1000 & pid=$! ; sleep 0.5s ; kill -9 $pid")
end

# Create an audible notification ever X photos to help keep track.
$vocalize_every_x_pictures = "yes"
$vocalize_every = 100