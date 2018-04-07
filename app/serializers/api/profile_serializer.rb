class Api::ProfileSerializer < Api::BaseSerializer
  attributes :id, :user_id, :name, :address, :age, :image, :created_at, :updated_at
end
