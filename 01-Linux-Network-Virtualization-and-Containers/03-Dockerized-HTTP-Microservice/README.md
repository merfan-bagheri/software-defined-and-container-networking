# Problem 3 (Docker) 20 points

This problem is about Docker. In this problem you write a simple HTTP server and dockerize it. You can use your language of choice for this problem.


Your HTTP server has only one endpoint: **/api/v1/status**. This endpoint must handle GET and POST HTTP methods. When the request method is GET, the server sends this JSON response:

```json
{ "status": "OK" }
```

with status code 200. When the request method is POST with a body like this:

```json
{ "status": "not OK" }
```

The server returns the body:

```json
{ "status": "not OK" }
```

with status code 201. From now on every other GET request is responded with "not OK" status until another POST request changes it to something else. Your server listens on port 8000.

After implementing the web server, write a Dockerfile and build an image for your server. You should be able to create a container from that image and publish its port on your host.

## Deliverables

- The code of your HTTP server.
- A Dockerfile to build a docker image from your code.

## Please note, if you want to run a bash script from your command line interface (CLI), you should first make it executable with this code:
```bash
   chmod +x script.sh
   ```
## Build the Docker image

To build the Docker image of HTTPServer, run this code in the Dockerfile directory:

```
docker build -t http-server .
```

## Run the Docker container

To bind a port on the host (first 8000) to a port inside the Docker container (second 8000):

```
docker run -p 8000:8000 http-server
```

## Get the current status

To send a GET request to get the current status:

```
curl http://localhost:8000/api/v1/status
```

## Update the status

To send a POST request to update the status:

```
curl -X POST -H "Content-Type: application/json" -d '{"status": "not OK"}' http://localhost:8000/api/v1/status
```