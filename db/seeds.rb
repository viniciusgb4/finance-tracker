# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'vinicius@example.com')
User.create(email: 'romilda@example.com')
User.create(email: 'cecilia@example.com')

Stock.create(ticker: 'AAPL', name: 'Apple inc.')
Stock.create(ticker: 'AMZN', name: 'Amazon inc.')

user = User.first
stock = Stock.first

user.stocks << stock
user.stocks << Stock.last