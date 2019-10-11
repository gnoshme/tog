check_gem_installed('mini_magick')

require 'mini_magick'

def resizer_help
  togprint('p', 'The resizer extension allows you to easily (and even automatically) create resized versions of your final images. ')
  togprint('p', "If you are using tog workflows, you can also have tog auto generate a resized file when you do the last POST step in your workflow.")
  togprint('p', "Poweruser Bonus :: Run 'tog resizehere' in ANY directory on your file system and tog will create resized versions of any images found there.")
end


$set_menu << "resize|RESIZE Images"
if $autocreate_resized_when_moving_to_finals == 'yes'
	$post_final_tasks << 'doresize'
end

def doresize original, dir = dirslash($current_set + $resized_image_directory)
  if Dir.exists?(dir) == false  
    FileUtils.mkdir_p(dir)
  end
  destination = dir + filename(original)
  if File.exists?(destination) && $resized_skip_if_exists == 'yes'
    puts "RESIZE :: Skipping (Exists) :: " + filename(original)
  else
    puts "RESIZE :: " + filename(original)
    image = MiniMagick::Image.open(original)
    image.resize $resized_image_size
    image.format "jpg"
    image.write destination
  end
end