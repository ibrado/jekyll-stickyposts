require "jekyll/stickyposts/version"

module Jekyll
  module StickyPosts
    def self.debug_state(state)
      @debug = state
    end

    def self.info(msg)
      Jekyll.logger.info "StickyPosts:", msg
    end

    def self.debug(msg)
      self.info msg if @debug
    end

    class Generator < Jekyll::Generator
      attr_reader :posts
      priority :low

      def generate(site)
        config = site.config["stickyposts"] || {}
        # Defaults:
        # sort = date
        # reverse = false
        # enabled = true
        # retain = false

        return if !(config["enabled"].nil? || config["enabled"])

        debug = config["debug"]
        StickyPosts::debug_state debug

        sort_field = config["sort"] || 'date'
        sort_reverse = config["reverse"]

        collections = [ config['collection'], config["collections"] ].flatten.compact;
        collections = [ "posts" ] if collections.empty?

        if config["sort"]
          StickyPosts::debug "Sorting by #{sort_field}, reverse: #{sort_reverse ? "true" : "false"}"
        end

        collections.each do |collection|
          sorted = site.collections[collection].docs

          unless config["sort"] == "none"
            sorted.sort! { |docB, docA|
              a = docA.data[sort_field]
              b = docB.data[sort_field]

              if a.nil? && !b.nil?
                -1
              elsif !a.nil? && b.nil?
                1
              end

              if a.respond_to?('to_datetime') && b.respond_to?('to_datetime')
                a.to_datetime <=> b.to_datetime
              end

              a <=> b
            }

            sorted.reverse! if sort_reverse
          end

          remove = config["retain"].nil? || !config["retain"]

          sticky = []
          sorted.delete_if do |doc|
            if doc.data['sticky']
              StickyPosts::debug "\"#{doc.data['title']}\" is sticky, #{remove ? "removing" : "retaining"} copy"
              if remove
                sticky << doc
              else
                copy = Jekyll::Document.new(doc.path, { :site => site,
                  :collection => site.collections[collection]})
                copy.merge_data!(doc.data)
                sticky << copy
              end
              remove
            end
          end

          sticky.reverse! if config["reverse_sticky"]
          sorted.unshift(*sticky)

          order = 0;
          sorted.each do |doc|
            doc.data["stickiness"] = order
            order += 1
          end

          StickyPosts::info "[#{collection}] #{sticky.length} post(s) pinned"
        end
      end
    end
  end
end
