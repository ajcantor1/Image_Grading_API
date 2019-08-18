require "time"

class ImagesController < ApplicationController
	include CurrentUserConcern

	def upload

		if @current_user

			
			project = Project.find_by(id: params['data']['project_id'])
			
			image_file_name = params['data']['file_name']
			image_file_location = project.location+'/'+image_file_name


			encoded_file = params['data']['encoded_image']

			File.open(image_file_location, 'wb') do |f|
  				f.write(Base64.decode64(encoded_file))
			end


				image = Image.create!(
					name: params['data']['file_name'],
					location: image_file_location,
					uploaded_on: Time.now,
					project_id: project.id
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
 				
 				encoded = Base64.strict_encode64(File.open(imagedb.location).read).split('base64')[1].split('=')[0]+'='
 				puts encoded
 				image = {:id =>imagedb.id,:name => imagedb.name, :project_id => imagedb.project_id, :encoded_image => encoded}
 				images.push(image)
			end
			
			render json: {images: images}

		else

			render json: { status: 500 }
			
		end

	end

end