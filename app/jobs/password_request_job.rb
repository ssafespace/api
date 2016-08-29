class PasswordRequestJob < ApplicationJob
  def run(account_id)
    account = Account.find_by(id: account_id)
    account.password = SecureRandom.random_number(100000..999999)
    client = EasySMS::Client.new
    thread = client.phone_numbers.create
    message = SMS.new(number: account.phone, body: "Enter this value into the prompt: #{account.password}")

    Account.transaction do
      account.save!
      message.complete
    end
  end
end
