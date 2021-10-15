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

  def self.form_for(_model, options = {})
    url = options[:url] || '#'
    form = Tag.build('form', action: url, method: 'post')

    "#{form}</form>"
  end
end
