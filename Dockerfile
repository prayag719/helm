FROM python:3.14.0a3-alpine3.21
WORKDIR /src
COPY . .
RUN pip3 install flask
EXPOSE 4000
CMD python3 server.py
