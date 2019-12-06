class App 

    attr_reader :user 

    def start_game
        call_player_data
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
    end 

    def view_leagues

        my_leagues = @user.leagues.map do |league| 
            league_scroll = league.league_name
            {league_scroll => league}
        end

        prompt = TTY::Prompt.new
        user_input = prompt.select("Currently you belong to:", my_leagues)
        @my_teams = FantasyTeam.all.find_all{|team| team.league_id == user_input.id}
        main_menu
    end 

    def team_menu
        prompt = TTY::Prompt.new
        user_input = prompt.select("May we suggest...", ["Create a Team", "Manage a Team", "Delete a Team", "Main Menu"]) 
    
            if user_input == "Create a Team"
                create_team
            elsif user_input == "Manage a Team"
                manage_team
            elsif user_input == "Delete a Team"
                puts "Sorry this option is still in progress"
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

    def call_player_data

        response = RestClient.get("https://statsapi.web.nhl.com/api/v1/teams?expand=team.roster")
        result = JSON.parse(response)

        result["teams"].map {|t| @t = t["roster"]["roster"]}
        @player_data = @t.map{|person| person["person"]}
        
        c = @player_data.map do |player| 
            Player.create(name: player["fullName"], position: "defenseman", points: 17, goals: 2)
        end 

        binding.pry

    end 

    def add_roster

        player_stats = Player.all.map do |player|
            player_scroll = "#{player.name} #{player.position} points:#{player.points} goals:#{player.goals}"
            {player_scroll => player}
        end

        prompt = TTY::Prompt.new
        user_input = prompt.multi_select("Please choose 5 players to help you win the cup!", player_stats)
        @my_fantasy_team.players << user_input
    end 

    def manage_team
        prompt = TTY::Prompt.new
        binding.pry
        user_input = prompt.select("What team would you like to manage?", @my_fantasy_team.team_name)


    end 

end 

# d = { "copyright": "NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams. © NHL 2019. All Rights Reserved.",
#         "teams": [ 
#             {"id": 1,
#             "name": "New Jersey Devils",
#             "roster": { "roster": [
#                 { "person": { "id": 8476941, "fullName": "Connor Carrick", "link": "/api/v1/people/8476941"},
#                 "jerseyNumber": "5",
#                 "position": { "code": "D", "name": "Defenseman", "type": "Defenseman", "abbreviation": "D"}
# }
#             ]
#         }
#     }
# ]
# }

# d[:teams].map {|t| @t = t[:roster][:roster]}

#gets [
#     { "person": { "id": 8476941, "fullName": "Connor Carrick", "link": "/api/v1/people/8476941"},
#     "jerseyNumber": "5",
#     "position": { "code": "D", "name": "Defenseman", "type": "Defenseman", "abbreviation": "D"}
# }

# @player_data = @t.map{|person| person[:person]}

# #gets [{:id=>8476941, :fullName=>"Connor Carrick", :link=>"/api/v1/people/8476941"}]

# @player_data.map{|t| t[:fullName]}

# #gets ["Connor Carrick"]