# -*- coding: utf-8 -*-

def tweet(*text_args)

  client = auth_twitter

  if(text_args.empty?)
    tweet = ""
    while tweet.chop.empty?
      print "tweet > "
      tweet = STDIN.gets
    end
    return if tweet =~ /^(exit|quit)$/
  else
    tweet = text_args.join(" ")
  end

  if tweet.length > 140
    puts "140字以上はつぶやけません".red
    return
  end

  client.update tweet
  puts "ツイート成功".green

end
