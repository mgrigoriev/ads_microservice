class AdSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title,
             :description,
             :city,
             :lat,
             :lon,
             :user_id
end
