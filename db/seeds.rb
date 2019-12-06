LeagueUser.destroy_all
League.destroy_all
User.destroy_all
PlayerTeam.destroy_all
Player.destroy_all
FantasyTeam.destroy_all


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