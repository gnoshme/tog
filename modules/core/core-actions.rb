# CORE MODULE ACTIONS
debug(5, "Core Actions: Top")

if $menu_select == "power_user_help"
  togprint('h1', 'Power User Help')
  togprint('p', "You can do most things with TOG without using the menu at all with these power user commands.  All you have to do is type tog [command]")

  $power_user_help.sort.each do |help|
    puts help[0]
    togprint('p', help[1])

  end
end

if $menu_select == "help"

  allmods["core"].each do |mod|
    help_head mod
    command = mod + '_help'
    eval(command)
    puts
    puts
  end
  allmods["extensions"].sort.each do |mod|
    if allmods["installed"].include?(mod)
      help_head mod
      command = mod + '_help'
      eval(command)
      puts
      puts
    end

  end
  allmods["custom"].sort.each do |mod|
    if allmods["installed"].include?(mod)
      help_head mod
      command = mod + '_help'
      eval(command)
      puts
      puts
    end
  end


end

if $menu_select == 'install'
  if ARGV[1]
    installmod ARGV[1]
  else
    togprint('h2', "Install Which Module?")
    menu_choice = menu_from_array( allmods["notinstalled"])
    mod = allmods["notinstalled"][menu_choice]
     installmod mod
  end
  togprint('p', "Done!")
  exit
end


if $menu_select == 'uninstall'
  if ARGV[1]
    uninstallmod ARGV[1]
  else
    togprint('h2', "Uninstall Which Module?")
    menu_choice = menu_from_array( allmods["installed"])
    mod = allmods["installed"][menu_choice]
    togprint('p', "Uninstalling :: " + mod.upcase )
    are_you_sure
    uninstallmod mod
  end
  togprint('p', "Done!")

end


if $menu_select == "view"
  if $current_set
    Dir.chdir($current_set)
    command = "nohup nautilus . &"
    exec(command)
  else
    togprint('error', 'No current set selected')
  end
end


if $menu_select == "new"
  togprint('line',"Creating a new set")
  if $add_date_to_shoot_directories == 'yes'
  end
  destination = $shoots
  if $add_date_to_shoot_directories == 'yes'
    destination = destination + Time.now.to_s.split(' ').first.gsub('-','_') + '-'
  end
  if ARGV[1].nil?
    togprint('p', "Directory will be :: " + destination + 'SHOOT_CODE')
    puts "Enter your SHOOT_CODE:"
    keyb = $stdin.gets
    destination = destination + keyb.chop
    are_you_sure "Are you sure you want to create " + destination
    createset_action destination
    save_current_set destination
  else
    destination = destination + ARGV[1]
    createset_action destination
    save_current_set destination
    load_current_set('yes')
  end

end


if $menu_select && $menu_select[0..3] == 'post'
   eval($menu_select)
end


if $menu_select == 'find'
  if ARGV[1].nil?
    puts "What do you want to find?"
    keyb = $stdin.gets
    searchstring =  keyb.chop
    puts
  else
    searchstring = ARGV[1]
  end

  matches = []
  allsets.each do |set|
     if set.include? searchstring
        matches << set 
     end
  end
  
  if matches.count == 0
    togprint('h2', "No Matches")
  else
    if matches.count == 1 
      set_choice = matches[0]
    else
      menu_array = []
      matches.each do |dir|
        menu_array  <<  dir.split('/').last 
      end   
      choice = menu_from_array menu_array
      set_choice = matches[choice]
    end
    save_current_set set_choice, 'yes'
    
  end
end


if $menu_select == 'switch'
  dirs = Dir.glob( $shoots + '/*').map(&File.method(:realpath)).select {|f| File.directory? f} 
  choice = menu_from_array dirs
  puts dirs[choice]
  save_current_set(dirs[choice])
end


if $menu_select == 'exit'
  puts "Bye!"
  exit
end
