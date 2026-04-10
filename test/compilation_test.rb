require 'test_helper'

class CompilationTest < Minitest::Test
  def load_paths
    [FontAwesome::Sass.stylesheets_path]
  end

  def compile(source)
    engine = SassC::Engine.new(source, load_paths: load_paths, style: :expanded)
    engine.render
  end

  def test_compile_main_font_awesome_scss
    source = "@import 'font-awesome';"
    css = compile(source)
    assert css.length > 0, "Expected non-empty CSS output"
  end

  def test_compiled_css_contains_fa_class
    source = "@import 'font-awesome';"
    css = compile(source)
    assert_match(/\.fa\b/, css, "Expected .fa class in compiled CSS")
  end

  def test_compiled_css_contains_font_face
    source = "@import 'font-awesome';"
    css = compile(source)
    assert_match(/@font-face/, css, "Expected @font-face declarations in compiled CSS")
  end

  def test_compiled_css_contains_icon_classes
    source = "@import 'font-awesome';"
    css = compile(source)
    assert_match(/\.fa-glass/, css, "Expected icon classes in compiled CSS")
  end

  def test_compile_individual_partials
    # Partials compiled with shared dependencies
    preamble = "@import 'font-awesome/variables'; @import 'font-awesome/mixins';"

    partials = %w[
      core larger fixed-width list bordered-pulled
      animated rotated-flipped stacked icons
    ]

    partials.each do |name|
      source = preamble + "@import 'font-awesome/#{name}';"
      css = compile(source)
      assert css.is_a?(String), "Failed to compile partial: #{name}"
    end
  end
end
