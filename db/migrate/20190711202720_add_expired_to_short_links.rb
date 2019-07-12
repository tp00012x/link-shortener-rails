class AddExpiredToShortLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :short_links, :expired, :boolean, :default => false
  end
end
