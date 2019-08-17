require "time"

class ProjectsController < ApplicationController
	include CurrentUserConcern

	def create

		
		if @current_user
			
			new_project_directory = '/home/jeremy/Desktop/grading_app/projects' + '/' + params['project']['name']
			Dir.mkdir(new_project_directory)

			project = Project.create!(
				name: params['project']['name'],
				location: new_project_directory,
				last_modified: Time.now,
				created_by_id: params['project']['user_id']
			)

			if @current_user
				
				render json: {
					status: :created,
					project: project
				}
			else
				render json: { status: 500 }
			end

		else 

			render json: { status: 500 }

		end
	end

	def list 

		if @current_user

			project_list = Project.all;

			if project_list.length > 0

				render json: { 
					success: true,
					projects_available: true,
					projects: project_list 
				}
			else 

				render json: {
					success: false,
					projects_available: false,	
				}

			end
		end
	end

end
