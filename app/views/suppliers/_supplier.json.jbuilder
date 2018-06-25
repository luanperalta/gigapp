json.extract! supplier, :id, :name, :description, :city, :address, :district, :number, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
