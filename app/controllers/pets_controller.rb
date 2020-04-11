class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all

    erb :'/pets/new'
  end

  post '/pets' do 
    # binding.pry
    pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty?
      pet.create_owner(params[:owner])
      pet.save
    end

    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    pet = Pet.find(params[:id])

    if !params[:owner][:name].empty?
      pet.create_owner(params[:owner])
      pet.save
    else
      pet.update(params[:pet])
    end

    redirect to "pets/#{pet.id}"
  end
end