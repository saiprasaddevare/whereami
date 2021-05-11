# This Controller return the data as given in example
class UsersController < ApplicationController
  def whereami
    request_ip = fetch_remote_ip
    country_code = fetch_country_code_for_current_ip(request_ip)
    accepted_language = fetch_accepted_language
    render json: {
                   ip: request_ip,
                   country: country_code,
                   language: accepted_language
                 }
  end

  private

  def fetch_remote_ip
    return nil if request.remote_ip.nil?

    request.remote_ip
  end

  def fetch_country_code_for_current_ip(request_ip)
    return nil if request.remote_ip.nil?

    country_code_response = RestClient.get("https://jsonmock.hackerrank.com/api/ip/#{request_ip}")
    country_code_response_to_json = JSON.parse(country_code_response)
    country_code_response_to_json['country']
  end

  def fetch_accepted_language
    return nil if request.accept_language.nil?

    request.accept_language
  end
end
