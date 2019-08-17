class Project < ApplicationRecord
	validates_presence_of :name
	validates_presence_of :location
	validates_presence_of :last_modified
	belongs_to :created_by, class_name: :User
end
