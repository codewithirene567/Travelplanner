# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - To meet this requirement, I have made the Sinatra gem as my base in my ApplicationController file. Also I am using "shotgun" to start the application which is working through the Sinatra gem.
- [X] Use ActiveRecord for storing information in a database - I am using the ActiveRecord gem as my base in my models. For example, if you look in the user model in this project, my first line is "class User < ActiveRecord::Base." The Active Record is writing the methods for me to create user objects.

- [X] Include more than one model class (e.g. User, Post, Category) - I am using two models with two classes which are a user model and a plan model.

- [X] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - My user model has_many plans as shown in the plan model.

- [X] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - My plan model belongs_to the user model.

- [X] Include user accounts with unique login attribute (username or email) - In my user model, I have written the uniqueness validation to make sure that each username cannot be created twice.

- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - I will give you one example of each route from my Plans controller. The examples are creating: post '/plans' do, Reading: get "/plans/:id" do, Updating: patch "/plans/:id" do and Destroying: delete '/plans/:id' do.

- [X] Ensure that users can't modify content created by other users - They cannot modify content created by other users because they have to have the correct password to get in.

- [X] Include user input validations - I have the following validations from the "has_secure_password" metaprogramming line which creates validate methods so that the input users create can be set to check for specific conditions.
One example of a validation is the line "validates :username, presence: true" found in the user model which is validating that in their input they have to have a username. This means they can't make a profile without one.
Another example is the line "validates :username, uniqueness: true" which is validating that each username is unique and cannot be repeated twice.

- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - I am in the process of doing this.

- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - I have written a read me with all these requirements met, please check my README.md to see the specifics.



Confirm
- [X] You have a large number of small Git commits
- [X] Your commit messages are meaningful
- [X] You made the changes in a commit that relate to the commit message
- [X] You don't include changes in a commit that aren't related to the commit message
