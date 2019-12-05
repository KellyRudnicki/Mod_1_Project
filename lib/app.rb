class App 

    attr_reader :user 

    # make a user class

    def start_game
        puts "Welcome to Fantasy Hockey! What is your username?"
        #think of more creative name
        user_input = gets.chomp
        # @user = User.create(username: user_input)
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
                puts @user.leagues.map{|league| league.league_name}
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
        @my_league = League.create(league_name: user_input)
        @user.leagues << @my_league
        puts "You league name is: #{user_input}."
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

        prompt = TTY::Prompt.new
        user_input = prompt.select("What league would you like to join?", @all_leagues)
        # ADD FUnctionality to user selection
    end 

    def create_team
        puts "Please enter a team name."
        user_input = gets.chomp
        @my_fantasy_team = FantasyTeam.create(team_name: user_input, league_id: @my_league.id)
        # puts "You team name is: #{@my_fantasy_team.team_name}, let's add some players!"
        add_roster
    end 

    def add_roster

        player_stats = Player.all.map do |player|
            player_scroll = "#{player.name} #{player.position} points:#{player.points} goals:#{player.goals}"
            {player_scroll => player}
        end

        prompt = TTY::Prompt.new
        user_input = prompt.multi_select("Let's add some players...", player_stats)
        @my_fantasy_team.players << user_input
        binding.pry
    end 

end 
