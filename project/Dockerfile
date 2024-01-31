# Use the official Python image from the Docker Hub

FROM python:3.8.10-alpine

# Make a new directory to put our code in.

RUN mkdir /code

# Change the working directory.

WORKDIR /code

# Copy to code folder

COPY . /code/

# Install the requirements.
RUN apk update
RUN apk add gcc libc-dev g++ libffi-dev libxml2 unixodbc-dev


RUN apk --no-cache add curl

RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.10.5.1-1_amd64.apk
RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.10.1.1-1_amd64.apk


RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Run the application:

CMD python manage.py runserver 0.0.0.0:8000



RUN apk add --allow-untrusted msodbcsql17_17.10.5.1-1_amd64.apk
RUN apk add --allow-untrusted mssql-tools_17.10.1.1-1_amd64.apk
