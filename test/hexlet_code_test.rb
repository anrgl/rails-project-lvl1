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

  def test_form_for_with_url_and_name_input_and_job_textarea
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'John', job: 'hexlet')
    result = HexletCode.form_for(user, url: '/user') do |f|
      f.input :name, class: 'form-name'
      f.input :job, as: :text, cols: 50, rows: 60
      f.submit 'Wow'
    end
    assert_equal result, '<form action="/user" method="post">' \
                         '<label for="name">Name</label>' \
                         '<input type="text" name="name" class="form-name" value="John">' \
                         '<label for="job">Job</label>' \
                         '<textarea cols="50" rows="60" name="job">hexlet</textarea>' \
                         '<input name="commit" type="submit" value="Wow">' \
                         '</form>'
  end
end
