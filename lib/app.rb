class App 

    attr_reader :user 

    def start_game
        puts "Welcome to Fantasy Hockey! What is your username?"
        user_input = gets.chomp
        @user = User.create(username: user_input)
        puts "Welcome #{@user.username}!" 
        main_menu
    end 
    
    def main_menu
        prompt = TTY::Prompt.new
        user_input = prompt.select("What would you like to do?", ["Create a League", "Join a League", "View your League(s)", "Skip to Team Menu", "Quit"]) 
            
            @all_leagues = League.all.map{|league| league.league_name}
            
            if user_input == "Create a League"
                create_league_menu
            elsif user_input == "Join a League"
                puts @all_leagues
                join_league
            elsif user_input == "View your League(s)"
                view_leagues
            elsif user_input == "Skip to Team Menu"
                team_menu
            elsif user_input == "Quit"
                exit 
            else
            puts "Sorry that's not a valid option, please try again!"
            main_menu
        end 
    end 

    def create_league_menu 
        puts "Please enter a league name."
        user_input = gets.chomp
        @my_league = League.create(league_name: user_input)
        @user.leagues << @my_league
        puts "You league name is: #{user_input}."
        team_menu
    end 

    def join_league

        total_leagues = League.all.map do |league| 
            league_scroll = league.league_name
            {league_scroll => league}
        end 

        prompt = TTY::Prompt.new
        user_input = prompt.select("What league would you like to join?", total_leagues)
        @user.leagues << user_input

        main_menu
    end 

    def view_leagues

        my_leagues = @user.leagues.map {|league| league.league_name}

        puts "Currently you belong to: #{my_leagues}" 
    
        main_menu
    end 

    def team_menu
        prompt = TTY::Prompt.new
        user_input = prompt.select("May we suggest...", ["Create a Team", "Manage a Team", "Delete a Team", "Main Menu"]) 
    
            if user_input == "Create a Team"
                create_team
            elsif user_input == "Manage a Team"
                manage_team
            elsif user_input == "View my Team(s)"
                puts "Sorry this option is still in progress" 
                #delete_team
            elsif user_input == "Main Menu"
                main_menu
            else
            puts "Sorry that's not a valid option, please try again!"
            team_menu
        end 
    end 

    def create_team
        puts "Please enter a team name."
        user_input = gets.chomp
        @my_fantasy_team = FantasyTeam.create(team_name: user_input, league_id: @my_league.id)
        puts "You team name is: #{@my_fantasy_team.team_name}, let's add some players!"
        add_roster

        main_menu
    end 

    # def delete_team 

    #     prompt = TTY::Prompt.new

    #     binding.pry

    #     my_team = @my_fantasy_team.players.map do |player|
    #         player_scroll = "#{player.name}, #{player.position}   Points: #{player.points}   Goals: #{player.goals}"
    #         {player_scroll => player}
    #     end

    #     user_input = prompt.select("What team would you like to delete?", my_team)

    #     @my_fantasy_team.players.delete(user_input)

    #     puts "Time to replace #{user_input.name}!"

    #     add_player

    # end 

    def add_roster

        player_stats = Player.all.map do |player|
            player_scroll = "#{player.name}, #{player.position}   Points: #{player.points}   Goals: #{player.goals}"
            {player_scroll => player}
        end

        prompt = TTY::Prompt.new
        user_input = prompt.multi_select("Please choose 5 players to help you win the cup!", player_stats)
        @my_fantasy_team.players << user_input
    end 

    def manage_team
        prompt = TTY::Prompt.new
        user_input = prompt.select("Would you like to...", ["Add a Player", "Remove a Player", "Team Menu", "Main Menu"]) 
    
            if user_input == "Add a Player"
                add_player
            elsif user_input == "Remove a Player"
                remove_player
            elsif user_input == "Team Menu"
                team_menu
            else user_input == "Main Menu"
                main_menu
            end 
    end 

    def add_player 

        prompt = TTY::Prompt.new

        my_team = @my_fantasy_team.players.map do |player|
            player_scroll = "#{player.name}, #{player.position}   Points: #{player.points}   Goals: #{player.goals}"
            {player_scroll => player}
        end

        user_input = prompt.select("What player would like to add?", my_team)

        @my_fantasy_team.players << user_input

        puts "Welcome to #{@my_fantasy_team.team_name}, #{user_input.name}!"

        team_menu

    end 

    def remove_player

        prompt = TTY::Prompt.new

        my_team = @my_fantasy_team.players.map do |player|
            player_scroll = "#{player.name}, #{player.position}   Points: #{player.points}   Goals: #{player.goals}"
            {player_scroll => player}
        end

        user_input = prompt.select("What player would like to remove?", my_team)

        @my_fantasy_team.players.delete(user_input)

        puts "Time to replace #{user_input.name}!"

        add_player

    end 

end 