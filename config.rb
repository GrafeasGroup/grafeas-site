ENV['WEBPACK_ENV'] ||= (build? ? 'build' : 'development')

# Time.zone = "UTC"
set :markdown_engine, :redcarpet
set :markdown,
    layout_engine: :erb,
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    autolink: true,
    disable_indented_code_blocks: true,
    smartypants: true,
    lax_spacing: true

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

set :site_name, 'Grafeas Group'

# Build-specific configuration
configure :build do
  set :trailing_slash, false

  set :protocol, 'https'
  set :host, 'www.grafeas.org'
  set :port, nil

  set :google_analytics_id, 'UA-xxxxxxxx-x'
end

configure :development do
  set :protocol, 'http'
  set :host, 'localhost'
  set :port, 4567

  set :google_analytics_id, 'UA-xxxxxxxx-x'
end

activate :external_pipeline,
         name: :webpack,
         command: if build?
                    'WEBPACK_ENV=build ./node_modules/webpack/bin/webpack.js --bail -p'
                  else
                    "WEBPACK_ENV=#{ENV.fetch('WEBPACK_ENV')} ./node_modules/webpack/bin/webpack.js --watch -d --progress --color"
                  end,
         source: '.tmp/dist',
         latency: 2

###
# Page options, layouts, aliases and proxies
###

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.css', layout: false
page '/*.js', layout: false

###
# Helpers
###

# rubocop:disable Metrics/BlockLength
helpers do
  def phone_number(phone, linkify: false)
    phone = phone.to_s.gsub('[^0-9]', '')[-10, 10]
    label = format('(%s) %s-%s', phone[0...3], phone[3...6], phone[6..9])

    if linkify
      format('<a href="tel:+1%s">%s</a>', phone, label)
    else
      label
    end
  end

  def page_title
    yield_content(:title)
  end

  def page_header(title, summary: nil)
    partial 'partials/page_header', locals: { title: title, summary: summary }
  end

  def section
    (yield_content(:section) || title || '')
  end

  def tor_link(section = :main)
    case section
    when :main
      link_to '/r/TranscribersOfReddit', 'https://reddit.com/r/TranscribersOfReddit'
    when :archive
      link_to '/r/TranscribersOfReddit archives', 'https://reddit.com/r/ToR_Archives'
    else
      tor_link(:main)
    end
  end

  def obfuscated_email(address, mailto=true)
    interim_address = 'spam@example.com'
    obfuscated_address = address.tr('A-Za-z', 'N-ZA-Mn-za-m')

    if mailto
      ('<a href="mailto:%s" data-email="%s">%s</a>' % [interim_address, obfuscated_address, interim_address]).html_safe
    else
      ('<span class="email" data-email="%s">%s</span>' % [obfuscated_address, interim_address]).html_safe
    end
  end

  def to_url(opts = {})
    Addressable::URI.new({
      scheme: config[:protocol],
      host: config[:host],
      port: build? ? config[:port] : nil
    }.merge(opts))
  end

  def current_url
    path = current_page.path
    path = '/' if current_page.path == 'index.html'
    to_url(path: path)
  end

  def image_url(source)
    to_url(path: image_path(source))
  end

  def email_url
    format('mailto:%s', config[:contact_email])
  end

  def tweet_link_to(text, params = {})
    uri = Addressable::URI.parse('https://twitter.com/intent/tweet')
    uri.query_values = params
    link_to text, uri, target: '_blank', rel: 'noopener'
  end

  def current_page_tags
    Array(current_page.data[:tags])
  end
end
