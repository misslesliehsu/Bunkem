# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

word_hash = {}

alphabet = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

alphabet.each do |letter|
  doc = Nokogiri::HTML(open("http://phrontistery.info/#{letter}.html"))
  words = doc.css('.words')[0].css('tr')

  words.shift

  words.take(10).each do |word|
    Word.create(word: word.children[0].text, definition: word.children[1].text.chomp("\r\n"))
  end
end


User.create(name: "THE BUNKER", password: "THE BUNKER")
