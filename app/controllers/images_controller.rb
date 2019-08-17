require "time"

class ImagesController < ApplicationController
	include CurrentUserConcern

	def upload

		if @current_user
			puts params
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

end