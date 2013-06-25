require "cfoundry/v2/model"

module CFoundry::V2
  class Domain < Model
    attribute :name, :string
    attribute :wildcard, :boolean
    to_one    :owning_organization, :as => :organization, :default => nil
    to_many   :spaces

    queryable_by :name, :owning_organization_guid, :space_guid

    def system?
      guid.present? && !owning_organization.present?
    end
  end
end