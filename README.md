# Ads Microservice

Ads Microservice is a Sinatra app that provides API for ads.
Created for Ruby Microservices course.

## How to setup and run

1. Clone repository:

```
git clone https://github.com/mgrigoriev/ads_microservice.git \
    && cd ads_microservice
```

2. Install dependencies and create database:

```
make setup
```

3. Run application:

```
make run
```

4. Usage examples:

**Get ads**
```
curl -v http://127.0.0.1:3000
```

**Create ad**
```
curl -v -X POST -H "Content-Type: application/json" -d \
'{"ad": {"title": "Title", "description": "Desc", "city": "City", "user_id": 5}}' \
http://127.0.0.1:3000/ads
```

## Run tests

```
make test
```
