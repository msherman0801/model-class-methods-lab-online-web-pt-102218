class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    Boat.order(length: :desc).first.classifications
    # id = Boat.order(:length).last
    # classification = BoatClassification.where(boat_id: id.id).first
    # ids = BoatClassification.where(boat_id: id.id).map{|i| i.classification_id}
    # ids.map {|i| Classification.find(i)}
  end
end
