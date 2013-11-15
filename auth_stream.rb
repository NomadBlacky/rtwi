# -*- coding: utf-8 -*-

def auth_stream

  # ユーザ情報を読み込む
  doc = REXML::Document.new(open("users.xml"))

  keys = nil
  doc.elements.each('root/user') do |element|
    if element.attributes["id"] == ACTIVE_USER # config.rb
      keys = element
      break
    end
  end

  if keys.nil?
    puts "ユーザが見つかりません (#{ACTIVE_USER})"
    return
  end

  TweetStream.configure do |config|
    config.consumer_key       = keys.elements["consumer_key"].text
    config.consumer_secret    = keys.elements["consumer_secret"].text
    config.oauth_token        = keys.elements["access_token"].text
    config.oauth_token_secret = keys.elements["access_token_secret"].text
  end

  TweetStream::Client.new
end
