require_relative 'attack'

module MonsterLibrary
    Types = [:Bear, :Dragon, :Wolf, :Bird, :Bug];
    Elements = [:Fire, :Water, :Ice, :Wind, :Plasma];

    class Monster < AttackLibrary::MonsterAttack
        attr_reader :type, :element, :base_health, :current_health
        def initialize(type, element)
            super type, element
            @type = type
            @element = element
            @base_health = generate_base_health
            @current_health = @base_health
        end

        def generate_base_health
            rand(10...20)
        end

        def add_health(amount)
            @current_health = @current_health + amount
        end
    
        def remove_health(amount)
            @current_health = @current_health - amount
    
            if @current_health < 1
                puts "The #{@type.capitalize} has died"
            end
        end
    end
end
