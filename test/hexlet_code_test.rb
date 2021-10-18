# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/hexlet_code'

class HexletCodeTest < Minitest::Test
  def test_single_tag
    assert_equal HexletCode::Tag.build('br'), '<br>'
  end

  def test_single_tag_with_attributes
    assert_equal HexletCode::Tag.build('input', type: 'submit', value: 'Save'), '<input type="submit" value="Save">'
  end

  def test_pair_tag
    assert_equal HexletCode::Tag.build('label') { 'Email' }, '<label>Email</label>'
  end

  def test_pair_tag_with_attribute
    assert_equal HexletCode::Tag.build('label', for: 'email') { 'Email' }, '<label for="email">Email</label>'
  end

  def test_form_for_without_url
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'John')
    assert_equal HexletCode.form_for(user), '<form action="#" method="post"></form>'
  end

  def test_form_for_with_url
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'John')
    assert_equal HexletCode.form_for(user, url: '/user'), '<form action="/user" method="post"></form>'
  end

  def test_form_for_with_url_and_name_input
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'John')
    result = HexletCode.form_for(user, url: '/user') do |f|
      f.input :name
    end
    assert_equal result, '<form action="/user" method="post"><input name="name" type="text" value="John"></form>'
  end

  def test_form_for_with_url_and_name_input_and_job_textarea
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'John', job: 'hexlet')
    result = HexletCode.form_for(user, url: '/user') do |f|
      f.input :name
      f.input :job, as: :text
    end
    assert_equal result, '<form action="/user" method="post"><input name="name" type="text" value="John"><textarea cols="20" rows="40" name="job">hexlet</textarea></form>'
  end
end
