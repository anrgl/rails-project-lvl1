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

  def self.form_for(model, options = {})
    url = options[:url] || '#'
    method = options[:method] || 'post'
    Tag.build('form', action: url, method: method) do
      public_send(:input, :name, model) if block_given?
    end
  end

  def self.input(arg, model, as: nil)
    return "<textarea cols=\"20\" rows=\"40\" name=\"#{arg}\">#{model[arg]}</textarea>" if as

    "<input name=\"#{arg}\" type=\"text\" value=\"#{model[arg]}\">"
  end
end
