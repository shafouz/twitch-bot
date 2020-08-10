module UserMethods
  def roll20
    message("You rolled a #{rand(20)}!")
  end

  def ez
    message("EZ Clap")
  end

  def anime
    message("AYAYA")
  end

  private
    def message(input)
      @socket.puts("PRIVMSG ##{ENV["TWITCH_CHANNEL"]} :#{input}")
    end
end