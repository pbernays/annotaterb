# frozen_string_literal: true

module AnnotateRb
  class ConfigGenerator
    class << self
      # Returns unset configuration key-value pairs as yaml.
      # Useful when a config file was generated an older version of gem and new
      #   settings get added.
      def unset_config_defaults
        user_defaults = ConfigLoader.load_config
        defaults = Options.defaults

        new_keys = defaults.keys - user_defaults.keys
        differences = defaults.slice(*new_keys)

        to_yaml(differences).sub("---", "")
      end

      def default_config_yml
        to_yaml Options.defaults
      end

      private

      def to_yaml(hash)
        YAML.dump(hash, StringIO.new, stringify_names: true).string
      end
    end
  end
end
