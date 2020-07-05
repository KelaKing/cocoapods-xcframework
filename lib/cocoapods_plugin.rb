# frozen_string_literal: true

require 'cocoapods-xcframework/command'
require 'cocoapods-core'

module Pod
  # Hook
  class Installer

    class Analyzer
      class AnalysisResult
        alias new_specifications specifications

        def specifications
          origin = new_specifications
          xcframework_hash = Config.instance.xcframework_hash

          delete_subspec(origin)
          origin.each do |spec|
            change_source(spec) if xcframework_hash.key? spec.root.name
          end
          origin
        end

        # Delete subspec where xcframework.
        def delete_subspec(specs)
          specs.delete_if do |spec|
            (Config.instance.xcframework_hash.key? spec.root.name) && spec.subspec?
          end
        end

        # Change source.
        def change_source(spec)
          xcframework_hash = Config.instance.xcframework_hash
          source = xcframework_hash[spec.root.name]
          spec.attributes_hash['source_files'] = []
          spec.attributes_hash['source'] = { http: source }
          spec.attributes_hash['vendored_frameworks'] = "#{spec.root.name}.xcframework"
        end
      end
    end
  end

  module Downloader
    class Request
      alias new_slug slug
      def slug(*args)
        origin = new_slug
        if Config.instance.xcframework_hash.key? name
          origin + '_xcframework'
        else
          origin
        end
      end
    end

    class Cache
      alias new_path_for_spec path_for_spec
      def path_for_spec(*args)
        path = root + 'Specs' + args[0].slug(args[1])
        if Config.instance.xcframework_hash.key? args[0].name
          path.sub_ext('_xcframework.podspec.json')
        else
          path.sub_ext('.podspec.json')
        end
      end
    end
  end

  class Config
    def xcframework_hash
      @xcframework_hash ||= JSON.parse(File.read(xcframework_config_path))
    end

    def xcframework_config_path
      installation_root + 'cocoapods-xcframework.json'
    end
  end
end
