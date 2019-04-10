class Boat < ActiveRecord::Base

  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  

  def self.first_five
    Boat.all[0..4]
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.order(:name).last(3).reverse
  end

  def self.without_a_captain
    Boat.where(captain:nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
    # classid = Classification.where(name:"Sailboat").ids[0]
    # boats = BoatClassification.where(classification_id: classid)
    # boats.map {|boat| Boat.find(boat.boat_id)}
  end

  def self.with_three_classifications
    joins(:boat_classifications).group(:name).having('count(name) = 3')
    # out = Boat.all.map { |boat| BoatClassification.where(boat_id: boat.id)}
    # out = out.map{|i| i if i.length >= 3}.reject(&:nil?)
    # out.map {|i| Boat.find(i[0].boat_id) }
  end


end
