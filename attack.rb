module AttackLibrary
    class BaseAttack
        attr_reader :special_cd

        def initialize
            @special_cd = 4
        end

        def reset_special_cd
            @special_cd = 4
        end

        def base_attack
            if @special_cd == 0
                @special_cd = 4
            end

            if @special_cd < 4
                @special_cd -= 1
            end
        end

        def hit_roll(min = 1, max = 20)
            rand(min...max)
        end
    end

    class PlayerAttack < BaseAttack

        def initialize(element)
            super()
            @element = element
        end

        def base_attack
            super()

            if hit_roll > 11
                damage = rand(1...5)
                puts "You hit for #{damage} damage"
                return damage
            end
            puts "You miss the target"
            return 0
        end

        def special_attack
            if @special_cd != 4
                puts "Your special Attack is on cd for #{special_cd} more rounds using Base Attack"
                return base_attack
            end

            @special_cd -= 1
            if hit_roll(1, 7) > 2
                damage = rand(3...8)
                puts "You hit for #{damage} #{@element} damage"
                return damage
            end
            puts "You miss the target with your special attack"
            return 0
        end
    end

    class MonsterAttack < BaseAttack
        def initialize(type, element)
            super()
            @element = element
            @type = type
        end

        def base_attack
            super()

            if hit_roll > 11
                damage = rand(1...5)
                puts "The #{@type.capitalize} hits you for #{damage} damage"
                return damage
            end
            puts "The #{@type.capitalize} misses you"
            return 0
        end

        def special_attack
            if @special_cd != 4
                return base_attack
            end

            @special_cd -= 1
            if hit_roll(1, 7) > 2
                damage = rand(3...8)
                puts "The #{@type.capitalize} hits you for #{damage} #{@element} damage"
                return damage
            end
            puts "The #{@type.capitalize} misses you"
            return 0
        end
    end
end
