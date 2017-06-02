class ProductsController < ApplicationController
	def index
		if params[:name]
	    render json: Product.where('name LIKE ?', "%#{params[:name]}%")
	  else
	   render json: Product.all	
	  end
	end

	def show
		render json: Product.find(params[:id])	
	end

	def create
		product = Product.new
		product.assign_attributes(product_params)
		if product.save
			render json: product
		else 
 			render nothing: true, status: :bad_request
	  end
	end

	def update
  	product = Product.find(params[:id])
	 
	  if product.update(product_params)
	    render nothing: true, status: :ok
  	else
    	render nothing: true, status: :bad_request
	  end
	end

	def destroy
		product = Product.find(params[:id])
		if product.destroy
			render nothing: true, status: :ok
  	else
    	render nothing: true, status: :bad_request
	  end
	end
	 
	private
	  def product_params
	    params.require(:product).permit(:name, :description)
	  end
end
