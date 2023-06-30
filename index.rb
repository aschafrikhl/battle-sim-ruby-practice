require_relative 'battle'
require_relative 'character'
require_relative 'map'
require_relative 'monster'
require_relative 'util'


battle_lib = BattleLibrary

create_character = CharacterLibrary::Character

create_monster = MonsterLibrary::Monster
monster_types = MonsterLibrary::Types
monster_elements = MonsterLibrary::Elements

areas = MapLibrary:: Areas
map = MapLibrary::Map

doubly_link_list = Utils::DoublyLinkedList

puts "\nBattle Sim Starting"

puts "\nEnter Character name"
# character_name = "Frosty"
character_name = gets.chop

puts "\nEnter Character class"
# character_class = "Mage"
character_class = gets.chop

puts "\nEnter Character element type"
# character_element = "Ice"
character_element = gets.chop

character = create_character.new(character_name, character_class, character_element)
puts "\nYour #{character.element} #{character.type} #{character.name} has been created"

puts "\nYou are currently in Town would you like to go exploring? (yes or no)"
# go_exploring = "yes"
go_exploring = gets.chop.downcase

counter = 0
player_traveled = doubly_link_list.new

while go_exploring == "yes" do
    if counter == map['mountain'].length
        puts "\nCongratulations You made it to the #{player_traveled.get(counter - 1).val} defeating #{character.defeated_monsters} monsters along the way and enjoyed the view."

        go_exploring = "no"
        break
    end

    if counter == 0
        where_to = ''
        until areas.include?(where_to) do
            puts "\nWhere would you like to go? (Mountain, Volcano, River, Forest)"
            # where_to = "mountain"
            where_to = gets.chop.downcase

            if !areas.include?(where_to)
                puts "#{where_to} is not a option here"
            end
        end

        player_traveled.push(map[where_to][0])
    
        puts "\nYou start down the path to #{player_traveled.get(0).val}"
    else
        player_traveled.push(map[where_to][counter])
        puts "\nYou walk along the to #{player_traveled.get(counter).val}"
    end

    counter += 1


    puts "\While you are walking a random beast appeared. Would you like to fight? (yes or no)"
    # do_you_fight = "no"
    do_you_fight = gets.chop.downcase

    if do_you_fight == "yes"
        monster = create_monster.new(
            monster_types[rand(0...monster_types.length)].to_s,
            monster_elements[rand(0...monster_elements.length)].to_s
        )
    
        battle_lib.battle(character, monster)
    
        puts "\nThe battle is over"
    end


    if character.current_health < 0
        go_exploring = 'no'
        break
    else
        puts "\nKeep exploring? (yes or no)"
        go_exploring = gets.chop
    end
end

puts "\nBattle Sim Ending"
