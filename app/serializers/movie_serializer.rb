class MovieSerializer < ActiveModel::Serializer
  # attributes :id, :title, :release_date, :overview, :inventory, :available_inventory
  attributes :id, :title, :release_date
end
