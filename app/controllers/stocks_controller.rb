class StocksController < ApplicationController

  def search
    if stock_params.present?
      @stock = Stock.new_lookup(stock_params)
      if @stock
        respond_to do |format|
          format.js {render @stock}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symble!"
          format.js {render partial: 'stocks/stock'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symble to search"
        format.js {render partial: 'stocks/stock'}
      end
    end
  end


  private

  def stock_params
    params[:stock]
  end

end
