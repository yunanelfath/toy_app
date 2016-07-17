class Dice
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :max, :min, :result

  def initialize(attributes = {})
    attributes.each do|name, value|
      send("#{name}=",value)
    end
  end
end
