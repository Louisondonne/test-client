#  Heroku Client Deployment via Container Registry

This project demonstrates how to simulate a client-side deployment of a prebuilt Docker image (`.tar`) to Heroku using the Heroku Container Registry.

##  Project Overview

You have:
- A Docker image exported to a `.tar` file (e.g. `target-app.tar`)
- A target Heroku app for the client (e.g. `app-client`)

You want to:
- Load the image from the `.tar`
- Tag and push it to the Heroku Container Registry
- Deploy (release) it to the client Heroku app

---

##  Prerequisites

- Docker installed and running
- Heroku CLI installed
- Heroku account (with verified billing if needed)
- Logged into Heroku via CLI:  
  ```bash
  heroku login
  heroku container:login
