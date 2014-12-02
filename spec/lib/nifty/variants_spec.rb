require 'spec_helper'

RSpec.describe Nifty::Variants do
  using Nifty::Variants

  describe "cases" do
    generative do
      for_every(:variant) { generate(:variant) }
      for_every(:nonvariant) { generate(:nonvariant) }

      it "lets you know if your matches aren't exhaustive" do
        expect {
          cases variant, {}
        }.to raise_error(Nifty::Variants::NonExhaustiveMatches)
      end

      it "can take advantage of an else" do
        expect(
          cases variant,
            else: ->(_) { variant.first }
        ).to eq variant.first
      end

      it "selects the correct variant match" do
        expect(
          cases variant,
            generate(:key) => ->(*_) { false },
            generate(:key) => ->(*_) { false },
            variant.first => ->(*_) { true }
        ).to be true
      end
    end
  end

  describe "is_variant?" do
    generative do
      for_every(:variant) { generate(:variant) }
      for_every(:nonvariant) { generate(:nonvariant) }

      it "returns true for valid variants" do
        expect(is_variant?(variant)).to be true
      end

      it "returns false of invalid variants" do
        expect(is_variant?(nonvariant)).to be false
      end
    end
  end

  Generative.register_generator(:key) do |_|
    Generative.generate(:string, limit: 10).to_sym
  end

  Generative.register_generator(:variant) do |_|
    [Generative.generate(:key), Generative.generate(:order)]
  end

  Generative.register_generator(:nonvariant) do |_|
    generator = Generative.manager.generators.keys.reject { |g|
      g.to_s.match(/variant/)
    }.sample

    Generative.find_and_call(generator, limit: 100)
  end
end
