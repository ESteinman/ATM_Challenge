class Person

    attr_accessor :name, :cash

    def initialize(attrs = {})
        set_name(attrs[:name])
        @cash = 0
    end
    
    private
    def set_name(name)
        name == nil ?  no_name_is_set : @name = name
    end

    def no_name_is_set
        raise "A name is required"
    end



end