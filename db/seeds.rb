# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['♦', '♥', '♠', '♣'].each do |couleur|
  ['1','7','8','9','10','V','D','R'].each do |valeur|
    card = Card.new(couleur: couleur, valeur: valeur, deck_id: 1 )
    card.save
  end
end