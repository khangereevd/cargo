class CargoRequestsController < ApplicationController
  include HTTParty

  def new
    @cargo_request = CargoRequest.new
  end

  def create
    @cargo_request = CargoRequest.new(cargo_request_params)
    calculate_distance_and_price(@cargo_request)

    if @cargo_request.save
      redirect_to cargo_request_path(@cargo_request)
    else
      puts "Error saving cargo request: #{@cargo_request.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def show
    @cargo_request = CargoRequest.find(params[:id])
  end

  private

  def cargo_request_params
    params.require(:cargo_request).permit(:first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :departure_point, :destination)
  end

  def calculate_distance_and_price(cargo_request)
    api_key = 'TWNoMtXGKSebPNhC7yeT7PXdmD4CuBJGSjCc49eAXHQOs3V3KCEyPKfKPHS5a0Kw'
    origin = URI.encode_www_form_component(cargo_request.departure_point)
    destination = URI.encode_www_form_component(cargo_request.destination)
    url = "https://api.distancematrix.ai/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&key=#{api_key}"

    response = self.class.get(url)
    data = JSON.parse(response.body)

    if data['status'] == 'OK'
      distance = data['rows'][0]['elements'][0]['distance']['value'] / 1000.0  # расстояние в километрах
      cargo_request.distance = distance
      cargo_request.price = calculate_price(cargo_request)
    else
      puts "Error calculating distance: #{data['status']}"
    end
  end

  def calculate_price(cargo_request)
    if cargo_request.distance < 1
      return 1 * cargo_request.distance
    elsif cargo_request.weight <= 10
      return 2 * cargo_request.distance
    else
      return 3 * cargo_request.distance
    end
  end

end
