json.array!(@cards) do |card|
  json.extract! card, :name, :couleur, :valeur, :deck_id
  json.url card_url(card, format: :json)
end
