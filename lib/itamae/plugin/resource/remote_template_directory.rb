require 'itamae'
require "itamae/plugin/resource/remote_template_directory/version"

module Itamae
  module Plugin
    module Resource
      module RemoteTemplateDirectory < ::Itamae::Resource::RemoteDirectory
        define_attribute :variables, type: Hash, default: {}

        def pre_action
          super

          directory = ::File.expand_path(attributes.source, ::File.dirname(@recipe.path))
          src = ::File.expand_path(directory, ::File.dirname(@recipe.path))

          render_and_send_directory(src)
        end

        def render_and_send_directory(src)
          ::Dir[ ::File.join('.', '**', '*') ]
            .reject { |p| ::File.directory? p }
            .each { |file|
              source_file = ::File.expand_path(file, src)
              remote_file = ::File.expand_path(file, @temppath)

              content = ::Itemae::Resource::Template::RenderContext.new(self).render_file(source_file)
              local_file = Tempfile.open('itamae')
              local_file.write(content)
              local_file.close
              backend.send_file(local_file.path, remote_file)
            }
        end
      end
    end
  end
end
