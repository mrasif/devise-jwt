class Api::NoteSerializer < Api::BaseSerializer
  attributes :id, :user_id, :title, :body, :created_at, :updated_at
  # attributes :name

  # def name
  #   object.user.profile.name
  # end

  def created_at
#    object.created_at.strftime("%Y/%m/%d %H:%M:%S")
    (object.created_at + 5.hours + 30.minutes).strftime('%F %T')
  end
  def updated_at
    (object.updated_at + 5.hours + 30.minutes).strftime('%F %T')
  end
end
