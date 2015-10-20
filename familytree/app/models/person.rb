require 'active_record'

class Person < ActiveRecord::Base
  belongs_to :mother, :class_name => 'Person'
  belongs_to :father, :class_name => 'Person'
  validates :given_name, :family_name, :presence => true

  def grandparents
  grands = []
  grands << mother.mother
  grands << mother.father
  grands << father.mother
  grands << father.father
  grands
  end
end
