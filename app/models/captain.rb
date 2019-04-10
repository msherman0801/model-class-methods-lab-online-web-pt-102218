class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    # catamaran = Classification.where(name: "Catamaran")
    # boats = BoatClassification.where(classification_id: catamaran.ids).map{|i| i.boat_id }
    # boats.map {|id| Boat.find(id).captain }
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    # sailboat = Classification.where(name: "Sailboat")
    # boats = BoatClassification.where(classification_id: sailboat.ids).map{|i| i.boat_id }
    # boats.map {|id| Boat.find(id).captain }.reject(&:nil?).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where('id IN (?)', self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
    # boat_types = Classification.where(name: "Sailboat").or(Classification.where(name: "Motorboat"))
    # boats = BoatClassification.where(classification_id: boat_types.ids).map{|i| i.boat_id }
    # out = boats.map {|id| Boat.find(id).captain }.reject(&:nil?).uniq.map {|i| i.id }
    # out.map {|i| Captain.find_by(id: i, admiral:true)}
  end

  def self.non_sailors
    where.not('id IN (?)', self.sailors.pluck(:id))
  end


end

#7043
