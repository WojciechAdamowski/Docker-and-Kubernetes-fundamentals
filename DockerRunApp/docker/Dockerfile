##### FROM #####
# Docker file must start with a FROM instruction. Only ARG can be before this. 
# FROM keyword initialize a new build stage and sets the base image. 
# In this case the base image is python in 3.12-slim version
FROM python:3.12-slim AS PYTHON

##### ENV #####
# This instruction sets environment values for all instructions in build stage 

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

##### EXPOSE #####
# The EXPOSE instruction defines which network port is listen by container at runtime.
# The default protocol is TCP which we use now
EXPOSE 5000

##### COPY #####
# The COPY instruction copies the specified file (requirements.txt) or files from the specified directory
# to given location (.)
COPY requirements.txt .
COPY . /app

##### WORKDIR #####
# This instruction sets directory in Dokcer image for RUN, CMD, ENTRYPOINT, COPY and ADD operations.
# In this case we move to App directory
WORKDIR /app

##### RUN #####
# The RUN instruction will execute any commands to create a new layer on top of the current image
# Install pip requirements
RUN python -m pip install -r requirements.txt
# Creates a non-root user with an explicit UID and adds permission to access the /app folder
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app

##### USER #####
# This function sets default user for using into the container
USER appuser

##### CMD #####
# The CMD instruction sets the command to be executed when running a container from an image
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
