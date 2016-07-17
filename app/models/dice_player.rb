class DicePlayer
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :name, :roll_dice, :round, :qualification

  def initialize(attributes = {})
    attributes.each do|name, value|
      send("#{name}=",value)
    end
  end
end
