# -*- coding: utf-8 -*-

def useradd(uid=nil)

  include REXML

  if uid.nil?
    puts "No Input (User ID)"
    return
  end

  # TwitterIDに一致するか
  unless uid =~ /^[a-zA-Z0-9_]{1,15}$/
    puts "Input Error (User ID)"
    return
  end

  p "@" << uid

  filename = "users.xml"
  ck = cs = at = ats = ""       # 空文字で初期化

  while ck.empty?
    print "Consumer key        > "
    ck  = STDIN.gets.chop
  end
  while cs.empty?
    print "Consumer secret     > "
    cs  = STDIN.gets.chop
  end
  while at.empty?
    print "Access token        > "
    at  = STDIN.gets.chop
  end
  while ats.empty?
    print "access token secret > "
    ats = STDIN.gets.chop
  end

  file = File.open(filename, "r")
  doc = REXML::Document.new file

  root = doc.root

  user = Element.new "user"
  user.attributes["id"] = uid

  user.add_element "consumer_key"
  user.add_element "consumer_secret"
  user.add_element "access_token"
  user.add_element "access_token_secret"

  user.elements["consumer_key"].text        = ck
  user.elements["consumer_secret"].text     = cs
  user.elements["access_token"].text        = at
  user.elements["access_token_secret"].text = ats

  root.add_element user

  file = File.open(filename, "w")
  doc.write file

end
