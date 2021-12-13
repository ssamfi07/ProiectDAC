# ProiectDAC
Proiect Dezvoltarea Aplicatiilor de tip Cloud

## Requirements

* Node 8
* Git
* Contentful CLI (only for write access)

Without any changes, this app is connected to a Contentful space with read-only access. To experience the full end-to-end Contentful experience, you need to connect the app to a Contentful space with read _and_ write access. This enables you to see how content editing in the Contentful web app works and how content changes propagate to this app.

## Common setup

Clone the repo and install the dependencies.

```bash
git clone https://github.com/ssamfi07/ProiectDAC.git
```

```bash
npm install
```

## Steps for read-only access

To start the express server, run the following

```bash
npm run start:dev
```

Open [http://localhost:3000](http://localhost:3000) and take a look around.


## Start the server
To start the express server, run the following
```bash
npm run start:dev
```

Or you can use nodemon:
```bash
cd API
nodemon server.js
```


## Use Docker
You can also run this app as a Docker container:

Step 1: Clone the repo

```bash
git clone https://github.com/ssamfi07/ProiectDAC.git
```

Step 2: Build the Docker image

```bash
docker build -t ProiectDAC .
```

Step 3: Run the Docker container locally:

```bash
docker run -p 3000:3000 -d ProiectDAC
```