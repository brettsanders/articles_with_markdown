class AddRenderedContentToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :rendered_content, :text
  end

  def self.down
    remove_column :articles, :rendered_content
  end
end
