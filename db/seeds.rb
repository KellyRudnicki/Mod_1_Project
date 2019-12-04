PlayerTeam.destroy_all
Player.destroy_all
FantasyTeam.destroy_all

player1 = Player.create(name: "Ryan Suter", position: "defenseman", points: 17, goals: 2)
player2 = Player.create(name: "Sydney Crosby", position: "forward_1", points: 32, goals: 20)
player3 = Player.create(name: "Connor McDavid", position: "forward_2", points: 25, goals: 17)
player4 = Player.create(name: "Nathan MacKinnon", position: "goalie", points: 5, goals: 1)

fantasy_team1 = FantasyTeam.create(team_name: "The Mother Puckers")
fantasy_team2 = FantasyTeam.create(team_name: "Stormin Normans")

PlayerTeam.create(player_id: player1.id, fantasy_team_id: fantasy_team1.id)
PlayerTeam.create(player_id: player2.id, fantasy_team_id: fantasy_team2.id)

