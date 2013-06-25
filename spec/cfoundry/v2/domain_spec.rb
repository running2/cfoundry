require "spec_helper"

module CFoundry
  module V2
    describe Domain do
      let(:space) { build(:space) }
      let(:domain) { build(:domain, :spaces => [space]) }

      it "should have a spaces association" do
        expect(domain.spaces).to eq([space])
      end

      describe "#system?" do
        let(:params) { {} }
        let(:domain) { build(:domain, {:owning_organization => nil, client: client}.merge(params)) }
        let(:client) { build(:client) }

        context "when the domain is persisted and has no owning organization" do
          it "returns true" do
            expect(domain.system?).to be_true
          end
        end

        context "when the domain is not persisted" do
          let(:params) { {:guid => nil} }

          it "returns false" do
            expect(domain.system?).to be_false
          end
        end

        context "when the domain has an owning org" do
          let(:params) { {:owning_organization => org} }
          let(:org) { build(:organization) }

          it "returns false" do
            expect(domain.system?).to be_false
          end
        end
      end
    end
  end
end
