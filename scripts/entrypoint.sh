#!/usr/bin/env bash
#
# @file      entrypoint.sh
# @author    Fernando Franca <https://github.com/furansa>
# @version   0.0.1
# @date      2019-10-12
# @brief     Docker entrypoint script
# @copyright CC BY-NC-SA 3.0
#
# ------------------------------------------------------------------------------
#
# Entrypoint script to be called from Dockerfile ENTRYPOINT section.
#
# ------------------------------------------------------------------------------
#
# History:
#
#  0.0.1, 2019-10-12 - Fernando Franca:
#   - Very first version.
#
# ------------------------------------------------------------------------------
#
# Leave with any command fails
set -e

# Application configuration
APP_ROOT="/home/todo"
APP_BACKEND_ROOT="${APP_ROOT}/backend"
APP_BACKEND_PORT="8000"
APP_FRONTEND_ROOT="${APP_ROOT}/frontend"

# Create the backend project if doesnt exist
if [ ! -d ${APP_BACKEND_ROOT} ]; then
    cd ${APP_ROOT} && django-admin startproject backend && cd backend

    # Create the backend application
    python manage.py startapp todo && python manage.py migrate
fi

# Create the frontend application if doesnt exist
if [ ! -d ${APP_FRONTEND_ROOT} ]; then
    cd ${APP_ROOT} && create-react-app frontend && npm add bootstrap reactstrap axios
fi

# Start the backend application in the background
cd ${APP_BACKEND_ROOT} && python manage.py runserver 0:${APP_BACKEND_PORT} &

# Start the frontend application in the foreground
cd ${APP_FRONTEND_ROOT} && npm start

# Used for debugging if no foreground application is being called
#while true; do
#    date
#    uptime
#    sleep 5
#done
