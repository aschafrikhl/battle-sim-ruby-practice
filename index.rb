require_relative 'battle'
require_relative 'character'
require_relative 'monster'

battle_lib = BattleLibrary
create_character = CharacterLibrary::Character
create_monster = MonsterLibrary::Monster
monster_types = MonsterLibrary::Types
monster_elements = MonsterLibrary::Elements

puts "\nBattle Sim Starting"

puts "\nEnter Character name"
# character_name = "Frosty"
character_name = gets.chop

puts "\nEnter Character class"
# character_class = "Mage"
character_class = gets.chop

puts "\nEnter Character element type"
# character_element = "ice"
character_element = gets.chop

character = create_character.new(character_name, character_class, character_element)
puts "\nYour #{character.element} #{character.type} #{character.name} has been created"

puts "\nYour walking throught the wood when a random beast appeared. Would you like to fight? (yes or no)"
# do_you_fight = "yes"
do_you_fight = gets.chop.downcase


while do_you_fight == "yes" do
    monster = create_monster.new(
        monster_types[rand(0...monster_types.length)].to_s,
        monster_elements[rand(0...monster_elements.length)].to_s
    )

    battle_lib.battle(character, monster)

    puts "\nThe battle is over"

    if character.current_health < 0
        do_you_fight = 'no'
        break
    end

    puts "\nKeep exploring for something else to fight? (yes or no)"
    do_you_fight = gets.chop
end

puts "\nBattle Sim Ending"
