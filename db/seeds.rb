LeagueUser.destroy_all
League.destroy_all
User.destroy_all
PlayerTeam.destroy_all
Player.destroy_all
FantasyTeam.destroy_all


# user1 = User.create(username: "idk")

# league1 = League.create(league_name: "The Big League")

# league_user1 = LeagueUser.create(league_id: league1.id, user_id: user1.id)


# player1 = Player.create(name: "Ryan Suter", position: "defenseman", points: 17, goals: 2)
# player2 = Player.create(name: "Sydney Crosby", position: "forward_1", points: 32, goals: 20)
# player3 = Player.create(name: "Connor McDavid", position: "forward_2", points: 25, goals: 17)
# player4 = Player.create(name: "Nathan MacKinnon", position: "goalie", points: 5, goals: 1)


# fantasy_team4 = FantasyTeam.create(team_name: "The fourth team", league_id: 15)
# fantasy_team5 = FantasyTeam.create(team_name: "The fifth team", league_id: 15)


# PlayerTeam.create(player_id: player1.id, fantasy_team_id: fantasy_team4.id)
# PlayerTeam.create(player_id: player2.id, fantasy_team_id: fantasy_team4.id)


    response = RestClient.get("https://statsapi.web.nhl.com/api/v1/teams?expand=team.roster")
    result = JSON.parse(response)

    result["teams"].map {|t| @t = t["roster"]["roster"]}
    @player_data = @t.map{|person| person["person"]}
    
    @player_data.map do |player| 

        p_id = player["id"]

        new_link = "https://statsapi.web.nhl.com/api/v1/people/#{p_id}"
        response2 = RestClient.get(new_link)
        result2 = JSON.parse(response2)

        result2["people"].map {|i| @position = i["primaryPosition"]["abbreviation"]}

        result2["people"].map {|i| @goals = i["currentAge"]}

        points = @goals + 8

        Player.create(name: player["fullName"], position: @position, points: points, goals: @goals)
    end 