class Movie < ActiveRecord::Base
    
    def self.all_rating
        arr = ['G', 'PG', 'PG-13', 'R']
        return arr
    end
end
