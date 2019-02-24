class Movie < ActiveRecord::Base

    all_ratings =
    
    def self.all_ratings
        arr = ['G', 'PG', 'PG-13', 'R']
        return arr
    end
end
