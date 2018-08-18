check_gem_installed('mini_magick')

require 'mini_magick'

def resizer_help
  togprint('h1', "Resizer")
  togprint('p', 'blablabla')
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