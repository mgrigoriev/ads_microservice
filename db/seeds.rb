ads_data = [
  {
    id: 1,
    title: "Ad title 1",
    description: "Ad description 1",
    city: "City 1",
    user_id: 5
  },
  {
    id: 2,
    title: "Ad title 2",
    description: "Ad description 2",
    city: "City 1",
    user_id: 6
  },
  {
    id: 3,
    title: "Ad title 3",
    description: "Ad description 3",
    city: "City 2",
    user_id: 7
  }
]

ads_data.each do |ad_data|
  Ad.create(
    id: ad_data[:id],
    title: ad_data[:title],
    description: ad_data[:description],
    city: ad_data[:city],
    user_id: ad_data[:user_id]
  )
end
