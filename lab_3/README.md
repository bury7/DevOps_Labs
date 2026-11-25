# Task for Lab 3

Continuous Integration with GitHub Actions.

Tools: a typical Python project (for example, a web project), a Docker Hub account (https://hub.docker.com/), a GitHub account and, optionally, Docker for local checks.

1. Analyse the repository https://github.com/dandrushko/python-lab. Pay attention to the `Dockerfile` and the contents of `.github/workflows/sample-ci.yml`.
2. Based on that repository, create for your own Python project:
   - a `Dockerfile`;
   - a `requirements.txt` file with the Python dependencies;
   - a GitHub Actions workflow `.github/workflows/sample-ci.yml`.
3. In the Docker Hub profile settings, create a personal access token ("My Profile" → Edit → "Personal Access Tokens").
4. In the GitHub repository settings (Settings → "Secrets and Variables" → Actions), create the secrets:
   - `DOCKERHUB_USERNAME` — your Docker Hub login;
   - `DOCKERHUB_TOKEN` — the token from the previous step.
5. Make a `git commit` and `git push` and check that the CI run succeeds and the built container is uploaded to Docker Hub.
6. Optional: pull the container to the local machine and run it with `docker run -p 5000:5000 <image name>`.

## Solution

This lab is done in my coursework repository, [Network_Programming_Coursework](https://github.com/bury7/Network_Programming_Coursework). Its Flask web project is the Python project the CI builds, so the files are not copied here. Instead of a `requirements.txt`, the dependencies are declared in `pyproject.toml` and pinned in `uv.lock`, and the Docker image installs them with uv.

| Requirement                       | File in the coursework repository                                                                                                                                                           |
|-----------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Dockerfile`                      | [Dockerfile](https://github.com/bury7/Network_Programming_Coursework/blob/main/Dockerfile)                                                                                                  |
| Python dependencies               | [pyproject.toml](https://github.com/bury7/Network_Programming_Coursework/blob/main/pyproject.toml) and [uv.lock](https://github.com/bury7/Network_Programming_Coursework/blob/main/uv.lock) |
| `.github/workflows/sample-ci.yml` | [sample-ci.yml](https://github.com/bury7/Network_Programming_Coursework/blob/main/.github/workflows/sample-ci.yml)                                                                          |
| CI runs                           | [Actions tab](https://github.com/bury7/Network_Programming_Coursework/actions)                                                                                                              |

The repository has the `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets. Every push to `main` runs the tests, builds the image and pushes it to Docker Hub as [`bury7/network-programming-coursework`](https://hub.docker.com/r/bury7/network-programming-coursework) with the `latest` and commit SHA tags.

To run the published image (the app needs a user, so pass one in):

```bash
docker run -p 5000:5000 -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=password bury7/network-programming-coursework
curl -u admin:password http://127.0.0.1:5000/
```
