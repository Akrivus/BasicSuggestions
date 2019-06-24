require 'discordrb'

CHANNEL_WHERE_SUGGESTIONS_ARE_VOTED_FOR = 577313497759612928
CHANNEL_WHERE_SUGGESTIONS_ARE_SUBMITTED = 577308958830886922
BOT = Discordrb::Bot.new(token: File.read('./token').chomp)
BOT.message start_with: '+suggest' do |event|
    if event.channel.id == CHANNEL_WHERE_SUGGESTIONS_ARE_SUBMITTED
        suggestion = event.message.text.gsub(/^\+suggest /, '')
        msg = BOT.send_message(CHANNEL_WHERE_SUGGESTIONS_ARE_VOTED_FOR, "<@#{event.message.author.id}> suggested:\n> \"#{suggestion}\"", )
        msg.react("👍")
        msg.react("🤷")
        msg.react("👎")
        event.respond("Thanks for your suggestion!")
    end
end
BOT.message start_with: '+ping' do |event|
    message = event.message.text.gsub(/^\+ping /, '')
    event.respond(message.empty? ? 'Pong!' : message)
end
BOT.run