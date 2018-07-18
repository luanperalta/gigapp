module ApplicationHelper
	def search_helper(controller)
		if controller == "products"
			return { search_type: :name_cont, text: "Nome do Produto" }
		elsif controller == "orders"
			return { search_type: :invoice_cont, text: "Número da nota Fiscal" }
		elsif controller == "suppliers"
			return { search_type: :name_cont, text: "Nome do Fornecedor" }
		elsif controller == "carriers"
			return { search_type: :name_cont, text: "Nome da Transportadora" }	
		end
	end
end
