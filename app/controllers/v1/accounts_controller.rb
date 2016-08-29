module V1
  class AccountsController < ApplicationController
    def index
      forbidden!
    end

    def show
      authenticate!

      render json: current_account
    end

    def create
      forbidden! if signed_in?

      payload = V1::AccountsCreateSanitizer.new(params)

      if payload.valid?
        account = Account.new(**payload)

        if account.save
          PasswordRequestJob.enqueue(account.id)
          render json: account, status: :created
        else
          render json: account.errors, status: :unprocessable_entity
        end
      else
        bad_request!
      end
    end

    def update
      forbidden!
    end

    def destroy
      forbidden!
    end
  end
end
