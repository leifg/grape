module Grape
  module Validations
    class MultipleParamsBase < Base
      attr_reader :scoped_params

      def validate!(params)
        @scoped_params = [@scope.params(params)].flatten
        params
      end

      private

      def scope_requires_params
        @scope.required? || scoped_params.any? { |resource_params| resource_params.any? }
      end

      def keys_in_common(resource_params)
        (all_keys & resource_params.stringify_keys.keys).map(&:to_s)
      end

      def all_keys
        attrs.map(&:to_s)
      end
    end
  end
end
