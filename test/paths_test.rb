require 'test_helper'

class PathsTest < Minitest::Test
  def test_gem_path_exists
    assert Dir.exist?(FontAwesome::Sass.gem_path)
  end

  def test_assets_path_exists
    assert Dir.exist?(FontAwesome::Sass.assets_path)
  end

  def test_stylesheets_path_exists
    assert Dir.exist?(FontAwesome::Sass.stylesheets_path)
  end

  def test_fonts_path_exists
    assert Dir.exist?(FontAwesome::Sass.fonts_path)
  end

  def test_stylesheets_path_contains_main_scss
    main = File.join(FontAwesome::Sass.stylesheets_path, '_font-awesome.scss')
    assert File.exist?(main), "Expected _font-awesome.scss in stylesheets path"
  end

  def test_fonts_path_contains_font_files
    fonts_dir = File.join(FontAwesome::Sass.fonts_path, 'font-awesome')
    woff2_files = Dir.glob(File.join(fonts_dir, '*.woff2'))
    assert woff2_files.length >= 3, "Expected at least 3 woff2 font files, got #{woff2_files.length}"
  end
end
