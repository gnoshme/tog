# INSTAGRAMMER EXTENTION ACTIONS

if $menu_select == 'resize'
  debug(1, "Starting Resizer Action")
  
  pics = choose_files( $current_set + $final_image_directory, ARGV[1])

  pics.each do |pic|  
    doresize pic 
  end
end

if $menu_select == 'resizehere'
  pics = choose_files( '.', ARGV[1])
  pics.each do |pic|
    doresize(pic, dirslash($resized_image_directory))
  end
end