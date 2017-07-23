class Application < ApplicationRecord
  belongs_to :company
	has_many :notes
end
