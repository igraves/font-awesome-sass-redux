require 'test_helper'

class VersionTest < Minitest::Test
  def test_version_is_defined
    assert_match(/\A\d+\.\d+\.\d+\z/, FontAwesome::Sass::VERSION)
  end
end
