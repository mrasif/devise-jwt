class Api::ProfileSerializer < Api::BaseSerializer
  attributes :id, :user_id, :name, :address, :age, :image, :created_at, :updated_at

  private
  def image
    if !object.image?
      "/system/profiles/images/original/missing.png"
    else
      object.image.url
    end
  end
end
