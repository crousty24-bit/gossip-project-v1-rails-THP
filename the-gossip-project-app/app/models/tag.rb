class Tag < ApplicationRecord
  before_create -> { self.color ||= [
  "#D62828", # rouge foncé
  "#F77F00", # orange
  "#FCBF49", # jaune foncé
  "#003049", # bleu marine
  "#264653", # vert foncé
  "#1B4965", # bleu
  "#5A0F3C", # violet foncé
  "#6A4C93", # violet
  "#2D6A4F", # vert
  "#343A40"  # gris foncé
  ].sample }
  has_many :join_table_gossip_tags
  has_many :gossips, through: :join_table_gossip_tags
end
