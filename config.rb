###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

# Markdown
set :markdown_engine, :redcarpet
set :markdown, :no_intra_emphasis => true, :fenced_code_blocks => true
# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  set :relative_links, true
end

activate :deploy do |deploy|
  deploy.deploy_method   = :sftp
  deploy.host     = 'kabuto.phys.sci.osaka-u.ac.jp'
  deploy.port     = 22
  deploy.path     = 'public_html/j'
  # Optional Settings
  deploy.user     = 'yamaguch' # no default
  #deploy.password = 'secret' # no default
  #deploy.build_before = true # default: false
end
