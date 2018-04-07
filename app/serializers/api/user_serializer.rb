class Api::UserSerializer < Api::BaseSerializer
  attributes :id, :email
  has_one :profile, key: "profile_attributes"
end
