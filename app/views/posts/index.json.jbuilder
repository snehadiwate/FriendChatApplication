json.array!(@posts) do |post|
  json.extract! post, :id, :post_text, :user_id, :visible
  json.url post_url(post, format: :json)
end
