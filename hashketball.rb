require 'pry'
# Write your code here!
def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: [
        {
          player_name: "Alan Anderson",
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        {
          player_name: "Reggie Evans",
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        {
          player_name: "Brook Lopez",
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        {
          player_name: "Mason Plumlee",
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        {
          player_name: "Jason Terry",
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      ]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [
        {
          player_name: "Jeff Adrien",
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        {
          player_name: "Bismack Biyombo",
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10
        },
        {
          player_name: "DeSagna Diop",
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        {
          player_name: "Ben Gordon",
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        {
          player_name: "Kemba Walker",
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks: 12
        }
      ]
    }
  }
end

def num_points_scored(players_name)
  #return num of points for player

  game_hash.each do |team, team_data|
    team_data.each do |team_key, team_key_values|
      if team_key == :players
        team_key_values.each do |player|
          if player[:player_name] == players_name
            return player[:points]
          end
        end
      end
    end
  end
end

def player_info(players_name)
  game_hash.each do |team, team_data|
    team_data.each do |team_key, team_key_values|
      if team_key == :players
        team_key_values.each do |player|
          if player[:player_name] == players_name
            return player
          end
        end
      end
    end
  end
end

def shoe_size(players_name)
  player_info(players_name)[:shoe]
end

def find_team_data(team_name)
# Return hash that start with team array
  game_hash.each do |team, team_data|
    team_data.each do |team_key, team_key_value|
      # binding.pry
     if team_key_value == team_name
       return team_data
     end
   end
  end
end

def team_colors(team_name)
  find_team_data(team_name)[:colors]
end

def team_names
  game_hash.map do |team_place, team_data|
    team_data[:team_name]
  end
end

def player_numbers(team_name)
  #Returns an array (.map) that contains the jersey number the team passed in.
  result = nil

  game_hash.each do |place, team|
    if team[:team_name] == team_name
      team.each do |attribute, data|
        if attribute == :players
          result = data.map do |player| #player parameter represents each player's hash within the array.
            player[:number]
          end
        end
      end
    end
  end
  result
end

def player_stats(players_name)
  #Returns player_info hash minus player name kv pair.
  player_info(players_name).filter {|k,v| v != players_name }
end

#Iterate down to name level, put each name into player stats, find the one within
#the largest shoe integer and return it's corresponding rebound integer
def all_players_info
result = []

  game_hash.each do |team, team_data|
    team_data.each do |team_key, team_key_values|
      if team_key == :players
        team_key_values.each do |player|
          result << player_info(player[:player_name])
        end
      end
    end
  end
  result
end
# binding.pry
def biggest_shoe
  shoe_arry = []

  all_players_info.each do |player|
    shoe_arry << player[:shoe]
  end
shoe_arry.max
end

def big_shoe_rebounds
  all_players_info.each do |player|
    player.each do |k,v|
      if player[:shoe] == biggest_shoe
        return player[:rebounds]
      end
    end
  end
end

def highest_score
  results = []

  all_players_info.each do |player|
    results << player[:points]
  end
results.max
end

def most_points_scored
  all_players_info.each do |player|
    player.each do |k,v|
      if player[:points] == highest_score
        return player[:player_name]
      end
    end
  end
end

def home_team_points
  result = 0

  find_team_data(game_hash[:home][:team_name]).each do |team_key, team_key_values|
    if team_key == :players
      team_key_values.each do |player|
        result += player[:points]
      end
    end
  end
result
end

def away_team_points
  result = 0

  find_team_data(game_hash[:away][:team_name]).each do |team_key, team_key_values|
    if team_key == :players
      team_key_values.each do |player|
        result += player[:points]
      end
    end
  end
result
end

def winning_team
  if home_team_points > away_team_points
    game_hash[:home][:team_name]
  else game_hash[:away][:team_name]
  end
end

def player_with_longest_name
  name_container = []

  all_players_info.each do |player|
    name_container << player[:player_name]
  end
  name_container.max_by {|n| n.length}
end

def most_steals
  results = []

  all_players_info.each do |player|
    results << player[:steals]
  end
results.max
end

def player_with_most_steals
  all_players_info.each do |player|
    player.each do |k,v|
      if player[:steals] == most_steals
        return player[:player_name]
      end
    end
  end
end

def long_name_steals_a_ton?
  player_with_most_steals == player_with_longest_name
end
