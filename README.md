# Welcome to My Api
***

## Task
The goal of this project is to provide a RESTful API for managing earthquake data. The challenge lies in implementing secure user authentication and providing robust data manipulation capabilities while ensuring data integrity and performance.
## Description
This API allows users to authenticate using Doorkeeper OAuth, enabling secure access to the earthquake database. Users can log in, create accounts, and perform CRUD operations on earthquake records. The API is designed to serve both Postman users for testing and a GraphQL interface for convenient browser interaction.

## Installation
1. Prerequisites
    - [Ruby](https://rvm.io/)
    - [PostgreSQL](https://www.postgresql.org/)
    - [Redis](https://redis.io/)

2. Make sure you have the following versions (or compatibles) installed on your machine.
    - Node v20.15.0
    - Yarn 1.22.22
    - ruby 3.1.5p252
    - Rails 7.2.1

To install the project, follow these steps:
1. Clone the repository:
    ```bash
    git clone https://github.com/saminu3110c/my_api.git
    ```
    ```bash
    cd my_api
    ```
2. Install dependencies:
    ```bash
    bundle install
    ```
3. Set up the database:
    ```bash
    rails db:create
    ```
    ```bash
    rails db:migrate
    ```
    ```bash
    rails db:seed
    ```
4. Run the server:
    ```bash
    rails server
    ```
## Usage
### Postman Documentation
1. Authenticate User/Admin to get the access token 
- **Endpoint:** POST /api/v1/oauth/token
- **Parameters:**
    - **grant_type:** password
    - **email:** User's email
    - **password:** User's password
    - **client_id:** Application's id
    - **client_secret:** Application's secret
- **Example Request**
    ```JSON
    {
        "grant_type": "password",
        "email": "saminu3110c@gmail.com",
        "password": "password",
        "client_id": "Application's id",
        "client_secret": "Application's secret"
    }
    ```
- **Example Respond:**
    ```JSON
    {
        "access_token": "The access token",
        "token_type": "Bearer",
        "expires_in": 7200,
        "refresh_token": "The refresh token",
        "created_at": 1728231096
    }
    ```
2. To get the **client_id** and the **client_secret**, follow the following steps
- Open the Rails console:
    ```bash
    rails console
    ```
- Retrieve the Client ID and Secret
    ```bash
    app = Doorkeeper::Application.last
    ```
    ```bash
    app.uid # This is the client ID
    ```
    ```bash
    app.secret # This is the client secret
    ```
3. Create User (None Admin User)
- **Endpoint:** POST /api/v1/users 
- **Parameters:** Provide necessary user details in the request body.
    - **email:** User's email
    - **password:** User's password
    - **client_id:** Application's id
- **Description:** This endpoint allows for the creation of a new user account.
- **Example Request:** 
    ```JSON
    {
        "email": "user@gmail.com",
        "password": "password",
        "client_id": "Application's id"
    }
    ```
- **Example Response:**
    ```JSON
    {
        "id": 3,
        "email": "user@gmail.com",
        "role": "user",
        "access_token": "0iR7Yo11KQ49nxvYDkjngyJP55uTvOlscS6rv2rtnzQ",
        "token_type": "Bearer",
        "expires_in": 7200,
        "refresh_token": "ceb070638397c9831f26f6e29de920f17ebba311b75e4a41777ef5b753328bec",
        "created_at": 1728209879
    }
    ```
4. Access Earthquake Data
- **Endpoint:** GET /api/v1/earthquakes
- **Headers:**
    - Authorization: Bearer <access_token>
- **Description:** Fetch a list of earthquake records with pagination (max 20 elements per page). Use the access token obtained from the authentication step. 
5. Set Up Authorization in Postman
- In Postman, for each request (create, update, delete), set the Authorization header:
    - Click on the **Authorization** tab.
    - Under **Type**, select **Bearer Token**.
    - Paste the access token you received from the login request.
6. Create a New Earthquake Record
    - **Endpoint:**
    ```
    POST /api/v1/earthquakes
    ```
    - **Headers:**

    ```JSON
    {
        "Content-Type": "application/json",
        "Authorization": "Bearer <your_access_token>"
    }
    ```
    - **Request Body:**
    ```JSON
    {
        "earthquake": {
            "location": "Test location",
            "magnitude": 7.1,
            "depth": 10.0,
            "occurred_at": "2024-01-01T12:00:00Z"
        }
    }
    ```
    - **Response:** You should receive a 201 Created response if successful, with the newly created earthquake record as the following.
    ```json
    {
        "id": 8925,
        "location": "Test location",
        "magnitude": 7.1,
        "depth": 10.0,
        "occurred_at": "2024-01-01T12:00:00.000Z",
        "created_at": "2024-10-09T21:16:35.816Z",
        "updated_at": "2024-10-09T21:16:35.816Z"
    }
    ```
7. Update an Existing Earthquake Record
    - **Endpoint:**
    ```
    PUT /api/v1/earthquakes/:id
    ```
    Replace **:id** with the ID of the earthquake record you want to update.
    - **Headers:**
    ```json
        {
            "Content-Type": "application/json",
            "Authorization": "Bearer <your_access_token>"
        }
    ```
    - **Request Body:**
    ```json
        {
            "earthquake": {
                "magnitude": 6.5
            }
        }
    ```
    - **Response:** You should receive a 200 OK response if the update was successful, along with the updated earthquake record as the following.
    ```json
        {
            "magnitude": 6.5,
            "id": 8926,
            "location": "Test location",
            "depth": 10.0,
            "occurred_at": "2024-01-01T12:00:00.000Z",
            "created_at": "2024-10-09T21:18:35.224Z",
            "updated_at": "2024-10-09T21:38:31.086Z"
        }
    ```
8. Delete an Earthquake Record
    - **Endpoint:**
    ```
    DELETE /api/v1/earthquakes/:id
    ```
    Replace **:id** with the ID of the earthquake record you want to delete.
    - **Headers:**
    ```json
        {
            "Authorization": "Bearer <your_access_token>"
        }
    ```
    - **Response:** You should receive a 204 No Content response if the deletion was successful.
### Accessing the Hosted version (Postman)
You can access the hosted version of the API via the following link as seen in the postman documentation using all the corresponding enpoints 
    ```bash
    https://mysite-wf6l.onrender.com
    ```
- **Limitation** I have to comment the second line of code (before_action :doorkeeper_authorize!) in the **earthquake_controller.rb** file because I am using a **Free Tier** instance on the **render.com**. So, I don't have access to the render **shell** to get **client_id** and **client_secret** for the user or the admin to have **access_token**. But with the line commented user can fetch, create, update and delete earthquake record.

### GraphQL Interface
1. Accessing the GraphQL Interface
- Navigate to http://localhost:3000/graphiql in your web browser to access the GraphQL interface.
- **Limitation** I couldn't implement the Doorkeeper Oauth to work with the GraphQL Interface but you can locally perform the following queries and mutations on your browser.
2. Query Earthquakes
    - Example Query:
    ```graphql
    query {
        earthquakes {
            id
            location
            magnitude
            depth
            occurredAt
        }
    }
    ```
    - **Description:** This query retrieves a list of all earthquakes from the database with pagination (max 20 elements per page).
    ```graphql
    {
        earthquakes(magnitudeGreaterThan: 5.0) {
            id
            location
            magnitude
            depth
            occurredAt
        }
    }
    ```
    - **Description:** This query retrieves a list of all earthquakes from the database with magnitude greater than a specified value (max 20 elements per page).
3. Create Earthquake
    - Example Mutation:
    ```graphql
    mutation {
        createEarthquake(
            input: {
            location: "California"
            magnitude: 5.8
            depth: 10.5
            occurredAt: "2023-09-15T08:00:00Z"
            }
        ) {
            earthquake {
            id
            location
            magnitude
            depth
            occurredAt
            }
            errors
        }
    }
    ```
4. Update Earthquake Record
- Example Mutation:
    ```graphql
    mutation {
        updateEarthquake(
            input: {
            id: "8924"
            location: "California"
            magnitude: 6.0
            depth: 10.5
            occurredAt: "2023-09-15T08:00:00Z"
            }
        ) {
            earthquake {
            id
            location
            magnitude
            depth
            occurredAt
            }
            errors
        }
    }
    ```
    - **Note** All the fields should be there but do not change the id
4. Delete Earthquake
- Example Mutation:
    ```graphql
    mutation {
        deleteEarthquake(input: { id: "8924" }) {
            earthquake {
                id
            }
            errors
        }
    }
    ```

### Postman Documentation Link
The follow the following link to access the postman documentation
    ```
        https://documenter.getpostman.com/view/38229624/2sAXxQdryu
    ```
### The Core Team
Saminu Isah - isah_s

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering Schools Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
