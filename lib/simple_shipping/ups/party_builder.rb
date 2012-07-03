module SimpleShipping::Ups
  # Knows how to convert {Party} model to SOAP element for UPS
  class PartyBuilder < SimpleShipping::Abstract::Builder
    # Builds a hash for Savon which represents {Party party}.
    def build
      contact = @model.contact
      {'v11:Name'          => (contact.person_name || contact.company_name),
       'v11:Phone'         => {'v11:Number' => contact.phone_number},
       'v11:ShipperNumber' => @model.account_number,
       'v11:Address'       => build_address,
       :order!             => ['v11:Name', 'v11:Phone', 'v11:ShipperNumber', 'v11:Address']
      }
    end

    def build_address
      addr = @model.address
      {'v11:AddressLine'       => [addr.street_line, addr.street_line_2, addr.street_line_3].compact,
       'v11:City'              => addr.city,
       'v11:StateProvinceCode' => addr.state_code,
       'v11:PostalCode'        => addr.postal_code,
       'v11:CountryCode'       => addr.country_code,
       :order! => ['v11:AddressLine', 'v11:City', 'v11:StateProvinceCode', 'v11:PostalCode', 'v11:CountryCode']
      }
    end

    def validate
      if @opts[:shipper] && !@model.account_number
        raise SimpleShipping::ValidationError.new("account_number is required for party who is shipper")
      end
    end
  end
end
