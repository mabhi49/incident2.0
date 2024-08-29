FROM python:3.11-bookworm
RUN apt-get -y update && apt-get -y install nginx
COPY ./nginx/nginx.conf /etc/nginx/sites-available/default
COPY ./blog /usr/share/nginx/html/blog
COPY ./portfolio/resume /usr/share/nginx/html/portfolio
# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh
RUN mkdir -p /usr/app/myapp
WORKDIR /usr/app/myapp
COPY ./requirements.txt .
RUN pip install -r requirements.txt
COPY ./incident-main/ .
EXPOSE 80
# Set the entrypoint
CMD ["/entrypoint.sh"]

