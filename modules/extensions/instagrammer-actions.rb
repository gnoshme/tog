# INSTAGRAMMER EXTENTION ACTIONS

if $menu_select == 'ig'
  debug(1, "Starting IG Action")
  
  pics = choose_files( $current_set + $final_image_directory, ARGV[1])

  igprocess(pics, $instagram_threads)
end

if $menu_select == 'ighere'
  pics = choose_files( '.', ARGV[1])
  igprocess(pics, $instagram_threads, true)
end

if $menu_select == 'igthis'
	igactual ARGV[1], ARGV[2]
end
