class Article < ActiveRecord::Base
  attr_accessible :name, :content, :rendered_content

  before_save :render_body

  # need searchable block for solr
  searchable do
    text :name, :boost => 5 
    text :content, :rendered_content, :publish_month
    string :publish_month
  end

  def publish_month
    created_at.strftime("%B %Y")
  end

  private
  def render_body
    require 'redcarpet'
    # renderer = Redcarpet::Render::HTML.new
    renderer = PygmentizeHTML
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.rendered_content = redcarpet.render self.content
  end

end

class PygmentizeHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    require 'pygmentize'
    Pygmentize.process(code, language)
  end
end
