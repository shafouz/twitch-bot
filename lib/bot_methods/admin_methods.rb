module AdminMethods
  def start
    @socket.puts("CAP REQ :twitch.tv/membership")
    @socket.puts("PASS #{ENV["TWITCH_CHAT_TOKEN"]}")
    @socket.puts("NICK #{ENV["TWITCH_USER"]}")
    @socket.puts("JOIN ##{ENV["TWITCH_CHANNEL"]}")
  end

  def quit
    @socket.close
  end
end
