# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  attr :inputs, :model

  @inputs = ''
  @model = nil
  class Tag
    def self.build(tag_name, options = {})
      tag = options.reduce("<#{tag_name} ") do |acc, (key, value)|
        acc + "#{key}=\"#{value}\" "
      end
      tag = "#{tag.strip}>"
      tag += "#{yield}</#{tag_name}>" if block_given?

      tag
    end

    def self.build_input(name, value, type: 'text', **attrs)
      attrs_h = { type: type, name: name, **attrs }
      attrs_h[:value] = value if value
      Tag.build('input', **attrs_h)
    end

    def self.build_textarea(name, value, **attrs)
      attrs_h = { cols: 20, rows: 40, name: name, **attrs }
      Tag.build('textarea', **attrs_h) { value }
    end

    def self.build_select(name, value, collection = [], **attrs)
      attrs_h = { name: name, **attrs }
      options = collection.map do |option|
        option_attrs = { value: option }
        option_attrs[:selected] = true if option == value
        option_tag = Tag.build('option', **option_attrs) { option }
        option_tag.to_s
      end.join
      Tag.build('select', **attrs_h) { options }
    end

    def self.build_label(name)
      attrs = { for: name }
      Tag.build('label', **attrs) { name.capitalize }
    end
  end

  def self.form_for(model, options = {})
    url = options[:url] || '#'
    method = options[:method] || 'post'
    @model = model
    yield self
    "<form action=\"#{url}\" method=\"#{method}\">#{@inputs}</form>"
  end

  def self.tag_helper(name, as, collection, **attrs)
    case as
    when :input then Tag.build_label(name) + Tag.build_input(name, @model[name], **attrs)
    when :text then Tag.build_label(name) + Tag.build_textarea(name, @model[name], **attrs)
    when :select then Tag.build_label(name) + Tag.build_select(name, @model[name], collection, **attrs)
    else raise ArgumentError, "Wrong input type: '#{as}'"
    end
  end

  def self.input(name, as: :input, collection: [], **attrs)
    return unless @model.members.include?(name)

    @inputs += tag_helper(name, as, collection, **attrs).to_s
  end
end
