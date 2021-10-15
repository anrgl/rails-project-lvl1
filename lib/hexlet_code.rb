# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  class Tag
    def self.build(tag_name, options = {})
      tag = options.reduce("<#{tag_name} ") do |acc, (key, value)|
        acc + "#{key}=\"#{value}\" "
      end
      tag = "#{tag.strip}>"
      tag += "#{yield}</#{tag_name}>" if block_given?

      tag
    end
  end

  def form_for(model, url = nil)
    # TODO: before write tests for form_for method
  end
end
