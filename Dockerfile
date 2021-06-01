FROM alpine:latest

COPY . /app

WORKDIR /app

RUN apk add --no-cache python3 py3-pip && pip3 install -r requirements.txt

EXPOSE 5000

CMD ["python3", "./app.py"]
