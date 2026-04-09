require 'test_helper'

class CompilationTest < Minitest::Test
  def load_paths
    [FontAwesome::Sass.stylesheets_path]
  end

  def test_compile_main_font_awesome_scss
    result = Sass.compile(
      File.join(FontAwesome::Sass.stylesheets_path, '_font-awesome.scss'),
      load_paths: load_paths
    )
    assert result.css.length > 0, "Expected non-empty CSS output"
  end

  def test_compiled_css_contains_fa_classes
    result = Sass.compile(
      File.join(FontAwesome::Sass.stylesheets_path, '_font-awesome.scss'),
      load_paths: load_paths
    )
    assert_match(/\.fa\b/, result.css, "Expected .fa class in compiled CSS")
    assert_match(/\.fa-solid\b/, result.css, "Expected .fa-solid class in compiled CSS")
    assert_match(/\.fa-regular\b/, result.css, "Expected .fa-regular class in compiled CSS")
    assert_match(/\.fa-brands\b/, result.css, "Expected .fa-brands class in compiled CSS")
  end

  def test_compile_individual_partials
    # Partials are compiled with shared dependencies since most
    # depend on functions, variables, and mixins.
    preamble = <<~SCSS
      @import 'font-awesome/functions';
      @import 'font-awesome/variables';
      @import 'font-awesome/mixins';
    SCSS

    partials = %w[
      core sizing fixed-width list bordered-pulled animated
      rotated-flipped stacked icons screen-reader solid regular brands
    ]

    partials.each do |name|
      source = preamble + "@import 'font-awesome/#{name}';"
      result = Sass.compile_string(source, load_paths: load_paths)
      assert result.css.is_a?(String), "Failed to compile partial: #{name}"
    end
  end

  def test_compile_string_with_import
    result = Sass.compile_string(
      "@import 'font-awesome';",
      load_paths: load_paths
    )
    assert result.css.length > 0
  end

  def test_compiled_css_contains_font_face
    result = Sass.compile(
      File.join(FontAwesome::Sass.stylesheets_path, '_font-awesome.scss'),
      load_paths: load_paths
    )
    assert_match(/@font-face/, result.css, "Expected @font-face declarations in compiled CSS")
  end
end
