$export_to = Dir.home + '/Pictures/tog-export'

$ignore_sets_where_name_includes = "-noexport"
$ignore_files_where_name_includes ="web, resized"
$export_final_image_directory = "yes"
$export_extra_directories = "exported/final-images, exported, exported/finals, 3-finals"
$offer_export_during_archive_dialog = "yes"

# A COUPLE OF OPTIONS TO MAKE THINGS FASTER
$use_resizer_images_if_available = "yes"
$use_symbolic_links_instead_of_copy = "no"

# IGNORED IF SYMBOLIC LINKS USED
# INGORED IF RESIZER VERSIONS USED
$export_and_resize = "yes"
$export_resize_size = "3000x3000"


# EXPERIMENTAL - UNDOCUMENTED - DON'T EVEN ASK ME ABOUT IT
$try_and_group_set_by_changing_exif = "no"
