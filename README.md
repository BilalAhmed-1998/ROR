# Meetup Site

Meetup Site is a simple rails application where user can join different groups as an organizer, presenter or participant.

## Features

- **IMPORT CSV FOR USERS CREATION:** Add csv file to create new users with specific role for new/existing group.
- **CRUD for Groups:** CRUD actions implemented for groups.

## CSV File Format

The CSV file should contain header with columns First Name, Last Name, Group Name, Role and the data. A dummy file format with dummy data is present inside public/csv_file.

## Getting Started

These instructions will help you get the project up and running on your local machine for development and testing purposes.

### Pre-requisites

- Ruby version 3.1.2

### Installation

- Clone repo and open project folder from terminal
- Run `bundle install` to install all dependencies
- Setup database
  - Run `rails db:create`
  - Run `rails db:migrate`
  - Run `rails db:seed`

## Running locally

In the project directory, you can run to start the project:

### `rails s`
