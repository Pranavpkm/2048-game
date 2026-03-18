# 2048 Game — CI/CD Pipeline on AWS

I built this project to learn how real companies deploy applications 
automatically. The idea is simple — every time I push code to GitHub, 
AWS takes over and handles everything else. No manual steps, no 
clicking around, just push and it's live.

The 2048 game is just the app I used to practice on. The real project 
is the pipeline around it.

---

## What problem does this solve?

Before I built this, deploying meant:
- Building the Docker image manually
- Pushing it manually
- Updating the server manually
- Taking 1-2 hours every single time

After building this pipeline:
- I push code to GitHub
- Everything else happens automatically in under 5 minutes

That's it. That's the whole point.

---

## Architecture
```
My Mac
  │
  │  git push
  ▼
GitHub
  │
  │  CodePipeline detects the push
  ▼
CodePipeline
  │
  ▼
CodeBuild
  │  reads buildspec.yml
  │  builds Docker image
  │  pushes to ECR
  ▼
ECR
(Docker image stored here)
  │
  ▼
ECS Fargate
(runs the container on AWS servers)
  │
  ▼
Live on the internet
```

---

## Tech I used

- **Docker** — to package the game into a container
- **GitHub** — to store and version my code
- **AWS ECR** — to store the Docker image on AWS
- **AWS ECS Fargate** — to run the container without managing servers
- **AWS CodeBuild** — to automatically build the Docker image
- **AWS CodePipeline** — to connect everything together
- **nginx** — web server that serves the game
- **Ubuntu 22.04** — base OS for the container

---

## How the pipeline works step by step

**Step 1 — I push code to GitHub**
This is the only manual step in the whole process.

**Step 2 — CodePipeline wakes up**
It detects the push within seconds and starts the pipeline automatically.

**Step 3 — CodeBuild builds the image**
It reads my buildspec.yml file and:
- Logs into ECR
- Builds the Docker image
- Tags it with the ECR address
- Pushes it to ECR
- Creates imagedefinitions.json so ECS knows which image to run

**Step 4 — ECS Fargate runs it**
Pulls the new image from ECR, starts the container, assigns a 
public IP. Game is live.

Total time from git push to live: under 5 minutes.

---

## Files in this project
```
2048-game/
├── Dockerfile        → recipe for building the container
├── buildspec.yml     → instructions for CodeBuild
└── README.md         → you are here
```

---

## What I learned building this

- Docker makes apps run the same everywhere — your laptop, AWS, anywhere
- CI/CD removes human error from deployments completely
- AWS services are designed to connect with each other
- ECS Fargate means you never have to touch a server
- Writing a buildspec.yml is how you talk to CodeBuild
- Infrastructure work is not about writing the app —
  it's about making sure the app runs reliably at all times

---

## The game itself

The 2048 game was originally built by Gabriele Cirulli and is open source.
I used it as the application to practice deploying on AWS.
The Dockerfile pulls it directly from his GitHub repo during the build.