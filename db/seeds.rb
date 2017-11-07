JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  temp = Movie.create!(movie)
  temp.available_inventory = temp.inventory
  temp.save
end
