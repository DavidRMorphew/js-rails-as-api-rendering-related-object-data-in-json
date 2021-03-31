class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        # render json: sightings, include: [:bird, :location], except: [:created_at, :updated_at]
        render json: sightings.to_json(:include => { 
            :bird => { only: [:name, :species]}, 
            :location => { only: [:latitude, :longitude] } 
            }, :except => [:created_at, :updated_at])
    end
    
    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
            render json: sighting, include: [:bird, :location]
        else
            render json: { message: "No sighting found with that id" }
        end
    end
end
