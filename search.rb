
def search(str,count)

  count = 20 if count.nil?

  client = auth_twitter

  result = client.search(str, {:count => count})
  print_tweet result.statuses

end
