require_relative 'config/environment'

pid = fork{exec 'afplay', "./Vanilla Ice - Ice Ice Baby (Official Video).mp3"}

app = App.new
app.start_game

# binding.pry
# 0

