if $menu_select == 'import'
	if $current_set
		doimport
	else
		togprint('error', "Importer puts files into the current set - and you don't have one.")
	end
end