class Movies::ShowSerializer < MovieSerializer
  attributes :id, :title, :release_date, :overview, :inventory, :available_inventory

  # def attributes
  #   super.attributes :overview, :inventory, :available_inventory
  # end
end
