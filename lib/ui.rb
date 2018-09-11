def gem_alert gem, text
  togprint('h1', "Problem :: Missing Ruby Gem :: " + gem )
  togprint('p', "GEMS are libraries of code in the ruby world.  You should be able to install this gem by typing:")
  togprint('p', 'gem install ' + gem)
  exit
end

def qdebug contents
  puts "::::" + contents.to_s + " ::::"
end
def debug loglevel = 1, contents
  if loglevel <= $debuglevel
    puts "::::" + contents.to_s + " ::::"
  end
end

def togprint style, contents
  case style
    when 'h1'
      header="================================================================================"
      footer="================================================================================"
      contents = contents.upcase
    when 'h2'
      header="------------------------------------------------------------"
      footer="------------------------------------------------------------"
      contents = contents
    when 'error'
      header = nil
      footer = nil
      contents = '','','!-:::::    ' + contents + '    :::::-!','',''
 
    when 'p'
      header = nil
      footer = nil
      contents = contents,''
    when 'line'
      contents = contents
    when 'ul'
      footer = '--------------------------------------------------------------------------------'
  end 
  unless header.nil?
    puts header
  end
  puts contents
  unless footer.nil?
    puts footer
  end
end


def clear_screen
    if $debuglevel > 0
    debug(3, "CLEARSCREEN")
  else
    system('clear')
  end
end


def menu_from_array array, prompt="Pick One"
  array.each do |element|
    
    menu_item = (array.index(element)+1).to_s.rjust(4, ' ') + ') ' + element
    puts menu_item
  end
  puts
  puts prompt
  keyb = $stdin.gets
  choice = keyb.chomp.to_i - 1
  return choice
end


def are_you_sure prompt="Are you sure?"
  puts prompt + "  y/N"
  choice = $stdin.gets
  unless choice.chomp == "y"
    exit
  end
  system('clear')
end

def yes_no prompt
  puts prompt + "  y/n"
  choice = $stdin.gets
  return choice.chomp.downcase
end



def cont prompt="Press ENTER to continue.."
  puts prompt
  choice = $stdin.gets
end


def main_menu global_menu, set_menu=nil, prompt="Pick One"
  menu_actions = {}
  menu_count = 1
  unless set_menu.nil?
    puts "Current Set Menu"
    set_menu.each do |item|
      puts menu_count.to_s.to_s.rjust( 2, ' ') + ') ' + item.split('|').last
      menu_actions[menu_count.to_s ] = item.split('|').first
      menu_count += 1
    end
    puts 
  end
  
  puts "Main Menu"
  global_menu.each do |item|
    puts menu_count.to_s.rjust( 2, ' ') + ') ' + item.split('|').last
    menu_actions[menu_count.to_s] = item.split('|').first
    menu_count += 1 
  end


  puts
  puts "Misc"
  puts " p) Show tog poweruser help"
  menu_actions['p'] = 'power_user_help'

  if allmods['notinstalled'].count > 0
    puts " i) Install Modules"
    menu_actions['i'] = 'install'
  end
  puts " u) Uninstall Modules"
  menu_actions['u'] = 'uninstall'
  puts " x) Exit"
  menu_actions['x'] = 'exit'

  puts
  puts prompt
  keyb = $stdin.gets
  choice = keyb.chop
  clear_screen
  return menu_actions[choice]
end


