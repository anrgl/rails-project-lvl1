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

  def test_form_for_user
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'John')
    assert_equal HexletCode.form_for(user), '<form action="#" method=\"post\"></form>'
  end

  def test_form_for_user_with_url
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'John')
    assert_equal HexletCode.form_for(user, url: '/users'), '<form action="/users" method="post"></form>'
  end
end
