check_gem_installed('ffi-gphoto2')

require 'gphoto2'

def tether_help
	togprint('p', "THIS ONE IS TRICKY - THERE IS NO WAY IT'S GOING TO WORK WITHOUT YOU DOING SOME CONFIGURATION IN THE SETTINGS FILE")
end

$set_menu << "tether|TETHER shoot camera"
