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
    main = File.join(FontAwesome::Sass.stylesheets_path, 'font-awesome.scss')
    assert File.exist?(main), "Expected font-awesome.scss in stylesheets path"
  end

  def test_fonts_path_contains_font_files
    fonts_dir = File.join(FontAwesome::Sass.fonts_path, 'font-awesome')
    font_files = Dir.glob(File.join(fonts_dir, 'fontawesome-webfont.*'))
    assert font_files.length >= 1, "Expected font files, got #{font_files.length}"
  end
end
