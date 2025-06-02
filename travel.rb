require_relative 'util'

module TravelLibrary
    class Travel
        attr_reader :traveled
        def initialize()
            
            @traveled = Utils::DoublyLinkedList.new
        end
    end

    
end