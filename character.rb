require 'securerandom'

require_relative 'attack'

module CharacterLibrary
    class Character < AttackLibrary::PlayerAttack
        @@total_charactors = 0

        attr_reader :id, :name, :type, :element, :base_health, :current_health, :defeated_monsters

        def initialize(name, type, element)
            super element
            @id = generate_id
            @name = name
            @type = type
            @element = element
            @base_health = generate_base_health
            @current_health = @base_health
            @defeated_monsters = 0

            @@total_charactors += 1
        end

        def generate_base_health
            rand(20...50)
        end

        def add_health(amount)
            @current_health = @current_health + amount
        end
    
        def remove_health(amount)
            @current_health = @current_health - amount
    
            if @current_health < 1
                puts "#{@name} has died game over"
            end
        end

        def defeat_monster
            @defeated_monsters += 1
        end

        private
        def generate_id
            SecureRandom.uuid
        end

        def get_total_charactors
            @@total_charactors
        end
    end
end
