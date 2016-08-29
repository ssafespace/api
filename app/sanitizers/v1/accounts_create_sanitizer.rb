module V1
  class AccountsCreateSanitizer
    TYPE = 'accounts'

    attr_reader :type
    attr_reader :attributes
    attr_reader :phone

    def initialize(parameters)
      @type = parameters["data"]["type"]
      @attributes = OpenStruct.new(parameters["data"]["attributes"])
      @phone = attributes.phone
    end

    def valid?
      type == TYPE
    end

    def to_hash
      {
        phone: phone
      }
    end
  end
end
