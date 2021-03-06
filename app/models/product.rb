class Product < ActiveRecord::Base
	default_scope :order => 'title'
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors[:base]<<"Line items present"
			return false
		end
	end
	validates :title, :description, :image_url, :presence=>true, :uniqueness => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

	validates :image_url, :format => {
				:with => %r{\.(gif|png|jpg)$}i, :message => 'must be a URL for GIF, PNG or JPG image.'}	
end
