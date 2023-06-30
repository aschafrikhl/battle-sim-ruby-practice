module BattleLibrary
    def BattleLibrary.battle(character, monster)
        puts "\nThe fight has begone with a #{monster.element} #{monster.type}"

        BattleLibrary.rounds(character, monster)

        if character.current_health > 0
            rand_heal = rand(1...character.base_health / 2)

            BattleLibrary.apply_health(character, rand_heal)
            character.reset_special_cd

            character.defeat_monster
            puts "\nYou have been healed for #{rand_heal}"
        end
    end

    def BattleLibrary.rounds(character, monster)
        current_round = 0

        until character.current_health < 1 or monster.current_health < 1 do
            current_round += 1
            puts "\nCurrent round #{current_round}"

            character_damage = BattleLibrary.character_turn(character)
            monster_damage = BattleLibrary.monster_turn(monster)

            BattleLibrary.apply_turn_damage([
              { :where => character, :damage_taken => monster_damage },
              { :where => monster, :damage_taken => character_damage }
            ])

            puts "end of round character health => #{character.current_health} monster health => #{monster.current_health}"
        end
    end

    def BattleLibrary.character_turn(character)
        which_attack = ''

        until which_attack == "base" or which_attack == "special" do
            puts "\nUse Base or Special? (base or special)"
            which_attack = gets.chop.downcase

            if !['base', 'special'].include?(which_attack)
                puts "#{which_attack} is not a option here"
            end
        end

        if which_attack == "base"
           return character.base_attack
        end

        if which_attack == "special"
            return character.special_attack
        end
    end

    def BattleLibrary.monster_turn(monster)
        if rand(0...99).even? and monster.special_cd == 4
            return monster.special_attack
        end

        return monster.base_attack
    end

    def BattleLibrary.apply_damage(where_to_apply, damage_taken)
        where_to_apply.remove_health(damage_taken)
    end

    def BattleLibrary.apply_health(where_to_apply, health_restored)
        where_to_apply.add_health(health_restored)
    end

    def BattleLibrary.apply_turn_damage(damage_array)
        for i in damage_array do
            BattleLibrary.apply_damage(i[:where], i[:damage_taken])
        end
    end
end