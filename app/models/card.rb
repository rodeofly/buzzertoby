class Card < ActiveRecord::Base
  belongs_to :deck
  acts_as_taggable
  before_save :ajouter_tags

  def valeur_enum
    ['1','2','3','4','5','6','7','8','9','10','V','D','R']
  end
  
  def couleur_enum
    ['♥', '♠', '♦', '♣']
  end
  
  def ajouter_tags
    case self.couleur
      when '♦','♥'
        self.tag_list.add("rouge")
      when '♠','♣'
        self.tag_list.add("noire")
    end
    case self.valeur
      when '1','3','5','7','9'
        self.tag_list.add("paire")
      when '2','4','6','8','10'
        self.tag_list.add("impaire")
      when 'V','D','R'
        self.tag_list.add("figure")
    end
  end
  
end