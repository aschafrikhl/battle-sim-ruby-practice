module Utils
    class DoublyLinkedList
        attr_accessor :head, :tail, :length

        def initialize()
            @head = nil
            @tail = nil
            @length = 0
        end

        def push(val)
            new_node = Node.new(val)
            if @length == 0
                @head = new_node
                @tail = new_node
            else 
                @tail.next = new_node
                new_node.prev = @tail
                @tail = new_node
            end
            @length += 1
            return self
        end

        def pop
            return nil if !@head

            old_tail = @tail
            if @length == 1
                @head = nil
                @tail = nil
            else 
                @tail = old_tail.prev
                @tail.next = nil
                old_tail.prev = nil
            end
            @length -= 1

            return old_tail
        end

        def shift
            return nil if !@head

            old_head = @head
            if @length == 1
                @head = nil
                @tail = nil
            else
                @head = old_head.next
                @head.prev = nil
                old_head.next = nil 
            end
            @length -= 1

            return old_head
        end

        def unshift(val)
            new_node = Node.new(val)
            if @length == 0
                @head = new_node
                @tail = new_node
            else 
                @head.prev = new_node
                new_node.next = @head
                @head = new_node
            end
            @length += 1

            return self
        end

        def get(index)
            return nil if index < 0 || index >= @length
            if index <= @length/2
                i = 0
                current = @head
                while i < index do
                    current = current.next
                    i += 1
                end
            else 
                i = @length - 1
                current = @tail
                while i > index do
                    current =  current.prev
                    i -= 1
                end
            end

            return current
        end

        def set(index, val)
            node = get(index)

            if !!node
                node.val = val
                return true
            else 
                return false
            end
        end

        def insert(index, val)
            return false if index < 0 || index > @length
            return !!unshift(val) if index == 0
            return !!push(val) if index == @length

            new_node = Node.new(val)
            prev_node = get(index-1)
            after_new_node = prev_node.next
            new_node.prev = prev_node
            new_node.next = after_new_node
            prev_node.next = new_node
            after_new_node.prev = new_node

            @length += 1

            return true
        end

        def remove(index)
            return nil if index < 0 || index >= @length
            return shift() if index == 0
            return pop() if index == @length - 1

            removed_node = get(index)
            prev_node = removed_node.prev
            next_node = removed_node.next
            prev_node.next = next_node
            next_node.prev = prev_node
            removed_node.next = nil
            removed_node.prev = nil

            @length -= 1
            return removed_node
        end

        def reverse
            return self if @length < 2

            node = @head
            @head = @tail
            @tail = node

            i = 0
            while i < @length do
                prev = node.next
                node.next = node.prev
                node.prev = prev
                node = prev
                i += 1
            end

            return self
        end
    end

    class Node
        attr_accessor :val, :next, :prev
        attr_reader :value

        def initialize(val)
            @val = val
            @next = nil
            @prev = nil
        end
    end
end

