module V1
  class ApplicationController < ActionController::API
    attr_accessor :current_account

    private def authenticate
      binding.pry
    end

    private def authenticate!
      unless authenticate
        head :forbidden
      end
    end

    private def signed_in?
      current_account.present?
    end

    private def bad_request!
      head :bad_request
    end
  end
end
