require "time"
require 'securerandom'

class ImagesController < ApplicationController
	include CurrentUserConcern

	def upload

		if @current_user

			project = Project.find_by(id: params['data']['project_id'])
			
			image_file_name_full = params['data']['file_name']
			
			extension = image_file_name_full.split('.').last

			image_file_location = project.location+'/'+ Array.new(32){[*"A".."Z", *"0".."9"].sample}.join + '.' + extension;

			encoded_file = params['data']['encoded_image']

			puts encoded_file
			File.open(image_file_location, 'wb') do |f|
  				f.write(Base64.decode64(encoded_file.split(';base64,').last))
			end

			image = Image.create!(
				name: params['data']['file_name'],
				location: image_file_location,
				uploaded_on: Time.now,
				project_id: project.id,
				extension: extension
			)

			render json: {status: 'success'}
				

		else 

			render json: { status: 500 }

		end
	end

	def list 

		if @current_user

			image_set = Image.where(:project_id => params['data']['project_id'])
			
			images = []

			image_set.each do |imagedb|


 				
 				encoded = 'data:image/'+imagedb.extension+';base64,'+Base64.strict_encode64(File.open(imagedb.location).read)

 				puts encoded
 			
 				image = { :id =>imagedb.id,
 						  :name => imagedb.name, 
 						  :project_id => imagedb.project_id, 
 						  :encoded_image => encoded 
 				}

 				images.push(image) 
			end
			
			render json: {images: images}

		else

			render json: { status: 500 }
			
		end

	end

end