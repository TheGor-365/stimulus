class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]

  def index
    @addresses = Address.all
  end

  def show; end
  def edit; end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to address_url(@address) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to address_url(@address) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url }
    end
  end

  def states
    @target = params[:target]
    @states = CS.get(params[:country]).invert
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:country, :state)
  end
end
