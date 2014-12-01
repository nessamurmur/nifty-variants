require 'spec_helper'

RSpec.describe Order do
  describe "#to_variant" do
    generative do
      for_every(:order) { generate(:order) }

      it "returns a tuple-like variant" do
        variant, *obj = order.to_variant
        expect(variant).to eq order.type
        expect(*obj).to eq order
      end
    end
  end
end

RSpec.describe OrderDispatch do
  describe ".dispatch" do
    generative do
      for_every(:order) { generate(:order) }

      let(:method_for) {
        {
          pickup: :store_id,
          digital: :email,
          delivery: :address
        }
      }

      it "returns the proper place" do
        expected_place = order.send(method_for[order.type])

        expect(OrderDispatch.dispatch(order.to_variant)).to eq expected_place
      end

      it "raises an exception for unknown order types" do
        type = generate(:string, limit: 10)
        expect { OrderDispatch.dispatch([type, order]) }.to raise_error
      end
    end
  end
end
