require "nifty/variants/version"

module Nifty
  module Variants
    class NonExhaustiveMatches < StandardError; end
    class NonVariant < StandardError
      def initialize(msg="variants looks like [:type, some_obj]")
        super(msg)
      end
    end

    refine Object do
      def cases(variant, matches)
        raise NonVariant unless is_variant?(variant)
        type, *obj = variant
        m = matches[type]   ||
            matches[:else]  ||
            (raise NonExhaustiveMatches, ": #{matches.keys}")
        m.call(*obj)
      end

      def is_variant?(variant)
        return false unless variant.is_a?(Array)
        type, *rest = variant
        !rest.empty? && type.is_a?(Symbol)
      end
    end
  end
end
