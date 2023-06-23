require 'securerandom'

require_relative 'attack'

module CharacterLibrary
    class Character < AttackLibrary::PlayerAttack
        @@total_charactors = 0

        attr_reader :id, :name, :type, :element, :base_health, :current_health

        def initialize(name, type, element)
            super element
            @id = generate_id
            @name = name
            @type = type
            @element = element
            @base_health = generate_base_health
            @current_health = @base_health

            @@total_charactors += 1
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
                puts "#{@name} has died game over"
            end
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
