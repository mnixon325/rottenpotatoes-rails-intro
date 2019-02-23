class Movie < ActiveRecord::Base
    
    def self.all_ratings
        arr = ['G', 'PG', 'PG-13', 'R']
        return arr
    end
end
