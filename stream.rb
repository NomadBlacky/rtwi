
def stream(tl)

  tl = "home" if tl.nil?

  client = auth_stream

  case tl
  when /^home$/
    home_stream(client)
  when /^me$/
    user_stream(client,ACTIVE_USER)
  when /^(mentions|ment)$/
    mentions_stream(client)
  when /^@/
    user_stream(client,tl)
  else
    list_stream(client,tl)
  end

end

def home_stream(client)
  client.userstream do |tweet|
    tl << tweet
    puts "#{tweet.user.name}: #{tweet.text}"
  end
rescue Interrupt
  return timeline
end

def list_stream(client, listname)
end

def user_stream(client, username)
end

def mentions_stream(client)
end
