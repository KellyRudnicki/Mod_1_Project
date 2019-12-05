class App 

    attr_reader :user 
    #make a user class

    def start_game
        puts "Welcome to Fantasy Hockey! What is your username?"
        #think of more creative name
        user_input = gets.chomp
        @user = User.create(username: user_input)
        puts "Welcome #{@user.username}!" 
        welcome_menu
    end 

    def welcome_menu
        prompt = TTY::Prompt.new
        user_input = prompt.select("What would you like to do?", ["Create a League", "Join a League", "View your League(s)", "Quit"]) 
        
        @all_leagues = League.all.map{|league| league.league_name}

        if user_input == "Create a League"
            create_league_menu
        elsif user_input == "Join a League"
            puts @all_leagues
            join_league
        elsif user_input == "View your League(s)"
            puts @all_leagues
        elsif user_input == "Quit"
            exit 
        else
            puts "Sorry that's not a valid option, please try again!"
            welcome_menu
        end 
    end 

    def create_league_menu 
        puts "Please enter a league name."
        user_input = gets.chomp
        @league = League.create(league_name: user_input)
        puts "You league name is: #{@league.league_name}."
        puts "Would you like to create a team? (Y/N)"
        user_input2 = gets.chomp.downcase
        if user_input2 == "y"
            create_team
        elsif user_input2 == "n"
            puts "Okay then..."
            welcome_menu
        end 
    end 

    def join_league
        puts "What league would you like to join?" 
        user_input = gets.chomp
        

    end 

    def create_team
        puts "Please enter a team name."
        user_input = gets.chomp
        @fantasy_team = FantasyTeam.create(team_name: user_input)
        puts "You team name is: #{@fantasy_team.team_name}!"
    end 

end 
