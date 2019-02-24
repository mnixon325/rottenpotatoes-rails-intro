class Movie < ActiveRecord::Base
    
    def self.all_rating
        return %w[G PG PG-13 R]
        #return arr
    end
end
