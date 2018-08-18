# INSTAGRAMMER EXTENTION ACTIONS

if $menu_select == 'resize'
  debug(1, "Starting Resizer Action")
  
  jpgs = choose_files( $current_set + $final_image_directory, ARGV[1])

  jpgs.each do |jpg|  
    doresize jpg 
  end
end

if $menu_select == 'resizehere'
  jpgs = choose_files( '.', ARGV[1])
  jpgs.each do |jpg|
    doresize(jpg, dirslash($resized_image_directory))
  end
end