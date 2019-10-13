FROM python:3.7

LABEL author="Fernando Franca" \
      version="0.0.1" \
      date="2019-10-12" \
      description="Todo web application example with Django and React"

# Ensures that the python output is set straight to the terminal without 
# buffering it first
ENV PYTHONUNBUFFERED 1

# Install required packages for backend (Django) and frontend (React)
RUN pip install django djangorestframework django-cors-headers; \ 
curl -sL https://deb.nodesource.com/setup_12.x | bash - && \ 
apt-get install -y nodejs && apt-get clean && npm install -g create-react-app

ENTRYPOINT ["/tmp/scripts/entrypoint.sh"]
