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

        YAML.dump(differences, StringIO.new).string.sub("---", "")
      end

      def default_config_yml
        YAML.dump(Options.defaults, StringIO.new).string
      end
    end
  end
end
