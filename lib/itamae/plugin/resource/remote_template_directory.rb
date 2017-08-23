require 'itamae'
require 'pathname'

module Itamae
  module Plugin
    module Resource
      class RemoteTemplateDirectory < ::Itamae::Resource::RemoteDirectory
        define_attribute :variables, type: Hash, default: {}

        def pre_action
          super

          directory = ::File.expand_path(attributes.source, ::File.dirname(@recipe.path))
          src = ::File.expand_path(directory, ::File.dirname(@recipe.path))

          render_and_send_directory(src)
        end

        def render_and_send_directory(src_path)
          ::Dir[ ::File.join(src_path, '**', '*') ]
            .reject { |p| ::File.directory? p }
            .each { |source_file|
              relative_path = Pathname.new(source_file).relative_path_from(Pathname.new(src_path))
              remote_file = ::File.expand_path(relative_path, @temppath)

              content = ::Itamae::Resource::Template::RenderContext.new(self).render_file(source_file)
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
