json.extract! account, :id, :balance, :income, :expenses, :note, :user_id, :created_at, :updated_at
json.url account_url(account, format: :json)
