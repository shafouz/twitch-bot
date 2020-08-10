require 'dotenv'
require 'socket'
require 'logger'
require './lib/bot_methods/admin_methods.rb'
require './lib/bot_methods/user_methods.rb'

Dotenv.load

class Twitch
  include AdminMethods
  include UserMethods

  def initialize
    @socket = TCPSocket.new 'irc.chat.twitch.tv', 6667
    @logger = Logger.new("./lib/log/logger.log")
    @response_get = response_get
    @response_set = response_set
    @commands = UserMethods.instance_methods
    hello

    @response_get.join
    @response_set.join
  end

  # Useful for debug purposes
  def hello
    @logger.info("Bot started...")
    start
  end

  # Log into the irc server and channel
  def start
    @socket.puts("CAP REQ :twitch.tv/membership")
    @socket.puts("PASS #{ENV["TWITCH_CHAT_TOKEN"]}")
    @socket.puts("NICK #{ENV["TWITCH_USER"]}")
    @socket.puts("JOIN ##{ENV["TWITCH_CHANNEL"]}")
  end

  # Call the method if exists else print error
  def sender(message)
    message = message.to_sym
    if @commands.any?(message)
      self.send message
    else
      @logger.info("Invalid method...")
    end
  end

  # Send input to proper method, also can be used as authenthication
  def response_listener(message)
    username = message[1]
    command = message[2]
    sender(command)
  end

  def response_set
    Thread.new do
      loop do
        input = gets.chomp
        sender(input)
      end
    end
  end

  # Prints messages from TCPsocket and listens to user input
  def response_get
    Thread.new do
      loop do
        message = @socket.gets.chomp
        match = message.match(/^:.+!.+ PRIVMSG #(\w+) :!(\S+)/)
        response_listener(match) if match
        @socket.puts("PONG") if message == "PING :tmi.twitch.tv"
        @logger.info(message)
      end
    end
  end
end

bot = Twitch.new
