# -*- coding: utf-8 -*-

def timeline(tl, count=20)

  tl = "home" if tl.nil?

  if tl.to_i > 0                # 第一引数に整数が渡された場合
    count = tl.to_i             # HomeTLのcount扱いとする
    tl = "home"
  end

  client = auth_twitter

  case tl
  when /^home$/
    tl_home(client,count)
  when /^me$/
    tl_me(client,count)
  when /^(mentions|ment)$/
    tl_mentions(client,count)
  when /^@/
    tl_user(client,tl,count)
  else
    tl_list(client,tl,count)
  end

end

# Homeタイムライン --------------------------------
def tl_home(client,count)

  tweets = client.home_timeline({"count" => count})
  print_tweet tweets

end


# 自身のタイムライン ------------------------------
def tl_me(client,count)

  tweets = client.user_timeline({"count" => count})
  print_tweet(tweets)

end


# メンション --------------------------------------
def tl_mentions(client,count)

  tweets = client.mentions_timeline({"count" => count})
  print_tweet(tweets)

end


# 指定ユーザのTL ------------------------------------
def tl_user(client,user,count)

  tweets = client.user_timeline(user, {"count" => count})
  print_tweet(tweets)

rescue
  puts "ユーザ#{user}が見つからない、あるいは閲覧できない状態です。"

end


def tl_list(client,list,count)

  tweets = client.list_timeline(list, {"count" => count})
  print_tweet(tweets)

rescue
  puts "リスト#{list}が見つかりません"

end


# Tweetを整形表示 --------------------------------
def print_tweet(tweets)

  tweets.reverse!

  tweets.each_with_index do |tweet, index|
    id   = tweet.from_user
    text = tweet.text

    text.gsub!("&lt;","<")
    text.gsub!("&gt;",">")

    # テキスト整形
    text.gsub!(/\n/, "\n" << (" "*18) )
    users = text.scan(ID_REGEXP_AT) << ""
    if id == ACTIVE_USER
      tw_user = sprintf("%12s", id).green
    else
      tw_user = sprintf("%12s", id).cyan
    end
    print "[#{sprintf("%02d",index)}]"
    print "<@" + tw_user + "> : "
    i = 0
    text.split(ID_REGEXP_AT, -1).each do |t|
      if t.empty?
        if users[i] =~ /@#{ACTIVE_USER}/
          user = users[i].green
        else
          user = users[i].cyan
        end
        t = user.blue
        i = i.next
      end
      print t
    end
    print "\n"
  end

  tweets
end
