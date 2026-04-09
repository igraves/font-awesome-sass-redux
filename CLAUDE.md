# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

font-awesome-sass is a Ruby gem that packages Font Awesome (currently v6.7.2) as Sass/SCSS assets for Ruby projects, with first-class Rails and Sprockets support. Runtime dependency: `sassc ~> 2.0`.

## Common Commands

```bash
bundle install           # Install dependencies
rake build               # Build the gem package
rake install             # Build and install locally
rake release             # Release to rubygems.org
```

There are no tests or linting configured in this project.

## Architecture

**Entry point:** `lib/font-awesome-sass.rb` — `FontAwesome::Sass.load!` detects the environment (Rails, Sprockets, or standalone Sass) and registers asset paths accordingly.

**Version:** defined in `lib/font_awesome/sass/version.rb` — bump this when updating Font Awesome.

**Rails integration** (`lib/font_awesome/sass/rails/`):
- `engine.rb` — Rails::Engine that registers stylesheets and fonts for asset precompilation
- `railtie.rb` — loads view helpers into ActionView
- `helpers.rb` — provides `icon(style, name, text, html_options)` view helper rendering `<i>` tags

**Assets:**
- `assets/fonts/font-awesome/` — precompiled font files (.ttf, .woff2) for brands, regular, and solid styles
- `assets/stylesheets/` — SCSS partials all imported via `_font-awesome.scss`

## Updating Font Awesome

When updating to a new Font Awesome version: bump the version in `lib/font_awesome/sass/version.rb`, replace font files in `assets/fonts/`, and update SCSS partials in `assets/stylesheets/`. The gemspec auto-discovers assets via `git ls-files`.
