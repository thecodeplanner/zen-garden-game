require "tty-prompt"
class Garden < ActiveRecord::Base
    has_many :gardenplants
    has_many :plants, through: :gardenplants
    @@prompt = TTY::Prompt.new

    def self.signup
        username = @@prompt.ask("What is your username?")
        password = @@prompt.mask("What is your password?")
        garden_name = @@prompt.ask("What would you like to name your garden?")
        user = self.create(username: username, password: password, garden_name: garden_name)
        user
    end

    def self.login 
        found = false
        until found == true
            username = @@prompt.ask("What is your username?")
            password = @@prompt.mask("What is your password?")
            user = self.find_by(username: username, password: password)
            if user
                found = true 
                return user
            else
                system("clear") 
                option = @@prompt.select("User Not Found") do |menu|
                    menu.choice 'Try Again'
                    menu.choice 'Return to Main Menu'
                end

                if option == 'Try Again'
                    found = false
                elsif option == 'Return to Main Menu'
                    return false
                end
            end
        end
    end

    def plant_plant_in_garden(plant)
        Gardenplant.create(garden_id: self.id, plant_id: plant.id, status: "seedling")
    end

end


  
    
    
    
    