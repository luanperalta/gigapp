namespace :utils do
  desc "Adiciona mais 10 produtos"
  task generate_products: :environment do
	  puts "Gerando Produtos (Products)"
		10.times do |i|
		Product.create!(
			name: Faker::Commerce.product_name,
			description: Faker::Commerce.department,
			supplier: Supplier.all.sample
			) 
		end
		puts "Gerado. OK"
	  end

	desc "Adiciona mais 10 transportadoras"
  task generate_carriers: :environment do
	  puts "Gerando Transportadoras (carriers)"
		10.times do |i|
		Carrier.create!(
			name: Faker::Company.name
		
		) 
	end
	puts "Gerado. OK"
	end

	desc "Adiciona mais 10 fornecedores"
	task generate_suppliers: :environment do
		puts "Gerando os fornecedores (Suppliers)..."
		10.times do |i|     #cria 10, ou x quantidades de contato contatos
			supplier = Supplier.new(
				name: Faker::Company.name,
				description: Faker::Company.catch_phrase,
				city: Faker::Address.city, 
				address: Faker::Address.street_address,
				district: Faker::Address.community,
				number: Faker::Number.number(2)
			) 
			phones = supplier.phones.build
			Random.rand(1..3).times do |i|
				phones.areacode = Faker::Number.number(2)
				phones.number = Faker::PhoneNumber.phone_number
			end
			
			supplier.save!

			end

			puts "Gerando os E-mails (Emails)..."
			Supplier.all.each do |supplier|     
				Random.rand(0..2).times do |i|
					Email.create!(
						email: Faker::Internet.email,
						reference: Faker::Company.catch_phrase,
						supplier: supplier
					) 
				end	
			end
		puts "Gerado. OK"
	end
end
