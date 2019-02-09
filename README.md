# Haitian Identification Sinatra Project

## Objectives

1. Build a full scale Sinatra application that uses:

+ A sqlite database
+ ActiveRecord
+ RESTful routes
+ Sessions
+ Login/Logout

## Overview

The goal of this project is to build  Haitian Identification Sinatra Project Using CRUD.

I this we will be implementing Sinatra and some other gems using multiple objects that interact, including separate classes for User and Identification.

The program will have some restrictions such as, a user should not be able to take any actions (except sign-up), unless they are logged in. Once a user is logged in, they should be able to create, edit and delete their own indentifications, view the indentificaions they have created  as well as view all  other identifiactions created by other user. Howeevr, they should only be able to modify the identification that thay've created, a not others.


The following will be likely how the files will be structured.  It may have some other files added.

├── CONTRIBUTING.md
├── Gemfile
├── Gemfile.lock
├── LICENSE.md
├── README.md
├── Rakefile
├── app
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── identificaions_controller.rb   
│   │   └── users_controller.rb     
│   ├── models
│   │   ├── identication.rb
│   │   └── user.rb
│   └── views
│       ├── index.erb
│       ├── layout.erb
│       ├── identications
│       │   ├── create_identification.erb
│       │   ├── edit_identification.erb
│       │   ├── show_identification.erb
│       │   └── indentications.erb
│       └── users
│           ├── create_user.erb
│           └── login.erb
│           └── show.erbsss
├── config
│   └── environment.rb
├── config.ru
├── db
│   ├── development.sqlite
│   ├── migrate
│   │   ├── create_users.rb
│   │   └── create_identications.rb
│   ├── schema.rb
│   └── test.sqlite
└── spec
    ├── controllers
    │   └── application_controller_spec.rb
    ├── models
    │   └── user_spec.rb
    └── spec_helper.rb

NOTICE: We will not have any spec files, though it is mentioned here.

- Gemfile and environment.rb

This project will be supported by Bundler and includes a `Gemfile`.

Run bundle install before getting started on the project.


- Models

We wll be creating two models in `app/models`, one `User` model and one `Identication`. Both classes will be inheriting from `ActiveRecord::Base`.

- Migrations

We will be creating two migrations to create the users and the indentifications table.

Users will have the following attributes: username, email, and password, and have many identifications.

Identifiacations will have the following attributes: firstname, lastname, sex, date_of_birth, country_of_birth, naionality, issued_date, expiry_date and belong to a user.


The floowing are the feature or behavior of the project:
 - It will have a homepage
 - It will prompt users to sign up oe sign in
 - Once signed up or logged in, users will have permission to create and view indentifications.
 - Idetification will be shown by id for editing of deleting
 - users will be able to logout the program


To make all this happen, we will be using Sinatra and Bootstrap as framework.
