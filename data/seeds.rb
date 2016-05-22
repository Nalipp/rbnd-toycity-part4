require 'faker'
require 'csv'

def db_seed
  10.times do |id|
    Udacidata.create(id: id + 1, brand: Faker::Hipster.word, name: Faker::Commerce.product_name, price: Faker::Commerce.price)
  end
end
