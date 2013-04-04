require 'uri'
class Url < ActiveRecord::Base
  validates_format_of :long_url, :on => :create, :with => URI::regexp(%w(http https))

  belongs_to :user
end
